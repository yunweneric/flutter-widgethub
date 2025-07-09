# Enhanced Contribution Guide

Welcome to Flutter Widget Hub! This guide will help you contribute components effectively.

## Quick Start

1. **Fork and clone** the repository
2. **Create a new branch** for your component
3. **Use the component template** to get started
4. **Follow the naming conventions**
5. **Test your component**
6. **Submit a pull request**

## Component Structure

Every component must follow this structure:

```
lib/components/presentation/[category]/[subcategory]/[component_name]/
├── data.dart                    # Component metadata and registration
├── [component_name]_widget.dart # The actual widget implementation
├── [component_name]_code.dart   # Code as a string for display
└── [component_name]_setup.dart  # Setup instructions
```

### File Naming Conventions

- **Files**: Use `snake_case` (e.g., `my_component_widget.dart`)
- **Classes**: Use `PascalCase` (e.g., `MyComponentWidget`)
- **IDs**: Use `kebab-case` (e.g., `my-component`)

## Component Categories

Choose the appropriate category for your component:

### 1. **Blocks** (`presentation/blocks/`)

Reusable UI components that can be used across different apps.

**Subcategories:**

- `buttons/` - Various button styles and interactions
- `cards/` - Card layouts and designs
- `tabs/` - Tab navigation components
- `bottom_nav_bars/` - Bottom navigation bars

### 2. **Templates** (`presentation/templates/`)

Complete app templates or multi-screen components.

**Subcategories:**

- `onboarding/` - App onboarding flows
- `apps/` - Complete app clones or demos

### 3. **Animations** (`presentation/animations/`)

Animated components and transitions.

**Subcategories:**

- `transitions/` - Page transitions
- `effects/` - Animation effects

### 4. **Effects** (`presentation/effects/`)

Visual effects like gradients, shadows, and transformations.

**Subcategories:**

- `gradients/` - Gradient effects
- `meshes/` - Mesh gradient effects

## Creating a New Component

### Step 1: Use the Template

Copy the component template and modify it:

```dart
// lib/components/shared/component_template.dart
import 'package:flutterui/components/shared/component_template.dart';

// Copy ComponentTemplate and modify for your component
```

### Step 2: Create Your Component Files

1. **Create the widget file** (`my_component_widget.dart`):

```dart
import 'package:flutter/material.dart';

class MyComponent extends StatelessWidget {
  const MyComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // Your component implementation
    );
  }
}
```

2. **Create the code file** (`my_component_code.dart`):

```dart
const myComponentCode = '''
// Copy your widget code here as a string
class MyComponent extends StatelessWidget {
  const MyComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
''';
```

3. **Create the setup file** (`my_component_setup.dart`):

````dart
const myComponentSetup = '''
## Setup Instructions

1. **Dependencies**: Add any required packages to pubspec.yaml
2. **Import**: Import the component in your file
3. **Usage**: Use the component in your widget tree

### Example:
```dart
import 'package:your_app/my_component.dart';

MyComponent()
````

''';

````

4. **Create the data file** (`data.dart`):
```dart
import 'package:flutter/material.dart';
import 'package:flutterui/app/shared/data/enums/component_category_enum.dart';
import 'package:flutterui/app/shared/data/enums/sub_component_category_enum.dart';
import 'package:flutterui/app/shared/data/enums/supported_platform.dart';
import 'package:flutterui/app/shared/data/models/code_component.dart';
import 'package:flutterui/app/shared/data/models/component.dart';
import 'package:flutterui/components/shared/component_validator.dart';

import 'my_component_widget.dart';
import 'my_component_code.dart';
import 'my_component_setup.dart';

class MyComponentData {
  static const Widget widget = MyComponent();
  static const String code = myComponentCode;
  static const String setup = myComponentSetup;

  static Component component = Component(
    id: "my-component",
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    codeComponents: [
      CodeComponent(code: code, widget: widget),
    ],
    description: "A brief description of what your component does",
    title: "My Component",
    setup: setup,
    category: ComponentCategoryEnum.BLOCKS,
    subcategory: SubComponentCategoryEnum.BUTTONS,
    supportedPlatforms: [
      SupportedPlatform.ANDROID,
      SupportedPlatform.IOS,
    ],
    responsiveDevices: [
      AppDeviceType.MOBILE,
      AppDeviceType.TABLET,
    ],
  );

  // Validate the component
  static List<String> validate() {
    return ComponentValidator.validateComponent(component);
  }
}
````

### Step 3: Register Your Component

Add your component to the export store:

```dart
// lib/components/presentation/export/store.dart
import 'package:flutterui/components/presentation/blocks/buttons/my_component/data.dart';

class AllComponents {
  static List<Component> widgets = [
    // ... existing components
    MyComponentData.component, // Add your component here
  ];
}
```

### Step 4: Test Your Component

1. **Run the app** and verify your component appears
2. **Test the component** in different screen sizes
3. **Validate the component** using the validator:

```dart
final errors = MyComponentData.validate();
if (errors.isNotEmpty) {
  print('Validation errors: $errors');
}
```

## Best Practices

### 1. **Component Design**

- Make components **reusable** and **configurable**
- Use **proper parameterization** for customization
- Follow **Material Design** or **Cupertino** guidelines
- Ensure **accessibility** support

### 2. **Code Quality**

- Write **clean, readable code**
- Add **proper documentation**
- Use **meaningful variable names**
- Follow **Flutter conventions**

### 3. **Testing**

- Test on **multiple screen sizes**
- Test on **different platforms**
- Ensure **responsive design**
- Test **edge cases**

### 4. **Documentation**

- Write **clear descriptions**
- Provide **comprehensive setup instructions**
- Include **usage examples**
- Document **dependencies**

## Validation Checklist

Before submitting your component, ensure:

- [ ] Component follows the file structure
- [ ] All required files are present
- [ ] Component is properly registered
- [ ] No validation errors
- [ ] Component works on target platforms
- [ ] Setup instructions are clear
- [ ] Code is well-documented
- [ ] Component is responsive

## Submitting Your Contribution

1. **Commit your changes**:

```bash
git add .
git commit -m "feat: add my-component

- Add new button component with animation
- Support Android and iOS platforms
- Include setup instructions and examples"
```

2. **Push to your fork**:

```bash
git push origin feature/my-component
```

3. **Create a pull request** with:
   - Clear description of the component
   - Screenshots or GIFs if applicable
   - Testing information
   - Any breaking changes

## Getting Help

- **Issues**: Create an issue for bugs or feature requests
- **Discussions**: Use GitHub Discussions for questions
- **Documentation**: Check existing components for examples

## Code of Conduct

Please read and follow our [Code of Conduct](CODE_OF_CONDUCT.md).

Thank you for contributing to Flutter Widget Hub! 🚀
