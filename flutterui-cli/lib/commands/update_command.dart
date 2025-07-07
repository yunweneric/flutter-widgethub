import 'package:args/args.dart';
import 'base_command.dart';
import '../services/component_service.dart';
import '../services/project_service.dart';
import 'dart:io';
import 'package:path/path.dart' as path;

class UpdateCommand extends BaseCommand {
  @override
  String get name => 'update';

  @override
  String get description => 'Update installed components';

  @override
  ArgParser get argParser => ArgParser()
    ..addOption('component', abbr: 'c', help: 'Component to update (if not specified, updates all)')
    ..addOption('path', abbr: 'p', help: 'Components path (default: lib/components)')
    ..addFlag('force', abbr: 'f', help: 'Force update even if no changes');

  @override
  Future<void> run(ArgResults results) async {
    final componentName = results['component'] as String?;
    final componentsPath = results['path'] as String? ?? 'lib/components';
    final force = results['force'] as bool;

    try {
      final componentService = ComponentService();
      final projectService = ProjectService();

      // Validate Flutter project
      if (!await projectService.isFlutterProject()) {
        print('Error: Not a Flutter project. Run this command from your Flutter project root.');
        return;
      }

      if (componentName != null) {
        // Update specific component
        await _updateComponent(componentService, projectService, componentName, componentsPath, force);
      } else {
        // Update all components
        await _updateAllComponents(componentService, projectService, componentsPath, force);
      }
    } catch (e) {
      print('Error updating components: $e');
    }
  }

  Future<void> _updateComponent(
    ComponentService componentService,
    ProjectService projectService,
    String componentName,
    String componentsPath,
    bool force,
  ) async {
    // Check if component is installed
    if (!await projectService.hasComponent(componentName, componentsPath)) {
      print('Error: Component "$componentName" is not installed.');
      return;
    }

    // Get latest component version
    final component = await componentService.getComponent(componentName);
    if (component == null) {
      print('Error: Component "$componentName" not found in registry.');
      return;
    }

    // Reinstall component
    await componentService.installComponent(
      component,
      componentsPath,
      force: true,
      installDependencies: true,
    );

    print('✅ Successfully updated $componentName');
  }

  Future<void> _updateAllComponents(
    ComponentService componentService,
    ProjectService projectService,
    String componentsPath,
    bool force,
  ) async {
    // Get all installed components
    final componentsDir = Directory(componentsPath);
    if (!await componentsDir.exists()) {
      print('No components directory found at $componentsPath');
      return;
    }

    final installedComponents = await componentsDir.list().toList();
    int updatedCount = 0;

    for (final entity in installedComponents) {
      if (entity is Directory) {
        final componentName = path.basename(entity.path);
        try {
          await _updateComponent(componentService, projectService, componentName, componentsPath, force);
          updatedCount++;
        } catch (e) {
          print('Warning: Failed to update $componentName: $e');
        }
      }
    }

    print('\n✅ Updated $updatedCount components');
  }
}
