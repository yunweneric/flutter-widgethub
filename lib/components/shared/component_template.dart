import 'package:flutter/material.dart';
import 'package:flutterui/app/shared/data/enums/component_category_enum.dart';
import 'package:flutterui/app/shared/data/enums/device_type.dart';
import 'package:flutterui/app/shared/data/enums/sub_component_category_enum.dart';
import 'package:flutterui/app/shared/data/enums/supported_platform.dart';
import 'package:flutterui/app/shared/data/models/code_component.dart';
import 'package:flutterui/app/shared/data/models/component.dart';

/// Template for creating new components
/// Copy this template and modify it for your component
class ComponentTemplate {
  // TODO: Replace with your component's widget
  static const Widget widget = Placeholder();

  // TODO: Replace with your component's code string
  static const String code = '''
// Your component code here
class YourComponent extends StatelessWidget {
  const YourComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
''';

  // TODO: Replace with your component's setup instructions
  static const String setup = '''
## Setup Instructions

1. Add required dependencies to pubspec.yaml:
```yaml
dependencies:
  flutter:
    sdk: flutter
  # Add other dependencies your component needs
```

2. Import the component:
```dart
import 'package:your_package/your_component.dart';
```

3. Use the component:
```dart
YourComponent()
```
''';

  // TODO: Customize the component metadata
  static Component component = Component(
    id: "your-component-id", // Use kebab-case
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    codeComponents: [
      CodeComponent(code: code, widget: widget),
    ],
    description: "Brief description of what your component does",
    title: "Your Component Name",
    setup: setup,
    category: ComponentCategoryEnum.BLOCKS, // Choose appropriate category
    subcategory: SubComponentCategoryEnum.BUTTONS, // Choose appropriate subcategory
    supportedPlatforms: [
      SupportedPlatform.ANDROID,
      SupportedPlatform.IOS,
      // Add other platforms as needed
    ],
    responsiveDevices: [
      AppDeviceType.MOBILE,
      AppDeviceType.TABLET,
      // Add other device types as needed
    ],
    // Optional: Add asset and GitHub links if available
    // assetLink: "https://example.com/assets.zip",
    // gitHubLink: "https://github.com/example/repo",
  );
}
