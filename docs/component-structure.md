# Official Component Folder Structure

Each component must follow this structure for consistency, maintainability, and to enable automated documentation/codegen.

```
component_name/
├── data.dart         # Exports a static Component instance and doc file paths
├── code.dart         # Stringified code sample for preview
├── widget.dart       # Main widget implementation
├── setup.md          # (Markdown) Setup guide: dependencies, API, steps
├── usage.md          # (Markdown) Usage examples and best practices
├── demo.dart         # (Optional) Standalone demo for development/testing
├── README.md         # (Optional) Aggregates/links to setup.md, usage.md, etc.
├── test/
│   └── widget_test.dart
└── assets/           # (Optional) Component-specific images/SVGs
```

---

## File Descriptions

- **data.dart**:  
  - Exports a static `Component` instance for registration.
  - Exposes static paths to `setup.md` and `usage.md`.
  - Optionally, provides methods to load doc content (for codegen or runtime).

- **code.dart**:  
  - Contains the component’s implementation as a Dart string for code preview.

- **widget.dart**:  
  - The actual Flutter widget implementation.

- **setup.md**:  
  - Markdown file with setup instructions, dependencies, and API table.

- **usage.md**:  
  - Markdown file with usage examples and best practices.

- **demo.dart** (optional):  
  - Standalone demo for local development/testing.

- **README.md** (optional):  
  - Aggregates or links to setup.md, usage.md, and other docs.

- **test/** (optional):  
  - Unit/widget tests for the component.

- **assets/** (optional):  
  - Images, SVGs, or other resources used by the component.

---

## Example: setup.md

```markdown
# Setup Guide

## 1. Dependencies

```yaml
dependencies:
  flutter: ">=3.0.0"
  your_package: ^1.0.0
```

## 2. Import

```dart
import 'package:your_package/component_name/widget.dart';
```

## 3. API

| Property | Type           | Description                |
|----------|----------------|----------------------------|
| title    | String         | The card title             |
| image    | ImageProvider  | The card image             |
| onTap    | VoidCallback?  | Tap callback (optional)    |

## 4. Setup Steps

1. Add the dependencies above to your `pubspec.yaml`.
2. Import the widget as shown.
3. Use the widget in your widget tree.

See [usage.md](usage.md) for full examples.
```

---

## Why This Structure?

- Enables codegen and automation.
- Ensures all components are discoverable and consistently documented.
- Makes onboarding and maintenance easy for all contributors. 