import 'dart:io';
import 'package:args/args.dart';
import 'base_command.dart';
import '../services/project_service.dart';

class RemoveCommand extends BaseCommand {
  @override
  String get name => 'remove';

  @override
  String get description => 'Remove a component from your project';

  @override
  ArgParser get argParser => ArgParser()
    ..addOption('component', abbr: 'c', help: 'Component name to remove')
    ..addOption('path', abbr: 'p', help: 'Components path (default: lib/components)')
    ..addFlag('force', abbr: 'f', help: 'Force removal without confirmation');

  @override
  Future<void> run(ArgResults results) async {
    final componentName = results['component'] as String?;
    final componentsPath = results['path'] as String? ?? 'lib/components';
    final force = results['force'] as bool;

    if (componentName == null) {
      print('Error: Component name is required');
      printUsage();
      return;
    }

    try {
      final projectService = ProjectService();

      // Validate Flutter project
      if (!await projectService.isFlutterProject()) {
        print('Error: Not a Flutter project. Run this command from your Flutter project root.');
        return;
      }

      // Check if component exists
      if (!await projectService.hasComponent(componentName, componentsPath)) {
        print('Error: Component "$componentName" is not installed.');
        return;
      }

      // Confirm removal
      if (!force) {
        print('Are you sure you want to remove "$componentName"? (y/N)');
        final input = stdin.readLineSync()?.toLowerCase();
        if (input != 'y' && input != 'yes') {
          print('Removal cancelled.');
          return;
        }
      }

      // Remove component
      await projectService.removeComponent(componentName, componentsPath);
      print('✅ Successfully removed $componentName');
    } catch (e) {
      print('Error removing component: $e');
    }
  }
}
