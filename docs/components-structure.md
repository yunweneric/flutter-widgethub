# Components Structure Documentation

## Overview

The `lib/components` directory contains a well-organized collection of reusable UI components, templates, and related logic following a clean architecture pattern. This structure separates concerns into distinct layers: data, presentation, and shared utilities.

## Directory Structure

```
lib/components/
├── data/                    # Data layer - business logic and services
│   ├── logic/              # BLoC pattern implementation
│   │   └── component/      # Component-specific business logic
│   └── services/           # Data services and API calls
├── presentation/           # Presentation layer - UI components
│   ├── animations/         # Animated components
│   ├── blocks/            # Reusable UI blocks
│   ├── effects/           # Visual effects and meshes
│   ├── export/            # Component registry and exports
│   └── templates/         # Complete app templates
└── shared/                # Shared utilities and setup
```

## Detailed Breakdown

### 1. Data Layer (`data/`)

#### Logic (`data/logic/`)
Contains business logic using the BLoC (Business Logic Component) pattern:

- **`component/`** - Component-specific business logic
  - `component_bloc.dart` - Main BLoC for component management
  - `component_event.dart` - Events for component state changes
  - `component_state.dart` - State definitions for components

**Key Features:**
- Manages active component selection
- Handles component navigation (next/previous)
- Updates component categories
- Maintains component state across the app

#### Services (`data/services/`)
- `component_service.dart` - Service layer for component operations

### 2. Presentation Layer (`presentation/`)

#### Animations (`presentation/animations/`)
Custom animated components:
- **`skew_card/`** - Skewed card animation component
  - `data.dart` - Component metadata and configuration
  - `skew_card_code.dart` - Implementation code
  - `skew_card_widget.dart` - Widget implementation

#### Blocks (`presentation/blocks/`)
Reusable UI building blocks:

- **`bottom_nav_bars/`**
  - `docking_bar/` - Docking-style bottom navigation

- **`buttons/`**
  - `apple_books_fab/` - Apple Books-style floating action button

- **`cards/`** - Card components

- **`tabs/`** - Tab components
  - `blurred_slide_tab/` - Blurred sliding tab
  - `expandable_tab/` - Expandable tab component
  - `liquid_glass_tab/` - Liquid glass effect tab
  - `slide_tab/` - Sliding tab component

#### Effects (`presentation/effects/`)
Visual effects and mesh components:
- **`meshes/`**
  - `mesh_01/` - Mesh gradient effect 01
  - `mesh_02/` - Mesh gradient effect 02

#### Export (`presentation/export/`)
Component registry and central export:
- `store.dart` - Central registry of all components (`AllComponents.widgets`)

#### Templates (`presentation/templates/`)
Complete app templates and designs:

- **`auth/`** - Authentication templates
  - `auth_01/` through `auth_05/` - Different auth UI designs

- **`basuu/`** - Basuu app template

- **`fade_carousel/`** - Fade carousel template

- **`fruity_lips/`** - Fruity Lips app template

- **`leave_review/`** - Leave review template

- **`nike_zoomer/`** - Nike Zoomer app template

- **`onboarding/`** - Onboarding templates
  - `doctor_onboarding/` - Medical app onboarding
  - `mental_health/` - Mental health app onboarding
  - `online/` - Online onboarding

- **`spotify/`** - Spotify app template
  - `homepage/` - Main homepage with playlist UI
  - `login/` - Login screen
  - `register/` - Registration screen
  - `splash/` - Splash screen
  - `onboard/` - Onboarding screens
  - `choose_theme/` - Theme selection
  - `shared/` - Shared components (logo, theme)
  - `spotify.dart` - Main component definition
  - `index.dart` - Component exports

### 3. Shared (`shared/`)
- `setup.dart` - Basic setup instructions

## Component Architecture

### Component Definition Pattern

Each component follows a consistent pattern:

```dart
class ComponentNameData {
  static Component component = Component(
    id: "unique-id",
    title: "Component Title",
    description: "Component description",
    category: ComponentCategoryEnum.TEMPLATES,
    subcategory: SubComponentCategoryEnum.APPS,
    codeComponents: [
      CodeComponent(code: codeString, widget: Widget()),
    ],
    supportedPlatforms: [SupportedPlatform.ANDROID, SupportedPlatform.IOS],
    responsiveDevices: [AppDeviceType.MOBILE],
  );
}
```

### File Structure Pattern

Most components follow this structure:
```
component_name/
├── data.dart          # Component metadata and definition
├── code.dart          # Implementation code (string)
├── widget.dart        # Widget implementation
└── setup.dart         # Setup instructions (optional)
```

## Key Features

### 1. Centralized Registry
All components are registered in `presentation/export/store.dart` through the `AllComponents.widgets` list.

### 2. BLoC State Management
Components use BLoC pattern for state management with:
- Events for user actions
- States for UI updates
- Business logic separation

### 3. Multi-Platform Support
Components specify supported platforms:
- Android
- iOS
- Web (where applicable)

### 4. Responsive Design
Components support different device types:
- Mobile
- Tablet
- Desktop

### 5. Category Organization
Components are categorized by:
- **Templates**: Complete app designs
- **Blocks**: Reusable UI components
- **Animations**: Animated components
- **Effects**: Visual effects

## Usage Examples

### Adding a New Component

1. Create component directory in appropriate category
2. Implement component files (data.dart, widget.dart, code.dart)
3. Register in `AllComponents.widgets` list
4. Update exports if needed

### Using Components

```dart
// Access component through BLoC
final componentBloc = context.read<ComponentBloc>();
componentBloc.add(UpdateActiveComponentEvent(newComponent));

// Or directly from registry
final component = AllComponents.widgets.firstWhere(
  (c) => c.id == "component-id"
);
```

## Best Practices

1. **Consistent Naming**: Use descriptive, consistent naming conventions
2. **Separation of Concerns**: Keep data, presentation, and business logic separate
3. **Documentation**: Include clear descriptions and setup instructions
4. **Platform Support**: Specify supported platforms and devices
5. **Code Organization**: Follow the established file structure pattern
6. **State Management**: Use BLoC pattern for complex state management

## Dependencies

- **flutter_bloc**: State management
- **flutter_svg**: SVG support
- **dart:math**: Mathematical operations for effects

This structure provides a scalable, maintainable foundation for a comprehensive UI component library with clear separation of concerns and consistent patterns throughout. 