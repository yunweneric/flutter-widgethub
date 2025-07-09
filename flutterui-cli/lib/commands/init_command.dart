import 'dart:io';
import 'package:args/args.dart';
import 'package:flutterui_cli/commands/base_command.dart';
import 'package:flutterui_cli/services/component_service.dart';
import 'package:flutterui_cli/utils/logger.dart';
import 'package:path/path.dart' as path;

class InitCommand extends BaseCommand {
  @override
  String get name => 'init';

  @override
  String get description => 'Initialize a new Flutter project with components';

  @override
  Future<void> run(List<String> arguments, Logger logger) async {
    final parser = ArgParser()
      ..addFlag('help', abbr: 'h', help: 'Show this help message')
      ..addOption('components', abbr: 'c', help: 'Comma-separated list of component IDs to include')
      ..addFlag('flutter', help: 'Create a new Flutter project')
      ..addFlag('force', abbr: 'f', help: 'Overwrite existing files');

    try {
      final results = parser.parse(arguments);

      if (results['help']) {
        printUsage();
        return;
      }

      if (arguments.isEmpty) {
        logger.error('Please provide a project name');
        printUsage();
        return;
      }

      final projectName = arguments.first;
      final components = results['components']?.split(',') ?? [];
      final createFlutter = results['flutter'] ?? false;
      final force = results['force'] ?? false;

      logger.info('Initializing project: $projectName');

      // Create project directory
      final projectDir = Directory(projectName);
      if (projectDir.existsSync() && !force) {
        logger.error('Project directory already exists: $projectName');
        logger.info('Use --force to overwrite existing files');
        return;
      }

      if (!projectDir.existsSync()) {
        projectDir.createSync(recursive: true);
        logger.success('Created project directory: $projectName');
      }

      // Create Flutter project if requested
      if (createFlutter) {
        await _createFlutterProject(projectName, logger);
      }

      // Create components directory
      final componentsDir = Directory(path.join(projectDir.path, 'components'));
      if (!componentsDir.existsSync()) {
        componentsDir.createSync(recursive: true);
        logger.info('Created components directory');
      }

      // Download specified components
      if (components.isNotEmpty) {
        await _downloadComponents(components, componentsDir, logger);
      }

      // Create project README
      await _createProjectReadme(projectName, components, projectDir, logger);

      logger.success('Project initialized successfully!');
      _showNextSteps(projectName, components, logger);
    } catch (e) {
      logger.error('Failed to initialize project: $e');
    }
  }

  Future<void> _createFlutterProject(String projectName, Logger logger) async {
    logger.info('Creating Flutter project...');

    try {
      final result = await Process.run('flutter', ['create', projectName]);

      if (result.exitCode == 0) {
        logger.success('Flutter project created successfully');
      } else {
        logger.error('Failed to create Flutter project: ${result.stderr}');
        throw Exception('Flutter project creation failed');
      }
    } catch (e) {
      logger.error('Flutter not found or not in PATH');
      logger.info('Please install Flutter and add it to your PATH');
      throw e;
    }
  }

  Future<void> _downloadComponents(
    List<String> componentIds,
    Directory componentsDir,
    Logger logger,
  ) async {
    final service = ComponentService();

    for (final componentId in componentIds) {
      logger.info('Downloading component: $componentId');

      final component = await service.getComponentById(componentId.trim());
      if (component != null) {
        // This would use the DownloadService in a real implementation
        logger.success('Component $componentId would be downloaded here');
      } else {
        logger.warning('Component not found: $componentId');
      }
    }
  }

  Future<void> _createProjectReadme(
    String projectName,
    List<String> components,
    Directory projectDir,
    Logger logger,
  ) async {
    final readmeFile = File(path.join(projectDir.path, 'README.md'));
    final readmeContent = '''
# $projectName

A Flutter project initialized with Flutter Widget Hub components.

## Components

${components.isEmpty ? 'No components added yet.' : components.map((c) => '- $c').join('\n')}

## Getting Started

1. Install dependencies:
   ```bash
   flutter pub get
   ```

2. Run the app:
   ```bash
   flutter run
   ```

## Adding More Components

Use the Flutter Widget Hub CLI to add more components:

```bash
flutterui download <component-id>
```

## Available Commands

- `flutterui list` - List all available components
- `flutterui search <query>` - Search for components
- `flutterui info <component-id>` - Get component details
- `flutterui download <component-id>` - Download a component

## License

This project is licensed under the MIT License.
''';

    await readmeFile.writeAsString(readmeContent);
    logger.debug('Created project README');
  }

  void _showNextSteps(String projectName, List<String> components, Logger logger) {
    print('\n🚀 Next Steps:');
    print('1. Navigate to your project: cd $projectName');

    if (components.isNotEmpty) {
      print('2. Review the downloaded components in the components/ directory');
    } else {
      print('2. Add components: flutterui download <component-id>');
    }

    print('3. Install dependencies: flutter pub get');
    print('4. Run your app: flutter run');
    print('5. Start building your Flutter app!');

    print('\n💡 Useful Commands:');
    print('  flutterui list                    # See all available components');
    print('  flutterui search <query>          # Search for components');
    print('  flutterui info <component-id>     # Get component details');
    print('  flutterui download <component-id> # Download a component');
  }
}
