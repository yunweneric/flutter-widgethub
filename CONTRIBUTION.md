# Contributing to Flutter Widget Hub 🤝

Thank you for your interest in contributing to Flutter Widget Hub! We welcome contributions from developers of all skill levels.

## 📋 Table of Contents

- [Getting Started](#getting-started)
- [Project Structure](#project-structure)
- [Adding a New Component](#adding-a-new-component)
- [Development Workflow](#development-workflow)
- [Code Style Guidelines](#code-style-guidelines)
- [Submitting Your Contribution](#submitting-your-contribution)

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (version 3.22.1)
- Git
- A code editor (VS Code recommended)
- [FVM](https://fvm.app/) (optional but recommended)

### Setup

1. **Fork the repository**

   ```bash
   # Go to https://github.com/yunweneric/flutter-widgethub
   # Click "Fork" button
   ```

2. **Clone your fork**

   ```bash
   git clone https://github.com/YOUR_USERNAME/flutter-widgethub.git
   cd flutter-widgethub
   ```

3. **Set up the development environment**

   ```bash
   flutter pub get
   ```

4. **Create a new branch**
   ```bash
   git checkout -b feature/your-feature-name
   ```

## 📁 Project Structure

The project is organized into two main sections:

```
lib/
├── app/                    # Main application code
│   ├── core/              # App configuration and routing
│   ├── presentation/      # UI screens and widgets
│   └── shared/            # Shared utilities and models
└── components/            # User-contributed components
    ├── data/              # Component logic and services
    └── presentation/      # Component UI and exports
        ├── animations/    # Animation components
        ├── blocks/        # Layout block components
        ├── effects/       # Visual effect components
        ├── templates/     # Complete app templates
        └── export/        # Component exports
```

### Where to Make Changes

- **Bug fixes and improvements:** Work in `lib/app/`
- **New components:** Add to `lib/components/presentation/`

## 🎨 Adding a New Component

### Step 1: Choose Your Component Category

Decide which category your component belongs to:

- **Animations** (`presentation/animations/`) - Interactive animations
- **Blocks** (`presentation/blocks/`) - Reusable layout components
- **Effects** (`presentation/effects/`) - Visual effects and transformations
- **Templates** (`presentation/templates/`) - Complete app templates

### Step 2: Create Your Component Folder

Create a new folder in the appropriate category using **snake_case** naming:

```bash
# Example: For a "floating action button" component
mkdir lib/components/presentation/blocks/floating_action_button
```

### Step 3: Add Required Files

Your component folder must contain these 4 files:

```
floating_action_button/
├── data.dart              # Main component export
├── floating_action_button_widget.dart    # Widget implementation
├── floating_action_button_code.dart      # Code as string
└── floating_action_button_setup.dart     # Setup instructions
```

#### File Templates

**1. `data.dart`** - Main export file

```dart
export 'floating_action_button_widget.dart';
export 'floating_action_button_code.dart';
export 'floating_action_button_setup.dart';
```

**2. `floating_action_button_widget.dart`** - Your component widget

```dart
import 'package:flutter/material.dart';

class FloatingActionButtonWidget extends StatelessWidget {
  const FloatingActionButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return // Your widget implementation
  }
}
```

**3. `floating_action_button_code.dart`** - Code as string

```dart
const String floatingActionButtonCode = '''
// Paste your component code here as a string
class FloatingActionButtonWidget extends StatelessWidget {
  const FloatingActionButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return // Your widget implementation
  }
}
''';
```

**4. `floating_action_button_setup.dart`** - Setup instructions

````dart
const String floatingActionButtonSetup = '''
## Setup Instructions

1. Copy the widget code to your project
2. Add any required dependencies to pubspec.yaml
3. Import and use the widget in your app

## Dependencies
- flutter/material.dart

## Usage
```dart
FloatingActionButtonWidget()
````

''';

````

### Step 4: Register Your Component

Add your component to the export store:

1. Open `lib/components/presentation/export/store.dart`
2. Find the appropriate category list
3. Add your component:

```dart
// In the blocks list (or appropriate category)
Component(
  name: 'Floating Action Button',
  category: ComponentCategory.blocks,
  subCategory: SubComponentCategory.buttons,
  data: floatingActionButtonData, // Import this from your data.dart
),
````

### Step 5: Test Your Component

1. Restart the app
2. Navigate to your component category
3. Verify your component appears and works correctly

## 🔄 Development Workflow

### Making Changes

1. **Always work on a feature branch**

   ```bash
   git checkout -b feature/your-feature-name
   ```

2. **Make your changes**

   - Write clean, readable code
   - Add comments where necessary
   - Test your changes thoroughly

3. **Commit your changes**
   ```bash
   git add .
   git commit -m "feat: add floating action button component"
   ```

### Commit Message Guidelines

Use conventional commit messages:

- `feat:` New features
- `fix:` Bug fixes
- `docs:` Documentation changes
- `style:` Code style changes
- `refactor:` Code refactoring
- `test:` Adding tests
- `chore:` Maintenance tasks

## 📝 Code Style Guidelines

### General Guidelines

- Follow Flutter's official style guide
- Use meaningful variable and function names
- Add comments for complex logic
- Keep functions small and focused
- Use proper indentation (2 spaces)

### Component Guidelines

- Make components reusable and customizable
- Provide clear documentation
- Include example usage
- Handle edge cases gracefully
- Use proper Flutter widgets and patterns

### File Naming

- Use **snake_case** for file names
- Use **PascalCase** for class names
- Use **camelCase** for variables and functions

## 📤 Submitting Your Contribution

### Before Submitting

1. **Test your changes**

   ```bash
   flutter test
   flutter analyze
   ```

2. **Update documentation** if needed

3. **Ensure your code follows the style guidelines**

### Creating a Pull Request

1. **Push your changes**

   ```bash
   git push origin feature/your-feature-name
   ```

2. **Create a Pull Request**

   - Go to your fork on GitHub
   - Click "New Pull Request"
   - Select the main branch as the target
   - Fill out the PR template

3. **PR Description**
   Include:
   - What you changed
   - Why you made the changes
   - How to test the changes
   - Screenshots (if applicable)

### PR Review Process

1. **Automated checks** will run
2. **Maintainers** will review your code
3. **Address feedback** if requested
4. **Merge** when approved

## 🎯 Component Ideas

Looking for inspiration? Here are some component ideas:

### Animations

- Loading spinners
- Page transitions
- Button animations
- Card flip effects

### Blocks

- Navigation bars
- Form components
- List items
- Modal dialogs

### Effects

- Gradient backgrounds
- Shadow effects
- Blur effects
- Particle systems

### Templates

- Login screens
- Dashboard layouts
- E-commerce pages
- Social media feeds

## 🆘 Need Help?

- **Issues:** [GitHub Issues](https://github.com/yunweneric/flutter-widgethub/issues)
- **Discussions:** [GitHub Discussions](https://github.com/yunweneric/flutter-widgethub/discussions)
- **Email:** yunweneric@gmail.com

## 🙏 Thank You!

Your contributions help make Flutter Widget Hub better for everyone in the Flutter community. Thank you for your time and effort!

---

<div align="center">
  <p>Happy coding! 🚀</p>
</div>
