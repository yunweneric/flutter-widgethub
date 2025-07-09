import 'package:flutterui/app/shared/data/models/component.dart';

/// Validates components to ensure they meet the required standards
class ComponentValidator {
  static const List<String> _requiredFields = [
    'id',
    'title',
    'description',
    'setup',
    'category',
    'subcategory',
    'codeComponents',
    'supportedPlatforms',
    'responsiveDevices',
  ];

  /// Validates a component and returns a list of validation errors
  static List<String> validateComponent(Component component) {
    final List<String> errors = [];

    // Check required fields
    if (component.id.isEmpty) {
      errors.add('Component ID cannot be empty');
    }

    if (component.title.isEmpty) {
      errors.add('Component title cannot be empty');
    }

    if (component.description.isEmpty) {
      errors.add('Component description cannot be empty');
    }

    if (component.setup.isEmpty) {
      errors.add('Component setup instructions cannot be empty');
    }

    // Validate ID format (kebab-case)
    if (!_isValidId(component.id)) {
      errors.add('Component ID must be in kebab-case format (e.g., "my-component")');
    }

    // Validate code components
    if (component.codeComponents.isEmpty) {
      errors.add('Component must have at least one code component');
    }

    // Validate supported platforms
    if (component.supportedPlatforms.isEmpty) {
      errors.add('Component must support at least one platform');
    }

    // Validate responsive devices
    if (component.responsiveDevices.isEmpty) {
      errors.add('Component must support at least one device type');
    }

    // Validate dates
    if (component.createdAt.isAfter(component.updatedAt)) {
      errors.add('Created date cannot be after updated date');
    }

    return errors;
  }

  /// Validates component ID format (kebab-case)
  static bool _isValidId(String id) {
    final RegExp kebabCaseRegex = RegExp(r'^[a-z0-9]+(-[a-z0-9]+)*$');
    return kebabCaseRegex.hasMatch(id);
  }

  /// Validates component file structure
  static List<String> validateFileStructure(String componentPath) {
    final List<String> errors = [];

    // Check if required files exist
    final requiredFiles = [
      '$componentPath/data.dart',
      '$componentPath/component_widget.dart',
      '$componentPath/component_code.dart',
      '$componentPath/component_setup.dart',
    ];

    for (final file in requiredFiles) {
      // This would need to be implemented with actual file system access
      // For now, this is a placeholder
      // if (!File(file).existsSync()) {
      //   errors.add('Required file missing: $file');
      // }
    }

    return errors;
  }

  /// Validates component naming conventions
  static List<String> validateNaming(String componentName) {
    final List<String> errors = [];

    // Check for proper naming (snake_case for files, PascalCase for classes)
    if (!RegExp(r'^[a-z][a-z0-9_]*$').hasMatch(componentName)) {
      errors.add('Component name should be in snake_case format');
    }

    return errors;
  }
}
