import 'dart:io';
import 'dart:convert';
import 'package:path/path.dart' as path;
import 'package:http/http.dart' as http;
import '../models/component.dart';

const bool useLocal = true; // Set to false to use remote registry

class ComponentService {
  static const String _remoteRegistryUrl = 'https://api.flutterui.dev/registry.json';
  static const String _remoteComponentsUrl = 'https://api.flutterui.dev/components';
  static const String _localRegistryPath = 'registry/components.json';
  static const String _localComponentsPath = 'components';

  Future<List<Component>> getAllComponents() async {
    if (useLocal) {
      try {
        final file = File(_localRegistryPath);
        if (await file.exists()) {
          final data = json.decode(await file.readAsString());
          return (data['components'] as List).map((json) => Component.fromJson(json)).toList();
        }
      } catch (e) {
        print('Warning: Could not read local registry: $e');
      }
      return [];
    } else {
      try {
        final response = await http.get(Uri.parse(_remoteRegistryUrl));
        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          return (data['components'] as List).map((json) => Component.fromJson(json)).toList();
        }
      } catch (e) {
        print('Warning: Could not fetch remote registry: $e');
      }
      return [];
    }
  }

  Future<Component?> getComponent(String name) async {
    final components = await getAllComponents();
    try {
      return components.firstWhere(
        (component) => component.name == name,
      );
    } catch (e) {
      return null;
    }
  }

  Future<void> installComponent(
    Component component,
    String installPath, {
    bool force = false,
    bool installDependencies = false,
  }) async {
    final projectRoot = Directory.current.path;
    final targetDir = path.join(projectRoot, installPath, component.name);

    // Create target directory
    await Directory(targetDir).create(recursive: true);

    if (useLocal) {
      // Copy files from local component folder
      final sourceDir = Directory(path.join(_localComponentsPath, component.category, component.name));
      if (await sourceDir.exists()) {
        await for (final entity in sourceDir.list(recursive: true)) {
          if (entity is File) {
            final relative = path.relative(entity.path, from: sourceDir.path);
            final dest = File(path.join(targetDir, relative));
            await dest.parent.create(recursive: true);
            await entity.copy(dest.path);
          }
        }
      }
    } else {
      // Download and extract component files from remote
      await _downloadComponent(component, targetDir);
    }

    // Update pubspec.yaml if needed
    if (installDependencies && component.dependencies.isNotEmpty) {
      await _updatePubspecDependencies(component.dependencies);
    }

    // Generate component documentation if not present
    final readmeFile = File(path.join(targetDir, 'README.md'));
    if (!await readmeFile.exists()) {
      await _generateComponentDocs(component, targetDir);
    }
  }

  Future<void> _downloadComponent(Component component, String targetDir) async {
    try {
      final response = await http.get(
        Uri.parse('$_remoteComponentsUrl/${component.name}/files'),
      );

      if (response.statusCode == 200) {
        final files = json.decode(response.body);

        for (final file in files) {
          final filePath = path.join(targetDir, file['path']);
          final content = file['content'];

          // Create directory if needed
          await Directory(path.dirname(filePath)).create(recursive: true);

          // Write file
          await File(filePath).writeAsString(content);
        }
      } else {
        // Fallback: create sample files
        await _createSampleFiles(component, targetDir);
      }
    } catch (e) {
      // Fallback: create sample files
      await _createSampleFiles(component, targetDir);
    }
  }

  Future<void> _createSampleFiles(Component component, String targetDir) async {
    // Create main component file
    final mainFile = File(path.join(targetDir, '${component.name}.dart'));
    await mainFile.writeAsString('''
import 'package:flutter/material.dart';

class ${_toClassName(component.name)} extends StatelessWidget {
  const ${_toClassName(component.name)}({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('${component.displayName}'),
    );
  }
}
''');

    // Create example file
    final examplesDir = Directory(path.join(targetDir, 'examples'));
    await examplesDir.create();

    final exampleFile = File(path.join(examplesDir.path, 'basic_example.dart'));
    await exampleFile.writeAsString('''
import 'package:flutter/material.dart';
import '../${component.name}.dart';

class BasicExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${component.displayName} Example')),
      body: Center(
        child: ${_toClassName(component.name)}(),
      ),
    );
  }
}
''');
  }

  Future<void> _updatePubspecDependencies(List<String> dependencies) async {
    final pubspecFile = File('pubspec.yaml');
    if (!await pubspecFile.exists()) return;

    final content = await pubspecFile.readAsString();
    final lines = content.split('\n');

    // Find dependencies section
    int depsIndex = -1;
    for (int i = 0; i < lines.length; i++) {
      if (lines[i].trim() == 'dependencies:') {
        depsIndex = i;
        break;
      }
    }

    if (depsIndex != -1) {
      // Add new dependencies
      for (final dep in dependencies) {
        if (!content.contains(dep)) {
          lines.insert(depsIndex + 1, '  $dep: ^1.0.0');
        }
      }

      await pubspecFile.writeAsString(lines.join('\n'));
    }
  }

  Future<void> _generateComponentDocs(Component component, String targetDir) async {
    final readmeContent = '''
# ${component.name}

${component.description}

## Usage

\`\`\`dart
import 'package:your_app/components/${component.name}/${component.name}.dart';

// Use the component
${_toClassName(component.name)}()
\`\`\`

## Properties

${component.properties.map((prop) => '- `${prop.name}`: ${prop.description}').join('\n')}

## Examples

See the example files in this directory for usage examples.
''';

    await File(path.join(targetDir, 'README.md')).writeAsString(readmeContent);
  }

  List<Component> _getLocalComponents() {
    // Implementation for local component discovery
    return [];
  }

  String _toClassName(String name) {
    return name.split('_').map((word) => word[0].toUpperCase() + word.substring(1)).join('');
  }
}
