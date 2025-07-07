import 'package:args/args.dart';
import 'base_command.dart';
import '../services/component_service.dart';

class SearchCommand extends BaseCommand {
  @override
  String get name => 'search';

  @override
  String get description => 'Search for components';

  @override
  ArgParser get argParser => ArgParser()
    ..addOption('query', abbr: 'q', help: 'Search query')
    ..addOption('category', abbr: 'c', help: 'Filter by category')
    ..addOption('tags', abbr: 't', help: 'Filter by tags (comma-separated)')
    ..addOption('format', abbr: 'f', help: 'Output format (table, json)', defaultsTo: 'table');

  @override
  Future<void> run(ArgResults results) async {
    final query = results['query'] as String?;
    final category = results['category'] as String?;
    final tags = results['tags'] as String?;
    final format = results['format'] as String;

    if (query == null && category == null && tags == null) {
      print('Error: At least one search criteria is required (--query, --category, or --tags)');
      printUsage();
      return;
    }

    try {
      final componentService = ComponentService();
      final components = await componentService.getAllComponents();

      // Apply filters
      var filteredComponents = components;

      if (query != null) {
        filteredComponents = filteredComponents.where((component) {
          return component.name.toLowerCase().contains(query.toLowerCase()) ||
              component.description.toLowerCase().contains(query.toLowerCase()) ||
              component.displayName.toLowerCase().contains(query.toLowerCase());
        }).toList();
      }

      if (category != null) {
        filteredComponents = filteredComponents.where((component) {
          return component.category.toLowerCase() == category.toLowerCase();
        }).toList();
      }

      if (tags != null) {
        final tagList = tags.split(',').map((t) => t.trim().toLowerCase()).toList();
        filteredComponents = filteredComponents.where((component) {
          return component.tags.any((tag) => tagList.contains(tag.toLowerCase()));
        }).toList();
      }

      if (format == 'json') {
        _printJsonFormat(filteredComponents);
      } else {
        _printTableFormat(filteredComponents);
      }
    } catch (e) {
      print('Error searching components: $e');
    }
  }

  void _printTableFormat(List<dynamic> components) {
    if (components.isEmpty) {
      print('No components found matching your search criteria.');
      return;
    }

    print('\nSearch Results:');
    print('─' * 80);
    print('${'Name'.padRight(20)} ${'Category'.padRight(15)} ${'Description'.padRight(40)}');
    print('─' * 80);

    for (final component in components) {
      final name = component.name.padRight(20);
      final category = component.category.padRight(15);
      final description = component.description.length > 40
          ? '${component.description.substring(0, 37)}...'
          : component.description.padRight(40);

      print('$name $category $description');
    }
    print('─' * 80);
    print('Found: ${components.length} components');
  }

  void _printJsonFormat(List<dynamic> components) {
    final jsonData = {
      'components': components.map((c) => c.toJson()).toList(),
      'total': components.length,
    };
    print(jsonData);
  }
}
