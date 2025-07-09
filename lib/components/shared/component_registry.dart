import 'package:flutterui/app/shared/data/models/component.dart';
import 'package:flutterui/components/presentation/export/store.dart';

/// Manages component registration and discovery
class ComponentRegistry {
  static final ComponentRegistry _instance = ComponentRegistry._internal();
  factory ComponentRegistry() => _instance;
  ComponentRegistry._internal();

  /// All registered components
  final List<Component> _components = [];

  /// Initialize the registry with all components
  void initialize() {
    _components.clear();
    _components.addAll(AllComponents.widgets);
  }

  /// Get all components
  List<Component> getAllComponents() {
    return List.unmodifiable(_components);
  }

  /// Get components by category
  List<Component> getComponentsByCategory(String category) {
    return _components.where((component) => component.category.describe() == category).toList();
  }

  /// Get components by subcategory
  List<Component> getComponentsBySubcategory(String subcategory) {
    return _components.where((component) => component.subcategory.describe() == subcategory).toList();
  }

  /// Get component by ID
  Component? getComponentById(String id) {
    try {
      return _components.firstWhere((component) => component.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Search components by title or description
  List<Component> searchComponents(String query) {
    final lowercaseQuery = query.toLowerCase();
    return _components
        .where((component) =>
            component.title.toLowerCase().contains(lowercaseQuery) ||
            component.description.toLowerCase().contains(lowercaseQuery))
        .toList();
  }

  /// Get components by platform support
  List<Component> getComponentsByPlatform(String platform) {
    return _components.where((component) => component.supportedPlatforms.any((p) => p.describe() == platform)).toList();
  }

  /// Get components by device type
  List<Component> getComponentsByDeviceType(String deviceType) {
    return _components
        .where((component) => component.responsiveDevices.any((d) => d.describe() == deviceType))
        .toList();
  }

  /// Get component statistics
  Map<String, dynamic> getStatistics() {
    final categories = <String, int>{};
    final subcategories = <String, int>{};
    final platforms = <String, int>{};
    final devices = <String, int>{};

    for (final component in _components) {
      // Count categories
      final category = component.category.describe();
      categories[category] = (categories[category] ?? 0) + 1;

      // Count subcategories
      final subcategory = component.subcategory.describe();
      subcategories[subcategory] = (subcategories[subcategory] ?? 0) + 1;

      // Count platforms
      for (final platform in component.supportedPlatforms) {
        final platformName = platform.describe();
        platforms[platformName] = (platforms[platformName] ?? 0) + 1;
      }

      // Count devices
      for (final device in component.responsiveDevices) {
        final deviceName = device.describe();
        devices[deviceName] = (devices[deviceName] ?? 0) + 1;
      }
    }

    return {
      'total': _components.length,
      'categories': categories,
      'subcategories': subcategories,
      'platforms': platforms,
      'devices': devices,
    };
  }

  /// Export components as JSON for CLI tool
  List<Map<String, dynamic>> exportForCLI() {
    return _components
        .map((component) => {
              'id': component.id,
              'title': component.title,
              'description': component.description,
              'category': component.category.describe(),
              'subcategory': component.subcategory.describe(),
              'platforms': component.supportedPlatforms.map((p) => p.describe()).toList(),
              'devices': component.responsiveDevices.map((d) => d.describe()).toList(),
              'codeComponents': component.codeComponents
                  .map((cc) => {
                        'code': cc.code,
                        'hasWidget': cc.widget != null,
                      })
                  .toList(),
              'setup': component.setup,
              'assetLink': component.assetLink,
              'gitHubLink': component.gitHubLink,
              'createdAt': component.createdAt.toIso8601String(),
              'updatedAt': component.updatedAt.toIso8601String(),
            })
        .toList();
  }
}
