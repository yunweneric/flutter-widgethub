# 🏠 Airbnb Template UI Documentation

## 📋 Overview

The Airbnb Template is a complete Flutter UI implementation that replicates the modern accommodation booking app design. This template showcases professional UI/UX patterns, responsive design, and follows Flutter best practices.

## 🎨 Design System

### Color Palette

The template uses a centralized color system defined in `AirbnbTheme`:

| Color | Theme Reference | Usage |
|-------|----------------|-------|
| **Primary Red** | `AirbnbTheme.primaryRed` | Main brand color, buttons, accents |
| **Secondary Teal** | `AirbnbTheme.secondaryTeal` | Secondary actions, highlights |
| **Dark Gray** | `AirbnbTheme.darkGray` | Primary text, selected states |
| **Medium Gray** | `AirbnbTheme.mediumGray` | Secondary text, icons |
| **Light Gray** | `AirbnbTheme.lightGray` | Borders, dividers |
| **Background Gray** | `AirbnbTheme.backgroundGray` | Secondary backgrounds |
| **White** | `AirbnbTheme.white` | Primary backgrounds, cards |
| **Black** | `AirbnbTheme.black` | Status bar text |

### Typography

The template uses Flutter's built-in `TextTheme` system for consistent typography, with all styles defined in `AirbnbTheme`:

- **Display Large**: `Theme.of(context).textTheme.displayLarge` - Main headings
- **Display Medium**: `Theme.of(context).textTheme.displayMedium` - Section headings
- **Display Small**: `Theme.of(context).textTheme.displaySmall` - Subsection headings
- **Headline Medium**: `Theme.of(context).textTheme.headlineMedium` - Card titles
- **Body Large**: `Theme.of(context).textTheme.bodyLarge` - Primary text
- **Body Medium**: `Theme.of(context).textTheme.bodyMedium` - Secondary text
- **Body Small**: `Theme.of(context).textTheme.bodySmall` - Captions, metadata
- **Label Large**: `Theme.of(context).textTheme.labelLarge` - Button text
- **Label Medium**: `Theme.of(context).textTheme.labelMedium` - Small labels

**Note**: Only use the text styles that are explicitly defined in `AirbnbTheme`. Do not reference undefined text styles like `labelSmall`.

### Spacing System

Consistent 8px grid system:

| Size | Value | Usage |
|------|-------|-------|
| **XS** | 4px | Minimal spacing, dots |
| **S** | 8px | Small spacing, icons |
| **M** | 16px | Standard spacing |
| **L** | 24px | Large spacing, margins |
| **XL** | 32px | Extra large spacing |

### Border Radius

| Size | Value | Usage |
|------|-------|-------|
| **S** | 8px | Buttons, small elements |
| **M** | 12px | Cards, property images |
| **L** | 16px | Category icons |
| **XL** | 24px | Large containers |
| **XXL** | 32px | Search bar, inputs |

### Elevation & Shadows

- **Light**: 2px blur, 0.1 opacity - Cards, buttons
- **Medium**: 4px blur, 0.1 opacity - Elevated elements
- **Heavy**: 8px blur, 0.1 opacity - Bottom navigation

## 🧩 UI Components

### 1. Search Bar (`AirbnbSearchBar`)

**Purpose**: Main search interface for property discovery

**Features**:
- Magnifying glass icon with search text
- Subtitle showing search parameters
- Filter button with dark background
- Rounded corners and shadow effects
- Interactive tap areas

**Usage**:
```dart
AirbnbSearchBar(
  onTap: () => handleSearch(),
  onFilterTap: () => handleFilter(),
)
```

**Design Details**:
- Height: Auto (content-based)
- Border radius: 32px
- Shadow: 8px blur, 0.1 opacity
- Filter button: Dark gray with white icon

### 2. Category Filter (`CategoryFilter`)

**Purpose**: Horizontal scrollable property categories

**Features**:
- 7 predefined categories with icons
- Interactive selection with visual feedback
- Selected state with underline indicator
- Smooth horizontal scrolling

**Categories**:
1. **OMG!** - Rocket launch icon (default selected)
2. **Beach** - Beach access icon
3. **Amazing pools** - Pool icon
4. **Islands** - Landscape icon
5. **Arctic** - Snowflake icon
6. **Cabins** - Cabin icon
7. **Tiny homes** - Home icon

**Usage**:
```dart
const CategoryFilter()
```

**Design Details**:
- Height: 90px
- Icon size: 60x60px
- Selected state: Dark gray background with white icon
- Underline: 20px width, 2px height

### 3. Property Card (`PropertyCard`)

**Purpose**: Display property information with image and details

**Features**:
- Large property image (250px height)
- Heart favorite button with shadow
- Image counter dots (5 dots, first active)
- Property details: location, distance, dates, price
- Star rating with review count
- Error handling and loading states

**Usage**:
```dart
PropertyCard(
  imageUrl: 'https://example.com/image.jpg',
  location: 'Abiansemal, Indonesia',
  distance: '1,669 kilometers',
  dates: 'Jul 2 - 7',
  price: '\$360 night',
  rating: 4.87,
  reviewCount: 71,
  isFavorite: false,
  onTap: () => handlePropertyTap(),
  onFavoriteTap: () => handleFavorite(),
)
```

**Design Details**:
- Image border radius: 12px
- Favorite button: White background with shadow
- Image dots: Centered at bottom, 6px diameter
- Text hierarchy: Location (bold) → Distance → Dates → Price (bold)

### 4. Map Button (`MapButton`)

**Purpose**: Secondary action to view property on map

**Features**:
- Dark background with map icon
- Centered text and icon
- Rounded corners
- Positioned below property card

**Usage**:
```dart
MapButton(
  onTap: () => handleMapTap(),
)
```

**Design Details**:
- Background: Dark gray
- Border radius: 12px
- Icon size: 20px
- Text: White, semi-bold

### 5. Bottom Navigation

**Purpose**: Main app navigation with 5 tabs

**Tabs**:
1. **Explore** - Magnifying glass icon (active)
2. **Wishlist** - Heart icon
3. **Trips** - Card travel icon
4. **Inbox** - Chat bubble icon (with notification dot)
5. **Profile** - Person icon

**Design Details**:
- Background: White
- Selected color: Dark gray
- Unselected color: Medium gray
- Elevation: 8px shadow
- Fixed type navigation


## 📱 Screen Layout

### Home Screen Structure

```
┌─────────────────────────────────┐
│           Status Bar            │ ← 9:41 + System Icons
├─────────────────────────────────┤
│         Search Bar              │ ← "Where to?" + Filter
├─────────────────────────────────┤
│      Category Filters           │ ← Horizontal Scroll
├─────────────────────────────────┤
│                                │
│         Property Card           │ ← Main Content
│                                │
├─────────────────────────────────┤
│         Map Button              │ ← Secondary Action
├─────────────────────────────────┤
│                                │
│      Bottom Navigation          │ ← 5 Tabs
└─────────────────────────────────┘
```



### Responsive Behavior

- **Width**: Adapts to screen width (320dp - 480dp)
- **Height**: Content-based with proper scrolling
- **Margins**: Consistent 24px horizontal margins
- **Padding**: 16px standard spacing

## 🔧 Implementation Details

### Widget Architecture

All UI components should be implemented as **stateless widgets** instead of functions. This follows Flutter best practices for better performance, reusability, and maintainability.

```dart
// ✅ Correct - Use StatelessWidget
class CustomHeader extends StatelessWidget {
  const CustomHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      child: Text(
        'Header Title',
        style: textTheme.displayLarge,
      ),
    );
  }
}

// ❌ Incorrect - Don't use functions for UI
Widget _buildHeader() {
  return Container(
    child: Text('Header Title'),
  );
}
```

### Theme Integration

All components use `Theme.of(context).textTheme` for typography, referencing only the styles defined in `AirbnbTheme`:

```dart
class SampleWidget extends StatelessWidget {
  const SampleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        // Use only defined text styles from theme.dart
        Text(
          'Sample Text',
          style: textTheme.bodyLarge?.copyWith(
            color: AirbnbTheme.darkGray,
            fontWeight: FontWeight.w600,
          ),
        ),
        
        // For headings, use display styles
        Text(
          'Section Title',
          style: textTheme.displayMedium,
        ),
        
        // For buttons, use label styles
        Text(
          'Button Text',
          style: textTheme.labelLarge,
        ),
      ],
    );
  }
}
```

**Important**: Only use these defined text styles:
- `displayLarge`, `displayMedium`, `displaySmall`
- `headlineMedium`
- `bodyLarge`, `bodyMedium`, `bodySmall`
- `labelLarge`, `labelMedium`

### State Management

- **Favorite State**: Local state in `HomeScreen`
- **Category Selection**: Local state in `CategoryFilter`
- **Navigation**: Local state in `AirbnbLayout`

### Error Handling

- **Image Loading**: Loading indicator with progress
- **Image Errors**: Fallback placeholder with icon
- **Network Issues**: Graceful degradation

### Performance Optimizations

- **Image Caching**: Network image with error handling
- **Lazy Loading**: Single child scroll view
- **Efficient Rebuilds**: Minimal state changes

## 📁 File Structure

```
lib/components/presentation/templates/airbnb/
├── shared/
│   ├── constants.dart              # Design tokens
│   ├── theme.dart                  # App themes (use this for all styling)
│   ├── layout.dart                 # Main layout
│   ├── shared.dart                 # Exports
│   ├── icon_manager.dart           # SVG icons
│   └── components/
│       ├── search_bar.dart         # Search interface
│       ├── category_filter.dart    # Category selection
│       ├── property_card.dart      # Property display
│       └── map_button.dart         # Map action
├── home/
│   └── home_screen.dart            # Main home screen
└── index.dart                      # Main exports
```

## 🎯 Usage Guidelines

### Component Integration

1. **Check Existing Shared Components**: Always check `shared/components/` directory before creating new widgets:
   ```dart
   // Available shared components:
   // - PropertyCard: Property display with image, rating, pricing
   // - MapButton: Map view action button
   // - AirbnbSearchBar: Search interface
   // - CategoryFilter: Category selection
   // - AirbnbBottomNavigationBar: Navigation tabs
   ```

2. **Import Components**:
   ```dart
   import '../shared/shared.dart';
   ```

3. **Use Existing Components**:
   ```dart
   // ✅ Reuse existing PropertyCard
   PropertyCard(
     imageUrl: 'https://picsum.photos/400/300',
     location: 'New York',
     distance: '2 hours away',
     dates: 'May 14 - 19',
     price: '\$200 night',
     rating: 4.8,
     reviewCount: 45,
     isFavorite: true,
   )
   
   // ✅ Reuse existing MapButton
   MapButton(onTap: () => showMap())
   ```

4. **Use Theme**:
   ```dart
   Theme(
     data: AirbnbTheme.light,
     child: YourWidget(),
   )
   ```

5. **Handle Interactions**:
   ```dart
   onTap: () => handleAction(),
   onFavoriteTap: () => toggleFavorite(),
   ```

### Styling Guidelines

1. **Widget Structure**: Always use StatelessWidget for UI components:
   ```dart
   // ✅ Correct - StatelessWidget approach
   class MyCustomButton extends StatelessWidget {
     final String text;
     final VoidCallback? onTap;
     
     const MyCustomButton({
       super.key,
       required this.text,
       this.onTap,
     });
     
     @override
     Widget build(BuildContext context) {
       return GestureDetector(
         onTap: onTap,
         child: Container(
           padding: const EdgeInsets.all(AirbnbConstants.paddingM),
           decoration: BoxDecoration(
             color: AirbnbTheme.primaryRed,
             borderRadius: BorderRadius.circular(AirbnbConstants.radiusM),
           ),
           child: Text(text),
         ),
       );
     }
   }
   
   // ❌ Incorrect - Function approach
   Widget _buildButton(String text, VoidCallback? onTap) {
     return GestureDetector(onTap: onTap, child: Container(...));
   }
   ```

2. **Colors**: Always use `AirbnbTheme` color constants and theme colors:
   ```dart
   // ✅ Correct
   color: AirbnbTheme.primaryRed
   color: AirbnbTheme.darkGray
   color: Theme.of(context).cardColor  // For containers
   
   // ❌ Incorrect - hardcoded values
   color: Color(0xFFFF5A5F)
   ```

3. **Icon Colors**: Don't specify colors for white/black icons - theming handles it automatically:
   ```dart
   // ✅ Correct - No color specified, theme handles it
   Icon(Icons.arrow_back, size: 20)
   Icon(Icons.share, size: 20)
   Icon(Icons.more_vert, size: 20)
   
   // ❌ Avoid specifying white/black colors
   Icon(Icons.arrow_back, color: Colors.white, size: 20)
   Icon(Icons.share, color: Colors.black, size: 20)
   
   // ✅ Only specify custom colors when needed
   Icon(Icons.favorite, color: AirbnbTheme.primaryRed, size: 20)
   ```

4. **Typography**: Always use `Theme.of(context).textTheme` with defined styles:
   ```dart
   // ✅ Correct
   style: Theme.of(context).textTheme.displayLarge
   style: Theme.of(context).textTheme.bodyMedium
   style: Theme.of(context).textTheme.labelLarge
   
   // ❌ Incorrect - undefined styles
   style: Theme.of(context).textTheme.labelSmall
   style: Theme.of(context).textTheme.headlineSmall
   ```

5. **Custom Styling**: When customizing defined styles, use `.copyWith()`:
   ```dart
   style: Theme.of(context).textTheme.bodyLarge?.copyWith(
     color: AirbnbTheme.primaryRed,
     fontWeight: FontWeight.w600,
   )
   ```

### Customization

- **Colors**: Modify color values in `AirbnbTheme` class
- **Typography**: Update theme text styles in `AirbnbTheme.light` and `AirbnbTheme.dark`
- **Spacing**: Adjust padding and margin constants
- **Icons**: Replace icon constants or add new ones

### Best Practices

1. **Widget Architecture**: Always use StatelessWidget for UI components instead of functions
2. **Consistent Theming**: Always use `AirbnbTheme` for colors and typography
3. **Theme Integration**: Use `Theme.of(context).textTheme` for all text styles
4. **Container Colors**: Use `Theme.of(context).cardColor` for container backgrounds
5. **Style Validation**: Only reference text styles that exist in `AirbnbTheme`
6. **Component Reusability**: Create modular, reusable StatelessWidget components
7. **Error Handling**: Implement fallbacks for all external resources
8. **Performance**: Minimize rebuilds and optimize image loading
9. **Accessibility**: Use semantic labels and proper contrast

## 🚀 Future Enhancements

### Planned Features

- **Dark Theme**: Complete dark mode implementation (already defined in `AirbnbTheme.dark`)
- **Animations**: Smooth transitions and micro-interactions
- **Localization**: Multi-language support
- **Accessibility**: Screen reader and keyboard navigation
- **Testing**: Comprehensive widget tests

### Potential Improvements

- **Image Gallery**: Swipeable property images
- **Search History**: Recent searches and suggestions
- **Favorites Management**: Persistent favorite state
- **Map Integration**: Real map implementation
- **Offline Support**: Basic offline functionality

## 📚 References

- **Figma Design**: [Airbnb Clone Design](https://www.figma.com/files/team/834022000025571903/resources/community/file/1372927273293392906?fuid=834021998636722127)
- **Flutter Documentation**: [flutter.dev](https://flutter.dev)
- **Material Design**: [material.io](https://material.io)
- **Project Guidelines**: [CONTRIBUTION.md](./CONTRIBUTION.md)
- **Theme Reference**: `lib/components/presentation/templates/airbnb/shared/theme.dart`

---

**Note**: This template serves as a foundation for building professional accommodation booking applications. Always use the centralized theming system from `AirbnbTheme` for consistent, high-quality UI components. Follow the design system and implementation patterns for maintainable code.
