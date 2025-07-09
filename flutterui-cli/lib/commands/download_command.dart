import 'dart:io';
import 'package:args/args.dart';
import 'package:flutterui_cli/commands/base_command.dart';
import 'package:flutterui_cli/services/component_service.dart';
import 'package:flutterui_cli/services/download_service.dart';
import 'package:flutterui_cli/utils/logger.dart';
import 'package:path/path.dart' as path;

class DownloadCommand extends BaseCommand {
  @override
  String get name => 'download';

  @override
  String get description => 'Download a component to your project';

  @override
  Future<void> run(List<String> arguments, Logger logger) async {
    final parser = ArgParser()
      ..addFlag('help', abbr: 'h', help: 'Show this help message')
      ..addOption('output', abbr: 'o', help: 'Output directory (default: current directory)')
      ..addFlag('force', abbr: 'f', help: 'Overwrite existing files')
      ..addFlag('dependencies', help: 'Include dependency updates');

    try {
      final results = parser.parse(arguments);

      if (results['help']) {
        printUsage();
        return;
      }

      if (arguments.isEmpty) {
        logger.error('Please provide a component ID');
        printUsage();
        return;
      }

      final componentId = arguments.first;
      final outputDir = results['output'] ?? Directory.current.path;
      final force = results['force'] ?? false;
      final includeDependencies = results['dependencies'] ?? false;

      logger.info('Downloading component: $componentId');

      final service = ComponentService();
      final component = await service.getComponentById(componentId);

      if (component == null) {
        logger.error('Component not found: $componentId');
        logger.info('Use "flutterui list" to see available components');
        return;
      }

      final downloadService = DownloadService();

      // Create output directory if it doesn't exist
      final outputDirectory = Directory(outputDir);
      if (!outputDirectory.existsSync()) {
        outputDirectory.createSync(recursive: true);
        logger.info('Created output directory: $outputDir');
      }

      // Download the component
      await downloadService.downloadComponent(
        component,
        outputDirectory,
        force: force,
        includeDependencies: includeDependencies,
        logger: logger,
      );

      logger.success('Component downloaded successfully!');
      logger.info('Component location: ${path.join(outputDir, componentId)}');

      // Show next steps
      _showNextSteps(component, logger);
    } catch (e) {
      logger.error('Failed to download component: $e');
    }
  }

  void _showNextSteps(Map<String, dynamic> component, Logger logger) {
    final setup = component['setup'] as String?;

    print('\n📋 Next Steps:');
    print('1. Review the downloaded files');
    print('2. Add any required dependencies to your pubspec.yaml');

    if (setup != null && setup.isNotEmpty) {
      print('3. Follow the setup instructions:');
      print('   $setup');
    }

    print('4. Import and use the component in your Flutter app');
    print('5. Customize the component as needed');
  }
}
