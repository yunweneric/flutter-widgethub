import 'dart:convert';
import 'package:http/http.dart' as http;

class ComponentService {
  // https://github.com/yunweneric/flutter-widgethub
  static const String _githubRepo = 'yunweneric/flutter-widgethub';
  static const String _githubRawBase = 'https://raw.githubusercontent.com/$_githubRepo/main';
  static const String _githubApiBase = 'https://api.github.com/repos/$_githubRepo';

  /// Fetch all available components from GitHub
  Future<List<Map<String, dynamic>>> getComponents() async {
    try {
      // First try to get components from the main app's export store
      final response = await http.get(
        Uri.parse('$_githubRawBase/lib/components/presentation/export/store.dart'),
        headers: {'Accept': 'text/plain'},
      );

      if (response.statusCode == 200) {
        return await _parseComponentsFromStore(response.body);
      } else {
        // Fallback to mock data
        return _getMockComponents();
      }
    } catch (e) {
      // Fallback to mock data
      return _getMockComponents();
    }
  }

  /// Parse components from the store.dart file
  Future<List<Map<String, dynamic>>> _parseComponentsFromStore(String storeContent) async {
    final components = <Map<String, dynamic>>[];

    // Extract component imports and create component data
    // This is a simplified parser - in a real implementation, you'd want a more robust parser
    final importMatches =
        RegExp(r"import 'package:flutterui/components/presentation/([^']+)';").allMatches(storeContent);

    for (final match in importMatches) {
      final importPath = match.group(1)!;
      final componentData = await _fetchComponentData(importPath);
      if (componentData != null) {
        components.add(componentData);
      }
    }

    return components;
  }

  /// Fetch component data from GitHub
  Future<Map<String, dynamic>?> _fetchComponentData(String importPath) async {
    try {
      // Convert import path to file path (no change needed since it's already correct)
      final dataUrl = '$_githubRawBase/lib/components/presentation/$importPath';

      final response = await http.get(
        Uri.parse(dataUrl),
        headers: {'Accept': 'text/plain'},
      );

      if (response.statusCode == 200) {
        return _parseComponentFromDataFile(response.body, importPath);
      }
    } catch (e) {
      // Component not found or error occurred
    }

    return null;
  }

  /// Parse component data from a data.dart file
  Map<String, dynamic>? _parseComponentFromDataFile(String content, String importPath) {
    try {
      // Extract component ID from import path
      final pathParts = importPath.split('/');
      final componentId = pathParts.last.replaceAll('_data.dart', '');

      // Extract component information using regex patterns
      final titleMatch = RegExp('title:\\s*["\']([^"\']+)["\']').firstMatch(content);
      final descriptionMatch = RegExp('description:\\s*["\']([^"\']+)["\']').firstMatch(content);
      final categoryMatch = RegExp('category:\\s*ComponentCategoryEnum\\.(\\w+)').firstMatch(content);
      final subcategoryMatch = RegExp('subcategory:\\s*SubComponentCategoryEnum\\.(\\w+)').firstMatch(content);

      if (titleMatch != null) {
        return {
          'id': componentId,
          'title': titleMatch.group(1)!,
          'description': descriptionMatch?.group(1) ?? 'No description available',
          'category': _formatCategory(categoryMatch?.group(1) ?? 'BLOCKS'),
          'subcategory': _formatSubcategory(subcategoryMatch?.group(1) ?? 'BUTTONS'),
          'platforms': ['Android', 'iOS'], // Default platforms
          'devices': ['Mobile', 'Tablet'], // Default devices
          'setup': 'No additional setup required.',
          'createdAt': DateTime.now().toIso8601String(),
          'updatedAt': DateTime.now().toIso8601String(),
          'githubPath': importPath,
        };
      }
    } catch (e) {
      // Parsing failed
    }

    return null;
  }

  /// Format category enum to readable string
  String _formatCategory(String category) {
    switch (category) {
      case 'BLOCKS':
        return 'Blocks';
      case 'TEMPLATES':
        return 'Templates';
      case 'ANIMATIONS':
        return 'Animations';
      case 'EFFECTS':
        return 'Effects';
      default:
        return category;
    }
  }

  /// Format subcategory enum to readable string
  String _formatSubcategory(String subcategory) {
    switch (subcategory) {
      case 'BUTTONS':
        return 'Buttons';
      case 'CARDS':
        return 'Cards';
      case 'TABS':
        return 'Tabs';
      case 'BOTTOM_NAV_BARS':
        return 'Bottom Navigation Bars';
      case 'SLIDERS_AND_CAROUSELS':
        return 'Sliders and Carousels';
      case 'ONBOARDING_SCREENS':
        return 'Onboarding Screens';
      case 'APPS':
        return 'Apps';
      case 'LINEAR_GRADIENTS':
        return 'Linear Gradients';
      default:
        return subcategory;
    }
  }

  /// Get component by ID
  Future<Map<String, dynamic>?> getComponentById(String id) async {
    final components = await getComponents();
    try {
      return components.firstWhere((c) => c['id'] == id);
    } catch (e) {
      return null;
    }
  }

  /// Search components
  Future<List<Map<String, dynamic>>> searchComponents(String query) async {
    final components = await getComponents();
    final lowercaseQuery = query.toLowerCase();

    return components.where((component) {
      final title = component['title']?.toString().toLowerCase() ?? '';
      final description = component['description']?.toString().toLowerCase() ?? '';
      final category = component['category']?.toString().toLowerCase() ?? '';

      return title.contains(lowercaseQuery) ||
          description.contains(lowercaseQuery) ||
          category.contains(lowercaseQuery);
    }).toList();
  }

  /// Get component categories
  Future<List<String>> getCategories() async {
    final components = await getComponents();
    final categories = <String>{};

    for (final component in components) {
      final category = component['category']?.toString();
      if (category != null) {
        categories.add(category);
      }
    }

    return categories.toList()..sort();
  }

  /// Get component statistics
  Future<Map<String, dynamic>> getStatistics() async {
    final components = await getComponents();
    final categories = <String, int>{};
    final platforms = <String, int>{};

    for (final component in components) {
      // Count categories
      final category = component['category']?.toString() ?? 'Unknown';
      categories[category] = (categories[category] ?? 0) + 1;

      // Count platforms
      final componentPlatforms = component['platforms'] as List? ?? [];
      for (final platform in componentPlatforms) {
        final platformName = platform.toString();
        platforms[platformName] = (platforms[platformName] ?? 0) + 1;
      }
    }

    return {
      'total': components.length,
      'categories': categories,
      'platforms': platforms,
    };
  }

  /// Get GitHub repository information
  Future<Map<String, dynamic>?> getRepositoryInfo() async {
    try {
      final response = await http.get(
        Uri.parse(_githubApiBase),
        headers: {'Accept': 'application/vnd.github.v3+json'},
      );

      if (response.statusCode == 200) {
        return json.decode(response.body) as Map<String, dynamic>;
      }
    } catch (e) {
      // API call failed
    }

    return null;
  }

  /// Mock components for development/testing
  List<Map<String, dynamic>> _getMockComponents() {
    return [
      {
        'id': 'apple-books-fab',
        'title': 'Apple Books FAB',
        'description': 'A floating action button with expandable menu options',
        'category': 'Blocks',
        'subcategory': 'Buttons',
        'platforms': ['Android', 'iOS'],
        'devices': ['Mobile', 'Tablet'],
        'setup': 'Add flutter_screenutil dependency',
        'createdAt': '2024-12-04T00:00:00Z',
        'updatedAt': '2024-12-04T00:00:00Z',
        'githubPath': 'blocks/buttons/apple_books_fab/data.dart',
      },
      {
        'id': 'docking-bottom-bar',
        'title': 'Docking Bottom Bar',
        'description': 'A modern bottom navigation bar with docking animation',
        'category': 'Blocks',
        'subcategory': 'Bottom Navigation Bars',
        'platforms': ['Android', 'iOS'],
        'devices': ['Mobile', 'Tablet'],
        'setup': 'No additional dependencies required',
        'createdAt': '2024-11-15T00:00:00Z',
        'updatedAt': '2024-11-15T00:00:00Z',
        'githubPath': 'blocks/bottom_nav_bars/docking_bar/data.dart',
      },
      {
        'id': 'fruity-lips-carousel',
        'title': 'Fruity Lips Carousel',
        'description': 'An animated carousel with fruity lips theme',
        'category': 'Blocks',
        'subcategory': 'Sliders and Carousels',
        'platforms': ['Android', 'iOS'],
        'devices': ['Mobile'],
        'setup': 'Download assets from provided link',
        'createdAt': '2024-07-09T00:00:00Z',
        'updatedAt': '2024-07-09T00:00:00Z',
        'githubPath': 'templates/fruity_lips/data.dart',
      },
    ];
  }
}
