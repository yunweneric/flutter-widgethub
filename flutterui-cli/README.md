# Flutter Widget Hub CLI

A command-line tool for downloading and managing Flutter UI components directly from the Flutter Widget Hub GitHub repository.

## Features

- 🚀 **Direct GitHub Integration** - Fetch components directly from the GitHub repository
- 📦 **One-Click Downloads** - Download components directly to your Flutter project
- 🔍 **Smart Search** - Find components by name, description, or category
- 📊 **Component Statistics** - View detailed information about components
- 🛠️ **Project Integration** - Automatically integrates with Flutter project structure
- 📱 **Platform Filtering** - Filter components by platform support
- 🎨 **Category Browsing** - Browse components by category and subcategory

## Installation

### Prerequisites

- Dart SDK (>=3.3.0)
- Flutter SDK (for Flutter project integration)

### Install from Source

1. Clone the repository:

```bash
git clone https://github.com/yunweneric/flutter-widgethub.git
cd flutter-widgethub/flutterui-cli
```

2. Install dependencies:

```bash
dart pub get
```

3. Make the CLI executable:

```bash
chmod +x lib/main.dart
```

4. Create a global link (optional):

```bash
dart pub global activate --source path .
```

## Usage

### Basic Commands

```bash
# List all available components
flutterui list

# Search for components
flutterui search button

# Download a component to your Flutter project
flutterui download apple-books-fab

# Get component details
flutterui info apple-books-fab

# List categories
flutterui categories

# Initialize a new project
flutterui init my_app
```

### Command Options

#### List Components

```bash
# List all components
flutterui list

# Filter by category
flutterui list --category Blocks

# Filter by platform
flutterui list --platform Android

# Show compact output
flutterui list --compact
```

#### Search Components

```bash
# Search by name or description
flutterui search animated button

# Show compact results
flutterui search button --compact
```

#### Download Components

```bash
# Download to current Flutter project
flutterui download apple-books-fab

# Download to specific directory
flutterui download apple-books-fab --output ./lib/components

# Overwrite existing files
flutterui download apple-books-fab --force

# Include dependency updates
flutterui download apple-books-fab --dependencies
```

#### Initialize Projects

```bash
# Create a new project
flutterui init my_app

# Create with Flutter project
flutterui init my_app --flutter

# Include specific components
flutterui init my_app --components apple-books-fab,docking-bottom-bar

# Overwrite existing project
flutterui init my_app --force
```

## How It Works

### GitHub Integration

The CLI tool fetches components directly from the [Flutter Widget Hub GitHub repository](https://github.com/yunweneric/flutter-widgethub):

1. **Component Discovery**: Reads the main export store to discover all available components
2. **File Download**: Downloads component files directly from GitHub raw content
3. **Project Integration**: Automatically places components in the correct Flutter project structure
4. **Dependency Management**: Handles component dependencies and setup instructions

### Flutter Project Structure

When downloading components to a Flutter project, the CLI creates this structure:

```
your_flutter_project/
├── lib/
│   ├── components/
│   │   ├── apple-books-fab/
│   │   │   ├── apple_books_fab_widget.dart
│   │   │   ├── apple_books_fab_code.dart
│   │   │   ├── apple_books_fab_setup.dart
│   │   │   ├── data.dart
│   │   │   ├── apple-books-fab.dart (barrel file)
│   │   │   ├── example.dart
│   │   │   └── README.md
│   │   └── ...
│   └── main.dart
└── pubspec.yaml
```

## Component Categories

### Blocks

Reusable UI components that can be used across different apps.

- **Buttons** - Various button styles and interactions
- **Cards** - Card layouts and designs
- **Tabs** - Tab navigation components
- **Bottom Navigation Bars** - Bottom navigation bars

### Templates

Complete app templates or multi-screen components.

- **Onboarding** - App onboarding flows
- **Apps** - Complete app clones or demos

### Animations

Animated components and transitions.

- **Transitions** - Page transitions
- **Effects** - Animation effects

### Effects

Visual effects like gradients, shadows, and transformations.

- **Gradients** - Gradient effects
- **Meshes** - Mesh gradient effects

## Examples

### Download and Use a Component

1. **Search for a component:**

```bash
flutterui search floating action button
```

2. **Get component details:**

```bash
flutterui info apple-books-fab
```

3. **Download the component to your Flutter project:**

```bash
flutterui download apple-books-fab
```

4. **Use in your Flutter app:**

```dart
import 'package:your_app/components/apple-books-fab/apple-books-fab.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: AppleBooksFab(),
      // ... rest of your app
    );
  }
}
```

### Create a New Project with Components

```bash
# Create a new Flutter project with components
flutterui init my_app --flutter --components apple-books-fab,docking-bottom-bar

# Navigate to the project
cd my_app

# Install dependencies
flutter pub get

# Run the app
flutter run
```

## Configuration

### Environment Variables

- `FLUTTERUI_GITHUB_REPO` - Custom GitHub repository (default: yunweneric/flutter-widgethub)
- `FLUTTERUI_BRANCH` - GitHub branch to fetch from (default: main)

### Configuration File

Create a `flutterui.yaml` file in your project root:

```yaml
# Default output directory for downloads
output_dir: ./lib/components

# GitHub settings
github:
  repo: yunweneric/flutter-widgethub
  branch: main

# Component preferences
components:
  auto_dependencies: true
  include_examples: true
  overwrite_existing: false
```

## GitHub Integration Details

The CLI tool integrates directly with the Flutter Widget Hub GitHub repository:

- **Raw Content Access**: Downloads component files from GitHub raw content URLs
- **Component Discovery**: Parses the main export store to discover all components
- **File Structure**: Maintains the original file structure from the repository
- **Version Control**: Always fetches from the latest main branch
- **Error Handling**: Graceful fallback to mock data if GitHub is unavailable

### Supported File Types

- `*_widget.dart` - Main component implementation
- `*_code.dart` - Component code as string
- `*_setup.dart` - Setup instructions
- `data.dart` - Component metadata
- `example.dart` - Usage example
- `README.md` - Component documentation

## Development

### Project Structure

```
flutterui-cli/
├── lib/
│   ├── main.dart              # CLI entry point
│   ├── commands/              # Command implementations
│   │   ├── base_command.dart
│   │   ├── list_command.dart
│   │   ├── search_command.dart
│   │   ├── download_command.dart
│   │   ├── info_command.dart
│   │   ├── categories_command.dart
│   │   └── init_command.dart
│   ├── services/              # Business logic
│   │   ├── component_service.dart
│   │   └── download_service.dart
│   └── utils/                 # Utilities
│       └── logger.dart
├── pubspec.yaml
└── README.md
```

### Adding New Commands

1. Create a new command class extending `BaseCommand`
2. Implement the required methods
3. Add the command to the main CLI parser
4. Export the command in `commands/commands.dart`

### Testing

```bash
# Run tests
dart test

# Run with coverage
dart test --coverage=coverage
```

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests
5. Submit a pull request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Support

- **Repository**: [Flutter Widget Hub](https://github.com/yunweneric/flutter-widgethub)
- **Issues**: [GitHub Issues](https://github.com/yunweneric/flutter-widgethub/issues)
- **Discussions**: [GitHub Discussions](https://github.com/yunweneric/flutter-widgethub/discussions)

## Roadmap

- [ ] **Component Versioning** - Support for different component versions
- [ ] **Dependency Management** - Automatic dependency resolution
- [ ] **Component Updates** - Check for component updates
- [ ] **Batch Operations** - Download multiple components at once
- [ ] **Component Templates** - Create custom component templates
- [ ] **IDE Integration** - VS Code and Android Studio extensions
- [ ] **Component Testing** - Built-in component testing utilities
- [ ] **Performance Optimization** - Faster downloads and caching
- [ ] **Offline Support** - Cache components for offline use
