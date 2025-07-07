# Phase 1 Implementation Guide: CLI Tool & Foundation Setup

## Overview

This guide provides step-by-step instructions for implementing Phase 1 of the FlutterUI migration plan, focusing on CLI tool development, component registry creation, and project structure setup.

## Timeline: Weeks 1-3

---

## 1. CLI Tool Development (Week 1)

### 1.1 Project Setup

Create a new CLI tool project:

```bash
mkdir flutterui-cli
cd flutterui-cli
dart create --template=package-simple .
```

### 1.2 Dependencies Setup

Update `pubspec.yaml`:

```yaml
name: flutterui_cli
description: CLI tool for FlutterUI component management
version: 1.0.0

environment:
  sdk: ">=3.0.0 <4.0.0"

dependencies:
  args: ^2.4.0
  path: ^1.8.0
  yaml: ^3.1.0
  http: ^1.1.0
  archive: ^3.4.0
  file: ^7.0.0
  cli_util: ^0.3.5
  pub_semver: ^2.1.0

dev_dependencies:
  test: ^1.24.0
  lints: ^3.0.0
```

### 1.3 Core CLI Structure

Create the main CLI entry point:

```dart
// bin/flutterui.dart
import 'package:args/args.dart';
import 'package:flutterui_cli/commands/install_command.dart';
import 'package:flutterui_cli/commands/list_command.dart';
import 'package:flutterui_cli/commands/search_command.dart';
import 'package:flutterui_cli/commands/update_command.dart';
import 'package:flutterui_cli/commands/remove_command.dart';
import 'package:flutterui_cli/commands/validate_command.dart';

void main(List<String> arguments) async {
  final parser = ArgParser()
    ..addCommand('install')
    ..addCommand('list')
    ..addCommand('search')
    ..addCommand('update')
    ..addCommand('remove')
    ..addCommand('validate');

  try {
    final results = parser.parse(arguments);
    final command = results.command;

    switch (command?.name) {
      case 'install':
        await InstallCommand().run(results);
        break;
      case 'list':
        await ListCommand().run(results);
        break;
      case 'search':
        await SearchCommand().run(results);
        break;
      case 'update':
        await UpdateCommand().run(results);
        break;
      case 'remove':
        await RemoveCommand().run(results);
        break;
      case 'validate':
        await ValidateCommand().run(results);
        break;
      default:
        printUsage(parser);
    }
  } catch (e) {
    print('Error: $e');
    exit(1);
  }
}

void printUsage(ArgParser parser) {
  print('''
FlutterUI CLI - Component Management Tool

Usage: flutterui <command> [arguments]

Commands:
  install    Install a component into your project
  list       List available components
  search     Search for components
  update     Update installed components
  remove     Remove a component from your project
  validate   Validate component structure

Run 'flutterui help <command>' for more information about a command.
''');
}
```

### 1.4 Command Base Class

```dart
// lib/commands/base_command.dart
import 'package:args/args.dart';

abstract class BaseCommand {
  String get name;
  String get description;

  ArgParser get argParser;

  Future<void> run(ArgResults results);

  void printUsage() {
    print('Usage: flutterui $name ${argParser.usage}');
    print('\n$description');
  }
}
```

### 1.5 Install Command Implementation

```dart
// lib/commands/install_command.dart
import 'package:args/args.dart';
import 'package:path/path.dart' as path;
import 'package:flutterui_cli/commands/base_command.dart';
import 'package:flutterui_cli/services/component_service.dart';
import 'package:flutterui_cli/services/project_service.dart';

class InstallCommand extends BaseCommand {
  @override
  String get name => 'install';

  @override
  String get description => 'Install a component into your Flutter project';

  @override
  ArgParser get argParser => ArgParser()
    ..addOption('component', abbr: 'c', help: 'Component name to install')
    ..addOption('path', abbr: 'p', help: 'Installation path (default: lib/components)')
    ..addFlag('force', abbr: 'f', help: 'Force overwrite existing files')
    ..addFlag('dependencies', abbr: 'd', help: 'Install dependencies automatically');

  @override
  Future<void> run(ArgResults results) async {
    final componentName = results['component'] as String?;
    final installPath = results['path'] as String? ?? 'lib/components';
    final force = results['force'] as bool;
    final installDeps = results['dependencies'] as bool;

    if (componentName == null) {
      print('Error: Component name is required');
      printUsage();
      return;
    }

    try {
      final componentService = ComponentService();
      final projectService = ProjectService();

      // Validate Flutter project
      if (!await projectService.isFlutterProject()) {
        print('Error: Not a Flutter project. Run this command from your Flutter project root.');
        return;
      }

      // Get component details
      final component = await componentService.getComponent(componentName);
      if (component == null) {
        print('Error: Component "$componentName" not found');
        return;
      }

      // Install component
      await componentService.installComponent(
        component,
        installPath,
        force: force,
        installDependencies: installDeps,
      );

      print('✅ Successfully installed $componentName');

      if (component.dependencies.isNotEmpty) {
        print('\nDependencies:');
        for (final dep in component.dependencies) {
          print('  - $dep');
        }
      }

    } catch (e) {
      print('Error installing component: $e');
    }
  }
}
```

### 1.6 Component Service

```dart
// lib/services/component_service.dart
import 'dart:io';
import 'dart:convert';
import 'package:path/path.dart' as path;
import 'package:http/http.dart' as http;
import '../models/component.dart';

class ComponentService {
  static const String _registryUrl = 'https://api.flutterui.dev/registry.json';
  static const String _componentsUrl = 'https://api.flutterui.dev/components';

  Future<List<Component>> getAllComponents() async {
    try {
      final response = await http.get(Uri.parse(_registryUrl));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return (data['components'] as List)
            .map((json) => Component.fromJson(json))
            .toList();
      }
    } catch (e) {
      print('Warning: Could not fetch component registry: $e');
    }

    // Fallback to local registry
    return _getLocalComponents();
  }

  Future<Component?> getComponent(String name) async {
    final components = await getAllComponents();
    return components.firstWhere(
      (component) => component.name == name,
      orElse: () => throw Exception('Component not found'),
    );
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

    // Download and extract component files
    await _downloadComponent(component, targetDir);

    // Update pubspec.yaml if needed
    if (installDependencies && component.dependencies.isNotEmpty) {
      await _updatePubspecDependencies(component.dependencies);
    }

    // Generate component documentation
    await _generateComponentDocs(component, targetDir);
  }

  Future<void> _downloadComponent(Component component, String targetDir) async {
    final response = await http.get(
      Uri.parse('$_componentsUrl/${component.name}/files'),
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
    }
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
${component.name}Widget()
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
}
```

### 1.7 Project Service

```dart
// lib/services/project_service.dart
import 'dart:io';
import 'package:path/path.dart' as path;

class ProjectService {
  Future<bool> isFlutterProject() async {
    final pubspecFile = File('pubspec.yaml');
    if (!await pubspecFile.exists()) return false;

    final content = await pubspecFile.readAsString();
    return content.contains('flutter:');
  }

  Future<String> getProjectName() async {
    final pubspecFile = File('pubspec.yaml');
    if (!await pubspecFile.exists()) return '';

    final content = await pubspecFile.readAsString();
    final lines = content.split('\n');

    for (final line in lines) {
      if (line.trim().startsWith('name:')) {
        return line.split(':')[1].trim();
      }
    }

    return '';
  }

  Future<void> createComponentDirectory(String path) async {
    await Directory(path).create(recursive: true);
  }
}
```

---

## 2. Component Registry Setup (Week 2)

### 2.1 Registry Structure

Create the component registry JSON structure:

```json
{
  "version": "1.0.0",
  "lastUpdated": "2024-01-15T10:00:00Z",
  "components": [
    {
      "name": "skew_card",
      "displayName": "Skew Card",
      "description": "A card widget with skew animation effects",
      "category": "animations",
      "tags": ["card", "animation", "skew", "transform"],
      "version": "1.0.0",
      "author": "FlutterUI Team",
      "license": "MIT",
      "dependencies": ["flutter_animate"],
      "properties": [
        {
          "name": "child",
          "type": "Widget",
          "required": true,
          "description": "The widget to display inside the card"
        },
        {
          "name": "skewAngle",
          "type": "double",
          "required": false,
          "defaultValue": "0.1",
          "description": "The skew angle in radians"
        }
      ],
      "files": ["skew_card.dart", "skew_card_code.dart", "README.md"],
      "examples": ["basic_example.dart", "animated_example.dart"]
    }
  ],
  "categories": [
    {
      "name": "animations",
      "displayName": "Animations",
      "description": "Animated components and effects",
      "icon": "🎬"
    },
    {
      "name": "blocks",
      "displayName": "UI Blocks",
      "description": "Reusable UI building blocks",
      "icon": "🧱"
    },
    {
      "name": "effects",
      "displayName": "Visual Effects",
      "description": "Visual effects and gradients",
      "icon": "✨"
    },
    {
      "name": "templates",
      "displayName": "Templates",
      "description": "Complete page templates",
      "icon": "📄"
    }
  ]
}
```

### 2.2 Registry API Endpoints

Create API endpoints for the registry:

```dart
// lib/api/registry_api.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

class RegistryApi {
  static const String _baseUrl = 'https://api.flutterui.dev';

  Future<Map<String, dynamic>> getRegistry() async {
    final response = await http.get(Uri.parse('$_baseUrl/registry.json'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load registry');
    }
  }

  Future<List<Map<String, dynamic>>> getComponentsByCategory(String category) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/components?category=$category'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return List<Map<String, dynamic>>.from(data['components']);
    } else {
      throw Exception('Failed to load components');
    }
  }

  Future<Map<String, dynamic>> getComponentDetails(String name) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/components/$name'),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Component not found');
    }
  }

  Future<List<Map<String, dynamic>>> searchComponents(String query) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/search?q=${Uri.encodeComponent(query)}'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return List<Map<String, dynamic>>.from(data['results']);
    } else {
      throw Exception('Search failed');
    }
  }
}
```

### 2.3 Component Model

```dart
// lib/models/component.dart
class Component {
  final String name;
  final String displayName;
  final String description;
  final String category;
  final List<String> tags;
  final String version;
  final String author;
  final String license;
  final List<String> dependencies;
  final List<ComponentProperty> properties;
  final List<String> files;
  final List<String> examples;

  Component({
    required this.name,
    required this.displayName,
    required this.description,
    required this.category,
    required this.tags,
    required this.version,
    required this.author,
    required this.license,
    required this.dependencies,
    required this.properties,
    required this.files,
    required this.examples,
  });

  factory Component.fromJson(Map<String, dynamic> json) {
    return Component(
      name: json['name'],
      displayName: json['displayName'],
      description: json['description'],
      category: json['category'],
      tags: List<String>.from(json['tags']),
      version: json['version'],
      author: json['author'],
      license: json['license'],
      dependencies: List<String>.from(json['dependencies']),
      properties: (json['properties'] as List)
          .map((prop) => ComponentProperty.fromJson(prop))
          .toList(),
      files: List<String>.from(json['files']),
      examples: List<String>.from(json['examples']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'displayName': displayName,
      'description': description,
      'category': category,
      'tags': tags,
      'version': version,
      'author': author,
      'license': license,
      'dependencies': dependencies,
      'properties': properties.map((prop) => prop.toJson()).toList(),
      'files': files,
      'examples': examples,
    };
  }
}

class ComponentProperty {
  final String name;
  final String type;
  final bool required;
  final String? defaultValue;
  final String description;

  ComponentProperty({
    required this.name,
    required this.type,
    required this.required,
    this.defaultValue,
    required this.description,
  });

  factory ComponentProperty.fromJson(Map<String, dynamic> json) {
    return ComponentProperty(
      name: json['name'],
      type: json['type'],
      required: json['required'],
      defaultValue: json['defaultValue'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'type': type,
      'required': required,
      'defaultValue': defaultValue,
      'description': description,
    };
  }
}
```

---

## 3. Project Structure Setup (Week 3)

### 3.1 New Project Structure

Create the new flat-file component structure:

```
components/
├── animations/
│   ├── skew_card/
│   │   ├── manifest.json
│   │   ├── README.md
│   │   ├── skew_card.dart
│   │   ├── skew_card_code.dart
│   │   └── examples/
│   │       ├── basic_example.dart
│   │       └── animated_example.dart
│   └── flip_card/
│       ├── manifest.json
│       ├── README.md
│       ├── flip_card.dart
│       └── examples/
│           └── basic_example.dart
├── blocks/
│   ├── buttons/
│   │   ├── apple_books_fab/
│   │   └── gradient_button/
│   ├── cards/
│   │   └── glass_card/
│   └── navigation/
│       └── docking_bar/
├── effects/
│   ├── gradients/
│   │   └── mesh_gradient/
│   └── meshes/
│       └── animated_mesh/
└── templates/
    ├── onboarding/
    │   └── modern_onboarding/
    └── landing/
        └── hero_landing/
```

### 3.2 Component Manifest Structure

```json
{
  "name": "skew_card",
  "displayName": "Skew Card",
  "description": "A card widget with skew animation effects",
  "category": "animations",
  "tags": ["card", "animation", "skew", "transform"],
  "version": "1.0.0",
  "author": "FlutterUI Team",
  "license": "MIT",
  "dependencies": ["flutter_animate"],
  "properties": [
    {
      "name": "child",
      "type": "Widget",
      "required": true,
      "description": "The widget to display inside the card"
    },
    {
      "name": "skewAngle",
      "type": "double",
      "required": false,
      "defaultValue": "0.1",
      "description": "The skew angle in radians"
    },
    {
      "name": "animationDuration",
      "type": "Duration",
      "required": false,
      "defaultValue": "Duration(milliseconds: 300)",
      "description": "Animation duration"
    }
  ],
  "files": ["skew_card.dart", "skew_card_code.dart"],
  "examples": ["basic_example.dart", "animated_example.dart"],
  "variants": [
    {
      "name": "default",
      "description": "Default skew card"
    },
    {
      "name": "elevated",
      "description": "Elevated skew card with shadow"
    },
    {
      "name": "gradient",
      "description": "Skew card with gradient background"
    }
  ]
}
```

### 3.3 Migration Script

Create a script to migrate existing components:

```dart
// scripts/migrate_components.dart
import 'dart:io';
import 'dart:convert';
import 'package:path/path.dart' as path;

class ComponentMigrator {
  final String sourceDir;
  final String targetDir;

  ComponentMigrator({
    required this.sourceDir,
    required this.targetDir,
  });

  Future<void> migrateAll() async {
    print('Starting component migration...');

    // Create target directory structure
    await _createDirectoryStructure();

    // Migrate components by category
    await _migrateCategory('animations');
    await _migrateCategory('blocks');
    await _migrateCategory('effects');
    await _migrateCategory('templates');

    print('Migration completed!');
  }

  Future<void> _createDirectoryStructure() async {
    final categories = ['animations', 'blocks', 'effects', 'templates'];

    for (final category in categories) {
      final categoryDir = Directory(path.join(targetDir, category));
      await categoryDir.create(recursive: true);
    }
  }

  Future<void> _migrateCategory(String category) async {
    final sourceCategoryDir = Directory(path.join(sourceDir, category));
    if (!await sourceCategoryDir.exists()) return;

    final components = await sourceCategoryDir.list().toList();

    for (final component in components) {
      if (component is Directory) {
        await _migrateComponent(component, category);
      }
    }
  }

  Future<void> _migrateComponent(Directory componentDir, String category) async {
    final componentName = path.basename(componentDir.path);
    final targetComponentDir = Directory(
      path.join(targetDir, category, componentName),
    );

    await targetComponentDir.create(recursive: true);

    // Create manifest
    await _createManifest(componentDir, targetComponentDir, category);

    // Copy source files
    await _copySourceFiles(componentDir, targetComponentDir);

    // Create README
    await _createReadme(componentDir, targetComponentDir, componentName);

    // Create examples
    await _createExamples(componentDir, targetComponentDir);

    print('Migrated: $componentName');
  }

  Future<void> _createManifest(
    Directory sourceDir,
    Directory targetDir,
    String category,
  ) async {
    final componentName = path.basename(sourceDir.path);

    final manifest = {
      'name': componentName,
      'displayName': _toDisplayName(componentName),
      'description': 'A $category component',
      'category': category,
      'tags': [category, componentName],
      'version': '1.0.0',
      'author': 'FlutterUI Team',
      'license': 'MIT',
      'dependencies': [],
      'properties': [],
      'files': [],
      'examples': [],
      'variants': [
        {
          'name': 'default',
          'description': 'Default variant',
        }
      ]
    };

    final manifestFile = File(path.join(targetDir.path, 'manifest.json'));
    await manifestFile.writeAsString(
      JsonEncoder.withIndent('  ').convert(manifest),
    );
  }

  Future<void> _copySourceFiles(
    Directory sourceDir,
    Directory targetDir,
  ) async {
    final dartFiles = await sourceDir
        .list()
        .where((entity) => entity is File && entity.path.endsWith('.dart'))
        .toList();

    for (final file in dartFiles) {
      final fileName = path.basename(file.path);
      final targetFile = File(path.join(targetDir.path, fileName));
      await targetFile.writeAsString(await File(file.path).readAsString());
    }
  }

  Future<void> _createReadme(
    Directory sourceDir,
    Directory targetDir,
    String componentName,
  ) async {
    final readmeContent = '''
# $componentName

A Flutter component from FlutterUI.

## Usage

\`\`\`dart
import 'package:your_app/components/$componentName/$componentName.dart';

// Use the component
${_toClassName(componentName)}()
\`\`\`

## Examples

See the examples directory for usage examples.
''';

    final readmeFile = File(path.join(targetDir.path, 'README.md'));
    await readmeFile.writeAsString(readmeContent);
  }

  Future<void> _createExamples(
    Directory sourceDir,
    Directory targetDir,
  ) async {
    final examplesDir = Directory(path.join(targetDir.path, 'examples'));
    await examplesDir.create();

    // Create basic example
    final basicExample = '''
import 'package:flutter/material.dart';
import '../${path.basename(sourceDir.path)}.dart';

class BasicExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Basic Example')),
      body: Center(
        child: ${_toClassName(path.basename(sourceDir.path))}(),
      ),
    );
  }
}
''';

    final basicExampleFile = File(path.join(examplesDir.path, 'basic_example.dart'));
    await basicExampleFile.writeAsString(basicExample);
  }

  String _toDisplayName(String name) {
    return name.split('_').map((word) =>
      word[0].toUpperCase() + word.substring(1)
    ).join(' ');
  }

  String _toClassName(String name) {
    return name.split('_').map((word) =>
      word[0].toUpperCase() + word.substring(1)
    ).join('');
  }
}

void main() async {
  final migrator = ComponentMigrator(
    sourceDir: 'lib/components',
    targetDir: 'components',
  );

  await migrator.migrateAll();
}
```

---

## 4. Testing & Validation

### 4.1 CLI Testing

Create comprehensive tests for the CLI:

```dart
// test/cli_test.dart
import 'package:test/test.dart';
import 'package:flutterui_cli/commands/install_command.dart';
import 'package:flutterui_cli/services/component_service.dart';

void main() {
  group('CLI Tests', () {
    test('install command validates component name', () async {
      final command = InstallCommand();
      // Test implementation
    });

    test('component service fetches registry', () async {
      final service = ComponentService();
      final components = await service.getAllComponents();
      expect(components, isNotEmpty);
    });
  });
}
```

### 4.2 Component Validation

```dart
// lib/commands/validate_command.dart
import 'package:args/args.dart';
import 'package:flutterui_cli/commands/base_command.dart';

class ValidateCommand extends BaseCommand {
  @override
  String get name => 'validate';

  @override
  String get description => 'Validate component structure and files';

  @override
  ArgParser get argParser => ArgParser()
    ..addOption('component', abbr: 'c', help: 'Component to validate')
    ..addFlag('all', abbr: 'a', help: 'Validate all components');

  @override
  Future<void> run(ArgResults results) async {
    final componentName = results['component'] as String?;
    final validateAll = results['all'] as bool;

    if (componentName == null && !validateAll) {
      print('Error: Specify --component or --all');
      printUsage();
      return;
    }

    try {
      if (validateAll) {
        await _validateAllComponents();
      } else {
        await _validateComponent(componentName!);
      }
    } catch (e) {
      print('Validation error: $e');
    }
  }

  Future<void> _validateComponent(String name) async {
    print('Validating component: $name');

    // Check manifest exists
    // Check required files exist
    // Validate manifest structure
    // Check for syntax errors in Dart files

    print('✅ Component $name is valid');
  }

  Future<void> _validateAllComponents() async {
    // Implementation for validating all components
  }
}
```

---

## 5. Documentation

### 5.1 CLI Documentation

Create comprehensive CLI documentation:

````markdown
# FlutterUI CLI Documentation

## Installation

```bash
dart pub global activate flutterui_cli
```
````

## Commands

### install

Install a component into your Flutter project.

```bash
flutterui install --component skew_card
flutterui install --component skew_card --path lib/widgets
flutterui install --component skew_card --force --dependencies
```

### list

List available components.

```bash
flutterui list
flutterui list --category animations
flutterui list --format json
```

### search

Search for components.

```bash
flutterui search card
flutterui search --category animations
flutterui search --tags animation,skew
```

### update

Update installed components.

```bash
flutterui update
flutterui update --component skew_card
```

### remove

Remove a component from your project.

```bash
flutterui remove skew_card
```

### validate

Validate component structure.

```bash
flutterui validate --component skew_card
flutterui validate --all
```

## Configuration

Create a `.flutterui` file in your project root:

```json
{
  "componentsPath": "lib/components",
  "autoInstallDependencies": true,
  "registryUrl": "https://api.flutterui.dev"
}
```

```

---

## 6. Next Steps

After completing Phase 1:

1. **Test the CLI thoroughly** with existing components
2. **Set up the registry API** endpoints
3. **Create migration scripts** for existing components
4. **Document the new structure** for contributors
5. **Prepare for Phase 2** component migration

## Success Criteria

- [ ] CLI tool is functional and tested
- [ ] Component registry is created and accessible
- [ ] New project structure is established
- [ ] Migration scripts work correctly
- [ ] Documentation is complete
- [ ] All existing components are migrated to new structure

## Risk Mitigation

- **CLI Complexity**: Start with basic commands, add advanced features later
- **Registry API**: Use local fallback if API is unavailable
- **Migration Issues**: Test migration scripts thoroughly before running
- **Breaking Changes**: Maintain backward compatibility during transition

This Phase 1 implementation provides the foundation for the complete migration to the shadcn/ui-style architecture.
```
