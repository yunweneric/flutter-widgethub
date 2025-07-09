import 'dart:io';
import 'dart:convert'; // Added for jsonDecode
import 'package:flutterui_cli/utils/logger.dart';
import 'package:path/path.dart' as path;
import 'package:http/http.dart' as http;

class DownloadService {
  static const String _githubRepo = 'yunweneric/flutter-widgethub';
  static const String _githubRawBase = 'https://raw.githubusercontent.com/$_githubRepo/main';

  /// Download a component to the specified directory
  Future<void> downloadComponent(
    Map<String, dynamic> component,
    Directory outputDirectory, {
    bool force = false,
    bool includeDependencies = false,
    required Logger logger,
  }) async {
    final componentId = component['id'] as String;
    final githubPath = component['githubPath'] as String?;
    final category = component['category'] as String?;

    if (githubPath == null) {
      logger.error('Component does not have a GitHub path');
      return;
    }

    // Determine the component directory based on the current Flutter project structure
    Directory componentDir;
    if (category != null && category.toLowerCase() == 'templates') {
      // Place in lib/components/<template_name>/
      final templateName = componentId;
      componentDir = await _getTemplateDirectory(outputDirectory, templateName, logger);
    } else {
      // Place in lib/components/
      componentDir = await _getWidgetDirectory(outputDirectory, logger);
    }

    // Check if component directory already exists (only for templates)
    if (category != null && category.toLowerCase() == 'templates') {
      if (componentDir.existsSync() && !force) {
        logger.warning('Template directory already exists: ${componentDir.path}');
        logger.info('Use --force to overwrite existing files');
        return;
      }
    }

    // Create directory if it doesn't exist
    if (!componentDir.existsSync()) {
      componentDir.createSync(recursive: true);
    }

    if (category != null && category.toLowerCase() == 'templates') {
      logger.info('Downloading template: $componentId');
      // Download all *_widget.dart files in the template directory
      await _downloadAllTemplateWidgets(githubPath, componentDir, logger);
    } else {
      logger.info('Downloading widget: $componentId');
      // Download only the main widget file
      await _downloadSingleWidget(githubPath, componentDir, logger);
    }

    // Create README
    await _createReadme(component, componentDir, logger);

    // Create example usage
    await _createExample(component, componentDir, logger);

    // Update dependencies if requested
    if (includeDependencies) {
      await _updateDependencies(component, outputDirectory, logger);
    }

    logger.clearLine();
    logger.success('Component downloaded successfully!');
  }

  /// Get the appropriate component directory in the Flutter project
  Future<Directory> _getComponentDirectory(Directory outputDirectory, String componentId, Logger logger) async {
    // Check if we're in a Flutter project
    final pubspecFile = File(path.join(outputDirectory.path, 'pubspec.yaml'));

    if (pubspecFile.existsSync()) {
      // We're in a Flutter project, create components directory
      final componentsDir = Directory(path.join(outputDirectory.path, 'lib', 'components'));
      if (!componentsDir.existsSync()) {
        componentsDir.createSync(recursive: true);
        logger.info('Created components directory: ${componentsDir.path}');
      }
      return Directory(path.join(componentsDir.path, componentId));
    } else {
      // Not in a Flutter project, create in current directory
      return Directory(path.join(outputDirectory.path, componentId));
    }
  }

  Future<Directory> _getTemplateDirectory(Directory outputDirectory, String templateName, Logger logger) async {
    final pubspecFile = File(path.join(outputDirectory.path, 'pubspec.yaml'));
    if (pubspecFile.existsSync()) {
      final componentsDir = Directory(path.join(outputDirectory.path, 'lib', 'components', templateName));
      if (!componentsDir.existsSync()) {
        componentsDir.createSync(recursive: true);
        logger.info('Created template directory: ${componentsDir.path}');
      }
      return componentsDir;
    } else {
      return Directory(path.join(outputDirectory.path, templateName));
    }
  }

  Future<Directory> _getWidgetDirectory(Directory outputDirectory, Logger logger) async {
    final pubspecFile = File(path.join(outputDirectory.path, 'pubspec.yaml'));
    if (pubspecFile.existsSync()) {
      final componentsDir = Directory(path.join(outputDirectory.path, 'lib', 'components'));
      if (!componentsDir.existsSync()) {
        componentsDir.createSync(recursive: true);
        logger.info('Created components directory: ${componentsDir.path}');
      }
      return componentsDir;
    } else {
      return Directory(path.join(outputDirectory.path));
    }
  }

  /// Download component files from GitHub
  Future<void> _downloadComponentFiles(String githubPath, Directory componentDir, Logger logger) async {
    final basePath = path.dirname(githubPath);
    final componentName = path.basename(githubPath).replaceAll('_data.dart', '');

    // List of files to download for each component
    final filesToDownload = [
      '${componentName}_widget.dart',
      '${componentName}_code.dart',
      '${componentName}_setup.dart',
      'data.dart',
    ];

    for (final fileName in filesToDownload) {
      final fileUrl = '$_githubRawBase/lib/components/presentation/$basePath/$fileName';
      final localFile = File(path.join(componentDir.path, fileName));

      try {
        logger.debug('Downloading: $fileUrl');

        final response = await _downloadFile(fileUrl);
        if (response != null) {
          await localFile.writeAsString(response);
          logger.debug('Downloaded: $fileName');
        } else {
          logger.warning('Failed to download: $fileName');
        }
      } catch (e) {
        logger.warning('Error downloading $fileName: $e');
      }
    }

    // Create a barrel file for easy imports
    await _createBarrelFile(componentName, componentDir, logger);
  }

  /// Download all *_widget.dart files in the template directory
  Future<void> _downloadAllTemplateWidgets(String githubPath, Directory componentDir, Logger logger) async {
    final basePath = path.dirname(githubPath);
    final apiUrl = 'https://api.github.com/repos/$_githubRepo/contents/lib/components/presentation/$basePath';
    try {
      final response = await http.get(Uri.parse(apiUrl), headers: {'Accept': 'application/vnd.github.v3+json'});
      if (response.statusCode == 200) {
        final files = (jsonDecode(response.body) as List<dynamic>);
        final widgetFiles = files.where((file) => (file['name'] as String).endsWith('_widget.dart')).toList();

        if (widgetFiles.isEmpty) {
          logger.warning('No widget files found in template');
          return;
        }

        logger.info('Found ${widgetFiles.length} widget files to download');

        for (int i = 0; i < widgetFiles.length; i++) {
          final file = widgetFiles[i];
          final name = file['name'] as String;
          final fileUrl = file['download_url'] as String;
          final localFile = File(path.join(componentDir.path, name));

          // Show progress
          final progress = ((i + 1) / widgetFiles.length * 100).toInt();
          logger.progress('Downloading $name... ($progress%)');

          final content = await _downloadFile(fileUrl);
          if (content != null) {
            await localFile.writeAsString(content);
            logger.debug('Downloaded: $name');
          } else {
            logger.warning('Failed to download: $name');
          }
        }

        logger.clearLine();
        logger.success('Downloaded ${widgetFiles.length} widget files');
      } else {
        logger.warning('Failed to list template files from GitHub');
      }
    } catch (e) {
      logger.warning('Error downloading template widgets: $e');
    }
  }

  /// Download only the main widget file for a single widget
  Future<void> _downloadSingleWidget(String githubPath, Directory componentDir, Logger logger) async {
    final basePath = path.dirname(githubPath);
    final componentName = path.basename(githubPath).replaceAll('_data.dart', '');
    final fileName = '${componentName}_widget.dart';
    final fileUrl = '$_githubRawBase/lib/components/presentation/$basePath/$fileName';
    final localFile = File(path.join(componentDir.path, fileName));

    logger.progress('Downloading $fileName...');

    final content = await _downloadFile(fileUrl);
    if (content != null) {
      await localFile.writeAsString(content);
      logger.clearLine();
      logger.success('Downloaded: $fileName');
    } else {
      logger.clearLine();
      logger.warning('Failed to download: $fileName');
    }
  }

  /// Download a file from GitHub
  Future<String?> _downloadFile(String url) async {
    try {
      final response = await _makeHttpRequest(url);
      if (response.statusCode == 200) {
        return response.body;
      }
    } catch (e) {
      // File not found or network error
    }
    return null;
  }

  /// Make HTTP request with proper headers
  Future<http.Response> _makeHttpRequest(String url) async {
    return await http.get(
      Uri.parse(url),
      headers: {
        'Accept': 'text/plain',
        'User-Agent': 'FlutterWidgetHub-CLI/1.0.0',
      },
    );
  }

  /// Create barrel file for easy imports
  Future<void> _createBarrelFile(String componentName, Directory componentDir, Logger logger) async {
    final className = _toPascalCase(componentName);
    final barrelFile = File(path.join(componentDir.path, '$componentName.dart'));

    final barrelCode = '''
/// $className Component
/// 
/// This file exports the main component for easy importing.
/// 
/// Usage:
/// ```dart
/// import 'package:your_app/components/$componentName.dart';
/// 
/// $className()
/// ```

export '${componentName}_widget.dart';
''';

    await barrelFile.writeAsString(barrelCode);
    logger.debug('Created barrel file: $componentName.dart');
  }

  /// Create README file
  Future<void> _createReadme(
    Map<String, dynamic> component,
    Directory componentDir,
    Logger logger,
  ) async {
    final title = component['title'] as String;
    final description = component['description'] as String;
    final category = component['category'] as String;
    final subcategory = component['subcategory'] as String;
    final platforms = (component['platforms'] as List).join(', ');
    final setup = component['setup'] as String?;
    final githubPath = component['githubPath'] as String;

    final readmeFile = File(path.join(componentDir.path, 'README.md'));
    final readmeContent = '''
# $title

$description

## Details

- **Category**: $category > $subcategory
- **Platforms**: $platforms
- **Source**: [Flutter Widget Hub](https://github.com/yunweneric/flutter-widgethub)
- **GitHub Path**: `lib/components/presentation/$githubPath`

## Setup

${setup ?? 'No additional setup required.'}

## Usage

```dart
import 'package:your_app/components/${component['id']}.dart';

${_toPascalCase(component['id'] as String)}()
```

## Files

- `${component['id']}_widget.dart` - Main component implementation
- `${component['id']}_code.dart` - Component code as string
- `${component['id']}_setup.dart` - Setup instructions
- `data.dart` - Component metadata
- `${component['id']}.dart` - Barrel file for easy imports

## Customization

This component can be customized by modifying the parameters and styling to match your app's design.

## License

This component is part of Flutter Widget Hub and is available under the MIT License.
''';

    await readmeFile.writeAsString(readmeContent);
    logger.debug('Created README.md');
  }

  /// Create example usage file
  Future<void> _createExample(
    Map<String, dynamic> component,
    Directory componentDir,
    Logger logger,
  ) async {
    final componentId = component['id'] as String;
    final className = _toPascalCase(componentId);

    final exampleFile = File(path.join(componentDir.path, 'example.dart'));
    final exampleContent = '''
import 'package:flutter/material.dart';
import '${componentId}_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '${component['title']} Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('${component['title']} Example'),
      ),
      body: const Center(
        child: $className(),
      ),
    );
  }
}
''';

    await exampleFile.writeAsString(exampleContent);
    logger.debug('Created example.dart');
  }

  /// Update project dependencies
  Future<void> _updateDependencies(
    Map<String, dynamic> component,
    Directory projectDir,
    Logger logger,
  ) async {
    final pubspecFile = File(path.join(projectDir.path, 'pubspec.yaml'));

    if (!pubspecFile.existsSync()) {
      logger.warning('pubspec.yaml not found. Skipping dependency updates.');
      return;
    }

    // This is a simplified version. In a real implementation,
    // you would parse the YAML, add dependencies, and write it back
    logger.info('Dependency updates would be applied here');
    logger.debug('Component dependencies: ${component['dependencies'] ?? 'None'}');
  }

  /// Convert kebab-case to PascalCase
  String _toPascalCase(String kebabCase) {
    return kebabCase
        .split('-')
        .map((word) => word.isNotEmpty ? '${word[0].toUpperCase()}${word.substring(1)}' : '')
        .join('');
  }
}
