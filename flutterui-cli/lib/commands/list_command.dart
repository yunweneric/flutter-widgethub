import 'package:args/args.dart';
import 'base_command.dart';
import '../services/component_service.dart';

class ListCommand extends BaseCommand {
  @override
  String get name => 'list';

  @override
  String get description => 'List available components';

  @override
  ArgParser get argParser => ArgParser()
    ..addOption('category', abbr: 'c', help: 'Filter by category')
    ..addOption('format', abbr: 'f', help: 'Output format (table, json)', defaultsTo: 'table');

  @override
  Future<void> run(ArgResults results) async {
    final category = results['category'] as String?;
    final format = results['format'] as String;

    try {
      final componentService = ComponentService();
      final components = await componentService.getAllComponents();

      // Filter by category if specified
      final filteredComponents =
          category != null ? components.where((c) => c.category == category).toList() : components;

      if (format == 'json') {
        _printJsonFormat(filteredComponents);
      } else {
        _printTableFormat(filteredComponents);
      }
    } catch (e) {
      print('Error listing components: $e');
    }
  }

  void _printTableFormat(List<dynamic> components) {
    if (components.isEmpty) {
      print('No components found.');
      return;
    }

    print('\nAvailable Components:');
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
    print('Total: ${components.length} components');
  }

  void _printJsonFormat(List<dynamic> components) {
    final jsonData = {
      'components': components.map((c) => c.toJson()).toList(),
      'total': components.length,
    };
    print(jsonData);
  }
}
