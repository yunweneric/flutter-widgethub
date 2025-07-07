import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutterui/app/shared/data/models/component.dart';
import 'package:flutterui/components/core/component_exporter.dart';
import 'package:flutterui/components/core/component_installer.dart';
import 'package:flutterui/components/core/component_package.dart';
import 'package:flutterui/components/presentation/export/store.dart';

/// CLI Interface for component export and installation
class ComponentCLIInterface {
  /// Exports a single component
  static Future<String?> exportComponent({
    required String componentId,
    String? outputPath,
    String? author,
    String? license,
    String? readme,
    String? changelog,
    String? documentation,
  }) async {
    try {
      // Find component by ID
      final component = _findComponentById(componentId);
      if (component == null) {
        print('✗ Component not found: $componentId');
        return null;
      }

      // Export component
      final packagePath = await ComponentExporter.exportComponent(
        component,
        outputPath: outputPath,
        author: author ?? 'FlutterUI',
        license: license ?? 'MIT',
        readme: readme,
        changelog: changelog,
        documentation: documentation,
      );

      print('✓ Exported ${component.title} to $packagePath');
      return packagePath;
    } catch (e) {
      print('✗ Export failed: $e');
      return null;
    }
  }

  /// Exports all components
  static Future<List<String>> exportAllComponents({
    String? outputPath,
    String? author,
    String? license,
  }) async {
    try {
      final components = AllComponents.widgets;
      final exportedPaths = await ComponentExporter.exportAllComponents(components);

      // Create component registry
      final registryPath = await ComponentExporter.createComponentRegistry(components);
      print('✓ Created component registry: $registryPath');

      return exportedPaths;
    } catch (e) {
      print('✗ Export failed: $e');
      return [];
    }
  }

  /// Exports components by category
  static Future<List<String>> exportComponentsByCategory({
    required String category,
    String? outputPath,
    String? author,
    String? license,
  }) async {
    try {
      final allComponents = AllComponents.widgets;
      final filteredComponents = allComponents
          .where((component) =>
              component.category.describe().toLowerCase() == category.toLowerCase() ||
              component.subcategory.describe().toLowerCase() == category.toLowerCase())
          .toList();

      if (filteredComponents.isEmpty) {
        print('✗ No components found for category: $category');
        return [];
      }

      final exportedPaths = <String>[];
      for (final component in filteredComponents) {
        final path = await ComponentExporter.exportComponent(
          component,
          outputPath: outputPath,
          author: author ?? 'FlutterUI',
          license: license ?? 'MIT',
        );
        exportedPaths.add(path);
      }

      return exportedPaths;
    } catch (e) {
      print('✗ Export failed: $e');
      return [];
    }
  }

  /// Installs a component from package
  static Future<bool> installComponent({
    required String packagePath,
    String? projectPath,
    bool overwrite = false,
    bool installDependencies = true,
  }) async {
    try {
      return await ComponentInstaller.installComponent(
        packagePath,
        projectPath: projectPath,
        overwrite: overwrite,
        installDependencies: installDependencies,
      );
    } catch (e) {
      print('✗ Installation failed: $e');
      return false;
    }
  }

  /// Lists all available components
  static void listComponents({String? category}) {
    final components = AllComponents.widgets;

    if (category != null) {
      final filteredComponents = components
          .where((component) =>
              component.category.describe().toLowerCase() == category.toLowerCase() ||
              component.subcategory.describe().toLowerCase() == category.toLowerCase())
          .toList();

      if (filteredComponents.isEmpty) {
        print('No components found for category: $category');
        return;
      }

      _printComponentList(filteredComponents, category: category);
    } else {
      _printComponentList(components);
    }
  }

  /// Lists installed components
  static Future<void> listInstalledComponents({String? projectPath}) async {
    try {
      final components = await ComponentInstaller.listInstalledComponents(
        projectPath ?? Directory.current.path,
      );

      if (components.isEmpty) {
        print('No components installed');
        return;
      }

      print('Installed Components:');
      print('====================');

      for (final component in components) {
        print('• ${component.name} (${component.id})');
        print('  Version: ${component.version}');
        print('  Description: ${component.description}');
        print('  Author: ${component.author}');
        print('  Categories: ${component.categories.join(', ')}');
        print('');
      }
    } catch (e) {
      print('✗ Failed to list installed components: $e');
    }
  }

  /// Uninstalls a component
  static Future<bool> uninstallComponent({
    required String componentId,
    String? projectPath,
  }) async {
    try {
      return await ComponentInstaller.uninstallComponent(
        componentId,
        projectPath ?? Directory.current.path,
      );
    } catch (e) {
      print('✗ Uninstallation failed: $e');
      return false;
    }
  }

  /// Shows component information
  static void showComponentInfo(String componentId) {
    final component = _findComponentById(componentId);
    if (component == null) {
      print('✗ Component not found: $componentId');
      return;
    }

    print('Component Information:');
    print('=====================');
    print('ID: ${component.id}');
    print('Title: ${component.title}');
    print('Description: ${component.description}');
    print('Category: ${component.category.describe()}');
    print('Subcategory: ${component.subcategory.describe()}');
    print('Created: ${component.createdAt.toIso8601String()}');
    print('Updated: ${component.updatedAt.toIso8601String()}');
    print('Platforms: ${component.supportedPlatforms.map((p) => p.describe()).join(', ')}');
    print('Devices: ${component.responsiveDevices.map((d) => d.describe()).join(', ')}');

    if (component.gitHubLink != null) {
      print('GitHub: ${component.gitHubLink}');
    }

    if (component.assetLink != null) {
      print('Assets: ${component.assetLink}');
    }
  }

  /// Shows installed component information
  static Future<void> showInstalledComponentInfo({
    required String componentId,
    String? projectPath,
  }) async {
    try {
      final component = await ComponentInstaller.getComponentInfo(
        componentId,
        projectPath ?? Directory.current.path,
      );

      if (component == null) {
        print('✗ Component not found: $componentId');
        return;
      }

      print('Installed Component Information:');
      print('===============================');
      print('ID: ${component.id}');
      print('Name: ${component.name}');
      print('Version: ${component.version}');
      print('Description: ${component.description}');
      print('Author: ${component.author}');
      print('License: ${component.license}');
      print('Categories: ${component.categories.join(', ')}');
      print('Platforms: ${component.supportedPlatforms.join(', ')}');
      print('Devices: ${component.responsiveDevices.join(', ')}');
      print('Created: ${component.createdAt.toIso8601String()}');
      print('Updated: ${component.updatedAt.toIso8601String()}');

      if (component.repositoryUrl != null) {
        print('Repository: ${component.repositoryUrl}');
      }

      if (component.documentation != null) {
        print('Documentation: ${component.documentation}');
      }
    } catch (e) {
      print('✗ Failed to get component info: $e');
    }
  }

  /// Validates component installation
  static Future<bool> validateComponent({
    required String componentId,
    String? projectPath,
  }) async {
    try {
      final isValid = await ComponentInstaller.validateInstallation(
        componentId,
        projectPath ?? Directory.current.path,
      );

      if (isValid) {
        print('✓ Component $componentId is properly installed');
      } else {
        print('✗ Component $componentId is not properly installed');
      }

      return isValid;
    } catch (e) {
      print('✗ Validation failed: $e');
      return false;
    }
  }

  /// Searches components by keyword
  static void searchComponents(String keyword) {
    final components = AllComponents.widgets;
    final results = components
        .where((component) =>
            component.title.toLowerCase().contains(keyword.toLowerCase()) ||
            component.description.toLowerCase().contains(keyword.toLowerCase()) ||
            component.category.describe().toLowerCase().contains(keyword.toLowerCase()) ||
            component.subcategory.describe().toLowerCase().contains(keyword.toLowerCase()))
        .toList();

    if (results.isEmpty) {
      print('No components found for: $keyword');
      return;
    }

    print('Search Results for "$keyword":');
    print('==============================');
    _printComponentList(results);
  }

  /// Shows available categories
  static void showCategories() {
    final components = AllComponents.widgets;
    final categories = <String>{};
    final subcategories = <String>{};

    for (final component in components) {
      categories.add(component.category.describe());
      subcategories.add(component.subcategory.describe());
    }

    print('Available Categories:');
    print('=====================');
    print('Main Categories:');
    for (final category in categories.toList()..sort()) {
      final count = components.where((c) => c.category.describe() == category).length;
      print('• $category ($count components)');
    }

    print('\nSubcategories:');
    for (final subcategory in subcategories.toList()..sort()) {
      final count = components.where((c) => c.subcategory.describe() == subcategory).length;
      print('• $subcategory ($count components)');
    }
  }

  /// Finds component by ID
  static Component? _findComponentById(String componentId) {
    final components = AllComponents.widgets;
    try {
      return components.firstWhere((component) => component.id == componentId);
    } catch (e) {
      return null;
    }
  }

  /// Prints component list
  static void _printComponentList(List<Component> components, {String? category}) {
    final title = category != null ? 'Components in $category' : 'All Components';
    print('$title:');
    print('${'='.padRight(title.length + 1, '=')}');

    for (final component in components) {
      print('• ${component.title} (${component.id})');
      print('  ${component.description}');
      print('  Category: ${component.category.describe()} > ${component.subcategory.describe()}');
      print('  Platforms: ${component.supportedPlatforms.map((p) => p.describe()).join(', ')}');
      print('');
    }

    print('Total: ${components.length} component${components.length != 1 ? 's' : ''}');
  }

  /// Shows CLI help
  static void showHelp() {
    print('''
FlutterUI Component CLI

Usage:
  flutterui <command> [options]

Commands:
  list                    List all available components
  list --category <cat>   List components by category
  list --installed        List installed components
  search <keyword>        Search components by keyword
  info <component-id>     Show component information
  export <component-id>   Export a component
  export --all            Export all components
  export --category <cat> Export components by category
  install <package-path>  Install a component
  uninstall <component-id> Uninstall a component
  validate <component-id> Validate component installation
  categories              Show available categories
  help                    Show this help

Options:
  --output <path>         Output directory for exports
  --project <path>        Project directory for installations
  --author <name>         Author name for exports
  --license <type>        License type for exports
  --overwrite             Overwrite existing components
  --no-dependencies       Skip dependency installation

Examples:
  flutterui list
  flutterui list --category "Buttons"
  flutterui search "animation"
  flutterui export liquid-glass-tab-bar
  flutterui install liquid-glass-tab-bar.fcp
  flutterui info liquid-glass-tab-bar
''');
  }
}
