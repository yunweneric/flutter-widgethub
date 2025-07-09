import 'package:args/args.dart';
import 'package:flutterui_cli/commands/base_command.dart';
import 'package:flutterui_cli/services/component_service.dart';
import 'package:flutterui_cli/utils/logger.dart';

class CategoriesCommand extends BaseCommand {
  @override
  String get name => 'categories';

  @override
  String get description => 'List all component categories';

  @override
  Future<void> run(List<String> arguments, Logger logger) async {
    final parser = ArgParser()
      ..addFlag('help', abbr: 'h', help: 'Show this help message')
      ..addFlag('stats', help: 'Show category statistics');

    try {
      final results = parser.parse(arguments);

      if (results['help']) {
        printUsage();
        return;
      }

      logger.info('Fetching component categories...');

      final service = ComponentService();
      final categories = await service.getCategories();

      if (categories.isEmpty) {
        logger.warning('No categories found');
        return;
      }

      if (results['stats']) {
        await _printCategoryStats(service, logger);
      } else {
        _printCategories(categories, logger);
      }

      logger.success('Found ${categories.length} categories');
    } catch (e) {
      logger.error('Failed to get categories: $e');
    }
  }

  void _printCategories(List<String> categories, Logger logger) {
    print('\n📂 Component Categories:');
    print('${'─' * 40}');

    for (final category in categories) {
      print('• $category');
    }

    print('\n💡 Usage:');
    print('flutterui list --category <category_name>');
    print('flutterui categories --stats');
  }

  Future<void> _printCategoryStats(ComponentService service, Logger logger) async {
    final stats = await service.getStatistics();
    final categories = stats['categories'] as Map<String, dynamic>;
    final total = stats['total'] as int;

    print('\n📊 Category Statistics:');
    print('${'─' * 40}');
    print('Total Components: $total');
    print('');

    final sortedCategories = categories.entries.toList()..sort((a, b) => b.value.compareTo(a.value));

    for (final entry in sortedCategories) {
      final category = entry.key;
      final count = entry.value;
      final percentage = ((count / total) * 100).toStringAsFixed(1);
      print('$category: $count components ($percentage%)');
    }

    print('\n💡 Usage:');
    print('flutterui list --category <category_name>');
  }
}
