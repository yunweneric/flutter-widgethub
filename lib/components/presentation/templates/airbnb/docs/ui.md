# 🏠 Airbnb Template UI Documentation

## 📋 Overview

The Airbnb Template is a complete Flutter UI implementation that replicates the modern accommodation booking app design. This template showcases professional UI/UX patterns, responsive design, and follows Flutter best practices.

## 🎨 Design System

### Color Palette

| Color | Hex Code | Usage |
|-------|----------|-------|
| **Primary Red** | `#FF5A5F` | Main brand color, buttons, accents |
| **Secondary Teal** | `#00A699` | Secondary actions, highlights |
| **Dark Gray** | `#222222` | Primary text, selected states |
| **Medium Gray** | `#717171` | Secondary text, icons |
| **Light Gray** | `#DDDDDD` | Borders, dividers |
| **Background Gray** | `#F7F7F7` | Secondary backgrounds |
| **White** | `#FFFFFF` | Primary backgrounds, cards |
| **Black** | `#000000` | Status bar text |

### Typography

The template uses Flutter's built-in `TextTheme` system for consistent typography:

- **Display Large**: 32px, Bold - Main headings
- **Display Medium**: 24px, Semi-bold - Section headings
- **Display Small**: 18px, Semi-bold - Subsection headings
- **Headline Medium**: 16px, Semi-bold - Card titles
- **Body Large**: 16px, Medium - Primary text
- **Body Medium**: 14px, Regular - Secondary text
- **Body Small**: 14px, Regular - Captions, metadata
- **Label Large**: 16px, Semi-bold - Button text
- **Label Medium**: 14px, Medium - Small labels
- **Label Small**: 12px, Regular - Category labels

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

### Theme Integration

All components use `Theme.of(context).textTheme` for typography:

```dart
final textTheme = Theme.of(context).textTheme;

Text(
  'Sample Text',
  style: textTheme.bodyLarge?.copyWith(
    color: AirbnbConstants.darkGray,
    fontWeight: FontWeight.w600,
  ),
)
```

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
│   ├── theme.dart                  # App themes
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

1. **Import Components**:
   ```dart
   import '../shared/shared.dart';
   ```

2. **Use Theme**:
   ```dart
   Theme(
     data: AirbnbTheme.light,
     child: YourWidget(),
   )
   ```

3. **Handle Interactions**:
   ```dart
   onTap: () => handleAction(),
   onFavoriteTap: () => toggleFavorite(),
   ```

### Customization

- **Colors**: Modify `AirbnbConstants` color values
- **Typography**: Update theme text styles
- **Spacing**: Adjust padding and margin constants
- **Icons**: Replace icon constants or add new ones

### Best Practices

1. **Consistent Spacing**: Always use spacing constants
2. **Theme Integration**: Use `Theme.of(context)` for text styles
3. **Error Handling**: Implement fallbacks for all external resources
4. **Performance**: Minimize rebuilds and optimize image loading
5. **Accessibility**: Use semantic labels and proper contrast

## 🚀 Future Enhancements

### Planned Features

- **Dark Theme**: Complete dark mode implementation
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

---

**Note**: This template serves as a foundation for building professional accommodation booking applications. Follow the design system and implementation patterns for consistent, high-quality UI components.
