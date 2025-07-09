#!/usr/bin/env dart

import 'package:flutterui_cli/services/component_service.dart';
import 'package:flutterui_cli/utils/logger.dart';

void main() async {
  final logger = Logger(verbose: true);

  print('🧪 Testing Flutter Widget Hub CLI...\n');

  // Test component service
  final service = ComponentService();

  try {
    // Test getting components
    logger.info('Testing component discovery...');
    final components = await service.getComponents();
    logger.success('Found ${components.length} components');

    if (components.isNotEmpty) {
      final firstComponent = components.first;
      logger.info('First component: ${firstComponent['title']} (${firstComponent['id']})');
    }

    // Test search
    logger.info('\nTesting component search...');
    final searchResults = await service.searchComponents('button');
    logger.success('Found ${searchResults.length} components matching "button"');

    // Test categories
    logger.info('\nTesting category discovery...');
    final categories = await service.getCategories();
    logger.success('Found ${categories.length} categories: ${categories.join(', ')}');

    // Test statistics
    logger.info('\nTesting statistics...');
    final stats = await service.getStatistics();
    logger.success('Total components: ${stats['total']}');

    // Test repository info
    logger.info('\nTesting repository info...');
    final repoInfo = await service.getRepositoryInfo();
    if (repoInfo != null) {
      logger.success('Repository: ${repoInfo['full_name']}');
      logger.info('Description: ${repoInfo['description']}');
      logger.info('Stars: ${repoInfo['stargazers_count']}');
    }

    logger.success('\n✅ All tests passed!');
  } catch (e) {
    logger.error('❌ Test failed: $e');
  }
}
