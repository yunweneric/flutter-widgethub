import 'package:args/args.dart';
import 'package:flutterui_cli/commands/base_command.dart';
import 'package:flutterui_cli/services/component_service.dart';
import 'package:flutterui_cli/utils/logger.dart';

class SearchCommand extends BaseCommand {
  @override
  String get name => 'search';

  @override
  String get description => 'Search for components by name or description';

  @override
  Future<void> run(List<String> arguments, Logger logger) async {
    final parser = ArgParser()
      ..addFlag('help', abbr: 'h', help: 'Show this help message')
      ..addFlag('compact', help: 'Show compact output');

    try {
      final results = parser.parse(arguments);

      if (results['help']) {
        printUsage();
        return;
      }

      if (arguments.isEmpty) {
        logger.error('Please provide a search query');
        printUsage();
        return;
      }

      final query = arguments.join(' ');
      logger.info('Searching for: "$query"');

      final service = ComponentService();
      final components = await service.searchComponents(query);

      if (components.isEmpty) {
        logger.warning('No components found matching "$query"');
        return;
      }

      if (results['compact']) {
        _printCompactResults(components, logger);
      } else {
        _printDetailedResults(components, logger);
      }

      logger.success('Found ${components.length} components matching "$query"');
    } catch (e) {
      logger.error('Failed to search components: $e');
    }
  }

  void _printCompactResults(List<Map<String, dynamic>> components, Logger logger) {
    for (final component in components) {
      final id = component['id'] as String;
      final title = component['title'] as String;
      final category = component['category'] as String;
      print('$id | $title | $category');
    }
  }

  void _printDetailedResults(List<Map<String, dynamic>> components, Logger logger) {
    for (final component in components) {
      final id = component['id'] as String;
      final title = component['title'] as String;
      final description = component['description'] as String;
      final category = component['category'] as String;
      final subcategory = component['subcategory'] as String;
      final platforms = (component['platforms'] as List).join(', ');

      print('\n🔍 $title');
      print('   ID: $id');
      print('   Category: $category > $subcategory');
      print('   Platforms: $platforms');
      print('   Description: $description');
      print('   ${'─' * 50}');
    }
  }
}
