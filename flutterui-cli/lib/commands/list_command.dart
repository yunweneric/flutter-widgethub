import 'dart:convert';
import 'package:args/args.dart';
import 'package:flutterui_cli/commands/base_command.dart';
import 'package:flutterui_cli/services/component_service.dart';
import 'package:flutterui_cli/utils/logger.dart';

class ListCommand extends BaseCommand {
  @override
  String get name => 'list';

  @override
  String get description => 'List all available components';

  @override
  Future<void> run(List<String> arguments, Logger logger) async {
    final parser = ArgParser()
      ..addFlag('help', abbr: 'h', help: 'Show this help message')
      ..addOption('category', abbr: 'c', help: 'Filter by category (e.g., Blocks, Templates, Animations, Effects)')
      ..addOption('platform', abbr: 'p', help: 'Filter by platform (e.g., Android, iOS, Web)')
      ..addFlag('compact', help: 'Show compact output')
      ..addFlag('json', help: 'Output in JSON format')
      ..addOption('limit', abbr: 'l', help: 'Limit the number of results', defaultsTo: '0')
      ..addFlag('sort', help: 'Sort components by name');

    try {
      final results = parser.parse(arguments);

      if (results['help']) {
        _printHelp(parser);
        return;
      }

      logger.info('Fetching components...');

      final service = ComponentService();
      final components = await service.getComponents();

      if (components.isEmpty) {
        logger.warning('No components found');
        return;
      }

      var filteredComponents = components;

      // Filter by category
      if (results['category'] != null) {
        final category = results['category'] as String;
        filteredComponents =
            filteredComponents.where((c) => c['category'].toString().toLowerCase() == category.toLowerCase()).toList();
      }

      // Filter by platform
      if (results['platform'] != null) {
        final platform = results['platform'] as String;
        filteredComponents = filteredComponents
            .where((c) => (c['platforms'] as List).any((p) => p.toString().toLowerCase() == platform.toLowerCase()))
            .toList();
      }

      if (filteredComponents.isEmpty) {
        logger.warning('No components match the specified filters');
        return;
      }

      // Apply sorting if requested
      if (results['sort']) {
        filteredComponents.sort((a, b) => (a['title'] as String).compareTo(b['title'] as String));
      }

      // Apply limit if specified
      final limit = int.tryParse(results['limit'] as String) ?? 0;
      if (limit > 0 && filteredComponents.length > limit) {
        filteredComponents = filteredComponents.take(limit).toList();
      }

      if (results['json']) {
        _printJsonOutput(filteredComponents, logger);
      } else if (results['compact']) {
        _printCompactList(filteredComponents, logger);
      } else {
        _printDetailedList(filteredComponents, logger);
      }

      logger.success('Found ${filteredComponents.length} components');
    } catch (e) {
      logger.error('Failed to list components: $e');
    }
  }

  void _printHelp(ArgParser parser) {
    print('''
List all available Flutter UI components

Usage: flutterui list [options]

Options:
${parser.usage}

Examples:
  flutterui list                    # List all components
  flutterui list --compact          # Show compact list
  flutterui list --category Blocks  # Filter by category
  flutterui list --platform iOS     # Filter by platform
  flutterui list --limit 10         # Limit to 10 results
  flutterui list --sort             # Sort by name
  flutterui list --json             # Output in JSON format
''');
  }

  void _printCompactList(List<Map<String, dynamic>> components, Logger logger) {
    for (final component in components) {
      final id = component['id'] as String;
      final title = component['title'] as String;
      final category = component['category'] as String;
      print('$id | $title | $category');
    }
  }

  void _printJsonOutput(List<Map<String, dynamic>> components, Logger logger) {
    print(json.encode(components));
  }

  void _printDetailedList(List<Map<String, dynamic>> components, Logger logger) {
    for (final component in components) {
      final id = component['id'] as String;
      final title = component['title'] as String;
      final description = component['description'] as String;
      final category = component['category'] as String;
      final platforms = (component['platforms'] as List).join(', ');

      print('\n📦 $title');
      print('   ID: $id');
      print('   Category: $category');
      print('   Platforms: $platforms');
      print('   Description: $description');
      print('   ${'─' * 50}');
    }
  }
}
