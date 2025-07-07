import 'dart:io';
import 'dart:convert';
import 'package:args/args.dart';
import 'package:path/path.dart' as path;
import 'base_command.dart';

class ValidateCommand extends BaseCommand {
  @override
  String get name => 'validate';

  @override
  String get description => 'Validate component structure and files';

  @override
  ArgParser get argParser => ArgParser()
    ..addOption('component', abbr: 'c', help: 'Component to validate')
    ..addFlag('all', abbr: 'a', help: 'Validate all components')
    ..addOption('path', abbr: 'p', help: 'Components path (default: lib/components)');

  @override
  Future<void> run(ArgResults results) async {
    final componentName = results['component'] as String?;
    final validateAll = results['all'] as bool;
    final componentsPath = results['path'] as String? ?? 'lib/components';

    if (componentName == null && !validateAll) {
      print('Error: Specify --component or --all');
      printUsage();
      return;
    }

    try {
      if (validateAll) {
        await _validateAllComponents(componentsPath);
      } else {
        await _validateComponent(componentName!, componentsPath);
      }
    } catch (e) {
      print('Validation error: $e');
    }
  }

  Future<void> _validateComponent(String name, String componentsPath) async {
    print('Validating component: $name');

    final componentDir = Directory(path.join(componentsPath, name));
    if (!await componentDir.exists()) {
      print('❌ Component directory does not exist');
      return;
    }

    bool isValid = true;

    // Check manifest exists
    final manifestFile = File(path.join(componentDir.path, 'manifest.json'));
    if (!await manifestFile.exists()) {
      print('❌ manifest.json not found');
      isValid = false;
    } else {
      try {
        final manifestContent = await manifestFile.readAsString();
        final manifest = json.decode(manifestContent);

        // Validate required fields
        final requiredFields = ['name', 'displayName', 'description', 'category', 'version'];
        for (final field in requiredFields) {
          if (!manifest.containsKey(field)) {
            print('❌ Missing required field: $field');
            isValid = false;
          }
        }

        if (isValid) {
          print('✅ manifest.json is valid');
        }
      } catch (e) {
        print('❌ Invalid JSON in manifest.json: $e');
        isValid = false;
      }
    }

    // Check for main component file
    String? expectedMainFile;
    try {
      final manifestContent = await manifestFile.readAsString();
      final manifest = json.decode(manifestContent);
      expectedMainFile = manifest['mainFile'] as String?;
    } catch (e) {
      // Fallback to default naming
      expectedMainFile = '$name.dart';
    }

    final mainFile = File(path.join(componentDir.path, expectedMainFile ?? '$name.dart'));
    if (!await mainFile.exists()) {
      print('❌ Main component file not found: ${expectedMainFile ?? '$name.dart'}');
      isValid = false;
    } else {
      print('✅ Main component file exists: $expectedMainFile');
    }

    // Check for README
    final readmeFile = File(path.join(componentDir.path, 'README.md'));
    if (!await readmeFile.exists()) {
      print('⚠️  README.md not found (recommended)');
    } else {
      print('✅ README.md exists');
    }

    // Check for examples directory
    final examplesDir = Directory(path.join(componentDir.path, 'examples'));
    if (!await examplesDir.exists()) {
      print('⚠️  Examples directory not found (recommended)');
    } else {
      print('✅ Examples directory exists');
    }

    if (isValid) {
      print('✅ Component $name is valid');
    } else {
      print('❌ Component $name has validation errors');
    }
  }

  Future<void> _validateAllComponents(String componentsPath) async {
    final componentsDir = Directory(componentsPath);
    if (!await componentsDir.exists()) {
      print('No components directory found at $componentsPath');
      return;
    }

    final components = await componentsDir.list().toList();
    int validCount = 0;
    int totalCount = 0;

    for (final entity in components) {
      if (entity is Directory) {
        final componentName = path.basename(entity.path);
        totalCount++;

        try {
          await _validateComponent(componentName, componentsPath);
          validCount++;
        } catch (e) {
          print('Error validating $componentName: $e');
        }
      }
    }

    print('\nValidation Summary:');
    print('✅ Valid: $validCount');
    print('❌ Invalid: ${totalCount - validCount}');
    print('📊 Total: $totalCount');
  }
}
