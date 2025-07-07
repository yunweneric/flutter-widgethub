import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutterui/components/core/component_package.dart';

/// Service for installing components from exported packages
class ComponentInstaller {
  static const String _packageExtension = '.fcp';
  static const String _manifestFileName = 'component.json';
  static const String _componentsDir = 'lib/components';
  static const String _assetsDir = 'assets/components';

  /// Installs a component from a package file
  static Future<bool> installComponent(
    String packagePath, {
    String? projectPath,
    bool overwrite = false,
    bool installDependencies = true,
  }) async {
    try {
      final projectDir = projectPath ?? Directory.current.path;

      // Validate package file
      if (!await _validatePackage(packagePath)) {
        throw Exception('Invalid package file: $packagePath');
      }

      // Extract package
      final package = await _extractPackage(packagePath);

      // Validate Flutter project
      if (!await _validateFlutterProject(projectDir)) {
        throw Exception('Not a valid Flutter project: $projectDir');
      }

      // Check if component already exists
      if (!overwrite && await _componentExists(package.id, projectDir)) {
        throw Exception('Component ${package.id} already exists. Use --overwrite to replace.');
      }

      // Install component files
      await _installComponentFiles(package, projectDir);

      // Install dependencies
      if (installDependencies) {
        await _installDependencies(package, projectDir);
      }

      // Update pubspec.yaml
      await _updatePubspecYaml(package, projectDir);

      // Create component index
      await _createComponentIndex(package, projectDir);

      print('✓ Successfully installed ${package.name} (${package.id})');
      return true;
    } catch (e) {
      print('✗ Failed to install component: $e');
      return false;
    }
  }

  /// Validates a package file
  static Future<bool> _validatePackage(String packagePath) async {
    final file = File(packagePath);
    if (!await file.exists()) {
      return false;
    }

    try {
      final content = await file.readAsString();
      final package = ComponentPackage.fromJson(content);
      return package.id.isNotEmpty && package.name.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  /// Extracts package from file
  static Future<ComponentPackage> _extractPackage(String packagePath) async {
    final file = File(packagePath);
    final content = await file.readAsString();
    return ComponentPackage.fromJson(content);
  }

  /// Validates Flutter project structure
  static Future<bool> _validateFlutterProject(String projectPath) async {
    final pubspecFile = File('$projectPath/pubspec.yaml');
    final libDir = Directory('$projectPath/lib');

    return await pubspecFile.exists() && await libDir.exists();
  }

  /// Checks if component already exists
  static Future<bool> _componentExists(String componentId, String projectPath) async {
    final componentDir = Directory('$projectPath/$_componentsDir/$componentId');
    return await componentDir.exists();
  }

  /// Installs component files
  static Future<void> _installComponentFiles(
    ComponentPackage package,
    String projectPath,
  ) async {
    // Create components directory
    final componentsDir = Directory('$projectPath/$_componentsDir');
    await componentsDir.create(recursive: true);

    // Create component directory
    final componentDir = Directory('$projectPath/$_componentsDir/${package.id}');
    await componentDir.create(recursive: true);

    // Install component files
    for (final file in package.files) {
      final filePath = '$projectPath/$_componentsDir/${package.id}/${file.path}';
      final fileDir = Directory(filePath.substring(0, filePath.lastIndexOf('/')));
      await fileDir.create(recursive: true);

      final fileFile = File(filePath);
      await fileFile.writeAsString(_processFileContent(file.content, package));
    }

    // Create component index file
    await _createComponentIndexFile(package, componentDir.path);
  }

  /// Processes file content for installation
  static String _processFileContent(String content, ComponentPackage package) {
    // Replace relative imports with proper package imports
    String processedContent = content;

    // Update import statements
    processedContent = processedContent.replaceAll(
      'import \'../',
      'import \'package:${package.id}/',
    );

    // Add package header
    if (processedContent.contains('import \'package:flutter/material.dart\';')) {
      processedContent = '''
// ${package.name}
// ${package.description}
// 
// Installed by FlutterUI Component Installer
// Version: ${package.version}
// Author: ${package.author}

$processedContent
''';
    }

    return processedContent;
  }

  /// Creates component index file
  static Future<void> _createComponentIndexFile(
    ComponentPackage package,
    String componentDir,
  ) async {
    final indexContent = '''
// ${package.name} - Component Index
// Generated by FlutterUI Component Installer

library ${package.id};

${package.files.where((f) => f.type == 'dart' && f.isMain).map((f) => "export '${f.path}';").join('\n')}

// Component metadata
class ${package.name.replaceAll(' ', '')}Metadata {
  static const String name = '${package.name}';
  static const String description = '${package.description}';
  static const String version = '${package.version}';
  static const String author = '${package.author}';
  static const List<String> categories = ${package.categories};
  static const List<String> platforms = ${package.supportedPlatforms};
  static const List<String> devices = ${package.responsiveDevices};
}
''';

    final indexFile = File('$componentDir/index.dart');
    await indexFile.writeAsString(indexContent);
  }

  /// Installs component dependencies
  static Future<void> _installDependencies(
    ComponentPackage package,
    String projectPath,
  ) async {
    final pubspecFile = File('$projectPath/pubspec.yaml');
    final pubspecContent = await pubspecFile.readAsString();

    // Parse existing pubspec.yaml
    final lines = pubspecContent.split('\n');
    final dependenciesSection = _findDependenciesSection(lines);

    if (dependenciesSection != null) {
      // Add new dependencies
      final newLines = <String>[];
      bool inDependencies = false;

      for (int i = 0; i < lines.length; i++) {
        final line = lines[i];
        newLines.add(line);

        if (line.trim() == 'dependencies:') {
          inDependencies = true;
          continue;
        }

        if (inDependencies && line.trim().startsWith('dev_dependencies:')) {
          // Insert new dependencies before dev_dependencies
          for (final dep in package.dependencies.where((d) => d.type == 'dependencies')) {
            newLines.add('  ${dep.name}: ${dep.version}');
          }
          inDependencies = false;
        }
      }

      // Add dev dependencies
      final devDependencies = package.dependencies.where((d) => d.type == 'dev_dependencies');
      if (devDependencies.isNotEmpty) {
        for (final dep in devDependencies) {
          newLines.add('  ${dep.name}: ${dep.version}');
        }
      }

      await pubspecFile.writeAsString(newLines.join('\n'));
    }
  }

  /// Finds dependencies section in pubspec.yaml
  static int? _findDependenciesSection(List<String> lines) {
    for (int i = 0; i < lines.length; i++) {
      if (lines[i].trim() == 'dependencies:') {
        return i;
      }
    }
    return null;
  }

  /// Updates pubspec.yaml with component information
  static Future<void> _updatePubspecYaml(
    ComponentPackage package,
    String projectPath,
  ) async {
    // This would typically update the pubspec.yaml with component-specific configurations
    // For now, we'll just log the update
    print('ℹ️  Updated pubspec.yaml for ${package.name}');
  }

  /// Creates component index
  static Future<void> _createComponentIndex(
    ComponentPackage package,
    String projectPath,
  ) async {
    final indexFile = File('$projectPath/$_componentsDir/index.dart');

    String indexContent = '';
    if (await indexFile.exists()) {
      indexContent = await indexFile.readAsString();
    } else {
      indexContent = '''
// FlutterUI Components Index
// Generated by FlutterUI Component Installer

library flutterui_components;

''';
    }

    // Add component export
    indexContent += '''
// ${package.name}
export '${package.id}/index.dart';
''';

    await indexFile.writeAsString(indexContent);
  }

  /// Lists installed components
  static Future<List<ComponentPackage>> listInstalledComponents(String projectPath) async {
    final components = <ComponentPackage>[];
    final componentsDir = Directory('$projectPath/$_componentsDir');

    if (!await componentsDir.exists()) {
      return components;
    }

    final componentDirs = await componentsDir.list().where((entity) => entity is Directory).toList();

    for (final dir in componentDirs) {
      final manifestFile = File('${dir.path}/$_manifestFileName');
      if (await manifestFile.exists()) {
        try {
          final content = await manifestFile.readAsString();
          final package = ComponentPackage.fromJson(content);
          components.add(package);
        } catch (e) {
          print('Warning: Could not read manifest for ${dir.path}: $e');
        }
      }
    }

    return components;
  }

  /// Uninstalls a component
  static Future<bool> uninstallComponent(
    String componentId,
    String projectPath,
  ) async {
    try {
      final componentDir = Directory('$projectPath/$_componentsDir/$componentId');

      if (!await componentDir.exists()) {
        throw Exception('Component $componentId not found');
      }

      // Remove component directory
      await componentDir.delete(recursive: true);

      // Update component index
      await _updateComponentIndex(componentId, projectPath);

      print('✓ Successfully uninstalled $componentId');
      return true;
    } catch (e) {
      print('✗ Failed to uninstall component: $e');
      return false;
    }
  }

  /// Updates component index after uninstallation
  static Future<void> _updateComponentIndex(
    String componentId,
    String projectPath,
  ) async {
    final indexFile = File('$projectPath/$_componentsDir/index.dart');

    if (await indexFile.exists()) {
      String content = await indexFile.readAsString();

      // Remove component export
      final lines = content.split('\n');
      final newLines = <String>[];

      bool skipNext = false;
      for (final line in lines) {
        if (line.contains('export \'$componentId/')) {
          skipNext = true;
          continue;
        }

        if (skipNext && line.trim().isEmpty) {
          skipNext = false;
          continue;
        }

        if (!skipNext) {
          newLines.add(line);
        }
      }

      await indexFile.writeAsString(newLines.join('\n'));
    }
  }

  /// Validates component installation
  static Future<bool> validateInstallation(
    String componentId,
    String projectPath,
  ) async {
    try {
      final componentDir = Directory('$projectPath/$_componentsDir/$componentId');
      final manifestFile = File('$projectPath/$_componentsDir/$componentId/$_manifestFileName');
      final indexFile = File('$projectPath/$_componentsDir/$componentId/index.dart');

      return await componentDir.exists() && await manifestFile.exists() && await indexFile.exists();
    } catch (e) {
      return false;
    }
  }

  /// Gets component information
  static Future<ComponentPackage?> getComponentInfo(
    String componentId,
    String projectPath,
  ) async {
    try {
      final manifestFile = File('$projectPath/$_componentsDir/$componentId/$_manifestFileName');

      if (await manifestFile.exists()) {
        final content = await manifestFile.readAsString();
        return ComponentPackage.fromJson(content);
      }

      return null;
    } catch (e) {
      return null;
    }
  }
}
