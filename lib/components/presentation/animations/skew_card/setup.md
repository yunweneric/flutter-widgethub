# Setup Guide

## 1. Dependencies

Add the following to your `pubspec.yaml`:

```yaml
dependencies:
  flutter: ">=3.0.0"
  your_package: ^1.0.0
```

## 2. Import

```dart
import 'package:your_package/skew_card/widget.dart';
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
3. Use the `SkewCard` widget in your widget tree.

See [usage.md](usage.md) for full examples. 