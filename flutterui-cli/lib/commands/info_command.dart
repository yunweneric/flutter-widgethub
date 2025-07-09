import 'package:args/args.dart';
import 'package:flutterui_cli/commands/base_command.dart';
import 'package:flutterui_cli/services/component_service.dart';
import 'package:flutterui_cli/utils/logger.dart';

class InfoCommand extends BaseCommand {
  @override
  String get name => 'info';

  @override
  String get description => 'Show detailed information about a component';

  @override
  Future<void> run(List<String> arguments, Logger logger) async {
    final parser = ArgParser()..addFlag('help', abbr: 'h', help: 'Show this help message');

    try {
      final results = parser.parse(arguments);

      if (results['help']) {
        printUsage();
        return;
      }

      if (arguments.isEmpty) {
        logger.error('Please provide a component ID');
        printUsage();
        return;
      }

      final componentId = arguments.first;
      logger.info('Fetching component information: $componentId');

      final service = ComponentService();
      final component = await service.getComponentById(componentId);

      if (component == null) {
        logger.error('Component not found: $componentId');
        logger.info('Use "flutterui list" to see available components');
        return;
      }

      _printComponentInfo(component, logger);
    } catch (e) {
      logger.error('Failed to get component information: $e');
    }
  }

  void _printComponentInfo(Map<String, dynamic> component, Logger logger) {
    final title = component['title'] as String;
    final description = component['description'] as String;
    final category = component['category'] as String;
    final subcategory = component['subcategory'] as String;
    final platforms = (component['platforms'] as List).join(', ');
    final devices = (component['devices'] as List).join(', ');
    final setup = component['setup'] as String?;
    final createdAt = component['createdAt'] as String?;
    final updatedAt = component['updatedAt'] as String?;
    final assetLink = component['assetLink'] as String?;
    final gitHubLink = component['gitHubLink'] as String?;

    print('\n📦 $title');
    print('${'─' * 60}');
    print('📝 Description: $description');
    print('🏷️  Category: $category > $subcategory');
    print('📱 Platforms: $platforms');
    print('💻 Devices: $devices');

    if (createdAt != null) {
      print('📅 Created: $createdAt');
    }

    if (updatedAt != null) {
      print('🔄 Updated: $updatedAt');
    }

    if (assetLink != null) {
      print('📦 Assets: $assetLink');
    }

    if (gitHubLink != null) {
      print('🔗 GitHub: $gitHubLink');
    }

    if (setup != null && setup.isNotEmpty) {
      print('\n🔧 Setup Instructions:');
      print('${'─' * 30}');
      print(setup);
    }

    print('\n💡 Usage:');
    print('flutterui download ${component['id']}');
  }
}
