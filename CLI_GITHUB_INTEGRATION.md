# Flutter Widget Hub CLI - GitHub Integration

## Overview

The Flutter Widget Hub CLI has been updated to fetch components directly from the GitHub repository instead of a custom API. This provides a more reliable and transparent way to access components.

## Key Changes

### 1. **GitHub-Based Component Discovery**

- **Source**: Components are fetched directly from `https://github.com/yunweneric/flutter-widgethub`
- **Method**: Parses the main export store (`lib/components/presentation/export/store.dart`)
- **Fallback**: Uses mock data if GitHub is unavailable

### 2. **Direct File Downloads**

- **Raw Content**: Downloads component files from GitHub raw content URLs
- **File Structure**: Maintains original file structure from repository
- **Components**: Downloads all component files (`*_widget.dart`, `*_code.dart`, `*_setup.dart`, `data.dart`)

### 3. **Flutter Project Integration**

- **Automatic Detection**: Detects Flutter projects by presence of `pubspec.yaml`
- **Smart Placement**: Places components in `lib/components/` directory
- **Barrel Files**: Creates import-friendly barrel files for easy usage

## How It Works

### Component Discovery Process

1. **Fetch Export Store**: Downloads `store.dart` from GitHub
2. **Parse Imports**: Extracts component import paths using regex
3. **Fetch Component Data**: Downloads individual `data.dart` files
4. **Parse Metadata**: Extracts title, description, category, etc.
5. **Return Components**: Returns structured component data

### Download Process

1. **Validate Component**: Check if component exists and has GitHub path
2. **Detect Project**: Check if in Flutter project or standalone directory
3. **Create Structure**: Create component directory in appropriate location
4. **Download Files**: Download all component files from GitHub
5. **Create Documentation**: Generate README, example, and barrel files

## File Structure

### Downloaded Component Structure

```
lib/components/
├── apple-books-fab/
│   ├── apple_books_fab_widget.dart    # Main component
│   ├── apple_books_fab_code.dart      # Code as string
│   ├── apple_books_fab_setup.dart     # Setup instructions
│   ├── data.dart                      # Component metadata
│   ├── apple-books-fab.dart           # Barrel file for imports
│   ├── example.dart                   # Usage example
│   └── README.md                      # Documentation
└── ...
```

### Usage in Flutter App

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

## CLI Commands

### List Components

```bash
# List all components from GitHub
flutterui list

# Filter by category
flutterui list --category Blocks

# Filter by platform
flutterui list --platform Android
```

### Search Components

```bash
# Search components by name/description
flutterui search button

# Show compact results
flutterui search button --compact
```

### Download Components

```bash
# Download to current Flutter project
flutterui download apple-books-fab

# Download to specific directory
flutterui download apple-books-fab --output ./lib/components

# Overwrite existing files
flutterui download apple-books-fab --force
```

### Get Component Info

```bash
# Show detailed component information
flutterui info apple-books-fab
```

## GitHub Integration Details

### Repository Structure

The CLI expects the GitHub repository to have this structure:

```
flutter-widgethub/
├── lib/
│   └── components/
│       └── presentation/
│           ├── export/
│           │   └── store.dart          # Main export file
│           ├── blocks/
│           │   ├── buttons/
│           │   │   └── apple_books_fab/
│           │   │       ├── data.dart
│           │   │       ├── apple_books_fab_widget.dart
│           │   │       ├── apple_books_fab_code.dart
│           │   │       └── apple_books_fab_setup.dart
│           │   └── ...
│           └── ...
```

### File Parsing

The CLI uses regex patterns to extract component information:

- **Title**: `title:\s*['\"]([^'\"]+)['\"]`
- **Description**: `description:\s*['\"]([^'\"]+)['\"]`
- **Category**: `category:\s*ComponentCategoryEnum\.(\w+)`
- **Subcategory**: `subcategory:\s*SubComponentCategoryEnum\.(\w+)`

### Error Handling

- **Network Errors**: Falls back to mock data
- **Missing Files**: Skips components with missing files
- **Parse Errors**: Logs warnings and continues
- **Invalid Data**: Uses default values for missing fields

## Benefits

### For Users

- **Transparency**: Direct access to source code
- **Reliability**: No dependency on custom API
- **Version Control**: Always gets latest version from main branch
- **Offline Development**: Can work with cached components

### For Maintainers

- **No API Maintenance**: No need to maintain separate API
- **Direct Updates**: Changes in GitHub are immediately available
- **Version Control**: Git history provides component versioning
- **Community Access**: Anyone can contribute components

### For Contributors

- **Familiar Workflow**: Standard GitHub contribution process
- **Immediate Availability**: Components available as soon as merged
- **Transparent Process**: All code changes visible in repository
- **Easy Testing**: Can test components directly from repository

## Configuration

### Environment Variables

```bash
# Custom GitHub repository
export FLUTTERUI_GITHUB_REPO="your-username/your-repo"

# Custom branch
export FLUTTERUI_BRANCH="develop"
```

### Configuration File

```yaml
# flutterui.yaml
github:
  repo: yunweneric/flutter-widgethub
  branch: main

components:
  output_dir: ./lib/components
  auto_dependencies: true
  include_examples: true
```

## Testing

### Test Script

Run the test script to verify GitHub integration:

```bash
cd flutterui-cli
dart test_cli.dart
```

### Manual Testing

```bash
# Test component discovery
flutterui list

# Test component search
flutterui search button

# Test component download
flutterui download apple-books-fab

# Test component info
flutterui info apple-books-fab
```

## Future Enhancements

### Planned Features

- **Component Versioning**: Support for different Git branches/tags
- **Offline Caching**: Cache components for offline use
- **Batch Downloads**: Download multiple components at once
- **Dependency Resolution**: Automatic dependency management
- **Component Updates**: Check for component updates

### Technical Improvements

- **Robust Parsing**: More sophisticated file parsing
- **Error Recovery**: Better error handling and recovery
- **Performance**: Optimized downloads and caching
- **Validation**: Component validation before download

## Conclusion

The GitHub-integrated CLI provides a robust, transparent, and maintainable solution for distributing Flutter components. It leverages the existing GitHub infrastructure while providing a seamless developer experience.

### Key Advantages

- **No API Maintenance**: Reduces infrastructure overhead
- **Direct Access**: Users get components directly from source
- **Version Control**: Git provides natural versioning
- **Community Driven**: Standard GitHub contribution workflow
- **Reliable**: GitHub's robust infrastructure ensures availability

This approach makes the Flutter Widget Hub more accessible and maintainable while providing users with the latest components directly from the source repository.
