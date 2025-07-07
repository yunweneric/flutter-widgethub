import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutterui/app/shared/data/models/component.dart';
import 'package:flutterui/components/core/component_package.dart';

/// Service for exporting components into installable packages
class ComponentExporter {
  static const String _packageExtension = '.fcp'; // Flutter Component Package
  static const String _manifestFileName = 'component.json';
  static const String _readmeFileName = 'README.md';
  static const String _changelogFileName = 'CHANGELOG.md';

  /// Exports a component to a package format
  static Future<String> exportComponent(
    Component component, {
    String? outputPath,
    String author = 'FlutterUI',
    String license = 'MIT',
    String? readme,
    String? changelog,
    String? documentation,
  }) async {
    try {
      // Create component package
      final package = _createComponentPackage(
        component,
        author: author,
        license: license,
        readme: readme,
        changelog: changelog,
        documentation: documentation,
      );

      // Generate package files
      final files = await _generatePackageFiles(package, component);

      // Create output directory
      final outputDir = outputPath ?? 'exports/${component.id}';
      await Directory(outputDir).create(recursive: true);

      // Write package files
      await _writePackageFiles(outputDir, package, files);

      // Create compressed package
      final packagePath = await _createCompressedPackage(outputDir, component.id);

      return packagePath;
    } catch (e) {
      throw Exception('Failed to export component: $e');
    }
  }

  /// Creates a component package from an existing component
  static ComponentPackage _createComponentPackage(
    Component component, {
    required String author,
    required String license,
    String? readme,
    String? changelog,
    String? documentation,
  }) {
    return ComponentPackage(
      id: component.id,
      name: component.title,
      version: '1.0.0',
      description: component.description,
      author: author,
      license: license,
      createdAt: component.createdAt,
      updatedAt: component.updatedAt,
      tags: _extractTags(component),
      categories: [
        component.category.describe(),
        component.subcategory.describe(),
      ],
      supportedPlatforms: component.supportedPlatforms.map((platform) => platform.describe()).toList(),
      responsiveDevices: component.responsiveDevices.map((device) => device.describe()).toList(),
      files: [], // Will be populated later
      dependencies: _extractDependencies(component),
      metadata: _createMetadata(component),
      readme: readme ?? _generateDefaultReadme(component),
      changelog: changelog ?? _generateDefaultChangelog(component),
      documentation: documentation,
      repositoryUrl: component.gitHubLink,
    );
  }

  /// Extracts tags from component
  static List<String> _extractTags(Component component) {
    final tags = <String>[];

    // Add category tags
    tags.add(component.category.describe().toLowerCase());
    tags.add(component.subcategory.describe().toLowerCase());

    // Add platform tags
    for (final platform in component.supportedPlatforms) {
      tags.add(platform.describe().toLowerCase());
    }

    // Add device tags
    for (final device in component.responsiveDevices) {
      tags.add(device.describe().toLowerCase());
    }

    return tags;
  }

  /// Extracts dependencies from component
  static List<ComponentDependency> _extractDependencies(Component component) {
    final dependencies = <ComponentDependency>[];

    // Add common Flutter dependencies
    dependencies.add(ComponentDependency(
      name: 'flutter',
      version: '>=3.0.0',
      type: 'dependencies',
      description: 'Flutter SDK',
    ));

    // Add dependencies based on component type
    if (component.category.describe().contains('Animation')) {
      dependencies.add(ComponentDependency(
        name: 'flutter_animate',
        version: '^4.0.0',
        type: 'dependencies',
        description: 'Animation library',
      ));
    }

    if (component.subcategory.describe().contains('Gradient')) {
      dependencies.add(ComponentDependency(
        name: 'mesh',
        version: '^0.4.0',
        type: 'dependencies',
        description: 'Mesh gradient library',
      ));
    }

    return dependencies;
  }

  /// Creates metadata for the component
  static ComponentMetadata _createMetadata(Component component) {
    return ComponentMetadata(
      setupInstructions: component.setup,
      usageExample: _generateUsageExample(component),
      features: _extractFeatures(component),
      minFlutterVersion: '3.0.0',
      minDartVersion: '3.0.0',
    );
  }

  /// Generates usage example for the component
  static String _generateUsageExample(Component component) {
    return '''
```dart
import 'package:flutter/material.dart';
import 'package:your_app/components/${component.id}/${component.id}_widget.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ${component.title.replaceAll(' ', '')}Widget(),
      ),
    );
  }
}
```''';
  }

  /// Extracts features from component
  static List<String> _extractFeatures(Component component) {
    final features = <String>[];

    // Add platform support features
    for (final platform in component.supportedPlatforms) {
      features.add('Supports ${platform.describe()}');
    }

    // Add device support features
    for (final device in component.responsiveDevices) {
      features.add('Responsive on ${device.describe()}');
    }

    // Add category-specific features
    if (component.category.describe().contains('Animation')) {
      features.add('Smooth animations');
    }

    if (component.subcategory.describe().contains('Gradient')) {
      features.add('Beautiful gradients');
    }

    return features;
  }

  /// Generates default README for the component
  static String _generateDefaultReadme(Component component) {
    return '''
# ${component.title}

${component.description}

## Features

${_extractFeatures(component).map((feature) => '- $feature').join('\n')}

## Installation

1. Add the component to your project
2. Install dependencies
3. Import and use the component

## Usage

${_generateUsageExample(component)}

## Platforms

${component.supportedPlatforms.map((platform) => '- ${platform.describe()}').join('\n')}

## License

This component is licensed under the MIT License.
''';
  }

  /// Generates default changelog for the component
  static String _generateDefaultChangelog(Component component) {
    return '''
# Changelog

## [1.0.0] - ${component.createdAt.toIso8601String().split('T')[0]}

### Added
- Initial release of ${component.title}
- ${component.description}

### Features
${_extractFeatures(component).map((feature) => '- $feature').join('\n')}
''';
  }

  /// Generates package files from component
  static Future<List<ComponentFile>> _generatePackageFiles(
    ComponentPackage package,
    Component component,
  ) async {
    final files = <ComponentFile>[];

    // Add main component file
    if (component.codeComponents.isNotEmpty) {
      final mainCode = component.codeComponents.first;
      files.add(ComponentFile(
        path: 'lib/${component.id}_widget.dart',
        content: _processCodeContent(mainCode.code, component),
        type: 'dart',
        isMain: true,
        description: 'Main component widget',
      ));
    }

    // Add setup file
    files.add(ComponentFile(
      path: 'SETUP.md',
      content: component.setup,
      type: 'markdown',
      description: 'Setup instructions',
    ));

    // Add pubspec.yaml
    files.add(ComponentFile(
      path: 'pubspec.yaml',
      content: _generatePubspecYaml(package),
      type: 'yaml',
      description: 'Package configuration',
    ));

    // Add README
    if (package.readme != null) {
      files.add(ComponentFile(
        path: _readmeFileName,
        content: package.readme!,
        type: 'markdown',
        description: 'Component documentation',
      ));
    }

    // Add CHANGELOG
    if (package.changelog != null) {
      files.add(ComponentFile(
        path: _changelogFileName,
        content: package.changelog!,
        type: 'markdown',
        description: 'Version history',
      ));
    }

    return files;
  }

  /// Processes code content for export
  static String _processCodeContent(String code, Component component) {
    // Remove package-specific imports
    String processedCode = code;

    // Replace package imports with relative imports
    processedCode = processedCode.replaceAll(
      'package:flutterui/',
      '../',
    );

    // Add component-specific imports
    processedCode = '''
// ${component.title}
// ${component.description}
// 
// Generated by FlutterUI Component Exporter
// Version: 1.0.0
// Created: ${component.createdAt.toIso8601String()}

import 'package:flutter/material.dart';

$processedCode
''';

    return processedCode;
  }

  /// Generates pubspec.yaml for the component
  static String _generatePubspecYaml(ComponentPackage package) {
    final dependencies = <String, String>{};
    final devDependencies = <String, String>{};

    for (final dep in package.dependencies) {
      if (dep.type == 'dependencies') {
        dependencies[dep.name] = dep.version;
      } else if (dep.type == 'dev_dependencies') {
        devDependencies[dep.name] = dep.version;
      }
    }

    return '''
name: ${package.id}
description: ${package.description}
version: ${package.version}
homepage: ${package.repositoryUrl ?? 'https://github.com/flutterui/components'}

environment:
  sdk: '>=3.0.0 <4.0.0'
  flutter: ">=3.0.0"

dependencies:
  flutter:
    sdk: flutter
${dependencies.entries.map((e) => '  ${e.key}: ${e.value}').join('\n')}

dev_dependencies:
  flutter_test:
    sdk: flutter
${devDependencies.entries.map((e) => '  ${e.key}: ${e.value}').join('\n')}

flutter:
  uses-material-design: true
''';
  }

  /// Writes package files to disk
  static Future<void> _writePackageFiles(
    String outputDir,
    ComponentPackage package,
    List<ComponentFile> files,
  ) async {
    // Write manifest file
    final manifestFile = File('$outputDir/$_manifestFileName');
    await manifestFile.writeAsString(package.toJson());

    // Write component files
    for (final file in files) {
      final filePath = '$outputDir/${file.path}';
      final fileDir = Directory(filePath.substring(0, filePath.lastIndexOf('/')));
      await fileDir.create(recursive: true);

      final fileFile = File(filePath);
      await fileFile.writeAsString(file.content);
    }
  }

  /// Creates a compressed package file
  static Future<String> _createCompressedPackage(String outputDir, String componentId) async {
    final packagePath = '$outputDir/$componentId$_packageExtension';

    // For now, we'll create a simple archive
    // In a real implementation, you might want to use a proper compression library
    final archiveFile = File(packagePath);
    final manifestContent = await File('$outputDir/$_manifestFileName').readAsString();

    await archiveFile.writeAsString(manifestContent);

    return packagePath;
  }

  /// Exports all components to packages
  static Future<List<String>> exportAllComponents(List<Component> components) async {
    final exportedPaths = <String>[];

    for (final component in components) {
      try {
        final path = await exportComponent(component);
        exportedPaths.add(path);
        print('✓ Exported ${component.title} to $path');
      } catch (e) {
        print('✗ Failed to export ${component.title}: $e');
      }
    }

    return exportedPaths;
  }

  /// Creates a component registry file
  static Future<String> createComponentRegistry(List<Component> components) async {
    final registry = {
      'version': '1.0.0',
      'generated': DateTime.now().toIso8601String(),
      'components': components
          .map((c) => {
                'id': c.id,
                'name': c.title,
                'description': c.description,
                'category': c.category.describe(),
                'subcategory': c.subcategory.describe(),
                'platforms': c.supportedPlatforms.map((p) => p.describe()).toList(),
                'devices': c.responsiveDevices.map((d) => d.describe()).toList(),
                'createdAt': c.createdAt.toIso8601String(),
                'updatedAt': c.updatedAt.toIso8601String(),
              })
          .toList(),
    };

    final registryPath = 'exports/component_registry.json';
    final registryFile = File(registryPath);
    await registryFile.parent.create(recursive: true);
    await registryFile.writeAsString(json.encode(registry));

    return registryPath;
  }
}
