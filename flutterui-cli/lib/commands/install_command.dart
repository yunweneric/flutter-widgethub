import 'package:args/args.dart';
import 'package:path/path.dart' as path;
import 'base_command.dart';
import '../services/component_service.dart';
import '../services/project_service.dart';

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

      // Check if component already exists
      if (await projectService.hasComponent(componentName, installPath) && !force) {
        print('Error: Component "$componentName" already exists. Use --force to overwrite.');
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
