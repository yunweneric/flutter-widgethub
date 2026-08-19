import 'package:flutter/material.dart';
import 'package:flutterui/app/shared/presentation/utils/icons.dart';
import 'package:hugeicons/hugeicons.dart';

/// Renders a glyph from the [AppIcons] catalogue.
///
/// Behaves like Flutter's own `Icon`: when [color] is omitted the glyph takes
/// the ambient [IconTheme] colour, so a control that recolours its contents on
/// hover (`AppIconButton`, for one) lifts the icon along with its label.
class AppIcon extends StatelessWidget {
  final AppIconData icon;
  final double? size;
  final Color? color;

  /// Overrides the catalogue's default stroke weight for the rare glyph that
  /// needs to read heavier or lighter than its neighbours.
  final double? strokeWidth;

  const AppIcon({
    super.key,
    required this.icon,
    this.color,
    this.size,
    this.strokeWidth,
  });

  /// Default stroke weight, matched to the app's hairline borders.
  static const double defaultStrokeWidth = 1.6;

  /// Fallback size when neither the call site nor the ambient theme says.
  static const double defaultSize = 18;

  @override
  Widget build(BuildContext context) {
    final iconTheme = IconTheme.of(context);
    final Color resolved = color ??
        iconTheme.color ??
        Theme.of(context).colorScheme.onSurfaceVariant;
    return HugeIcon(
      icon: icon,
      size: size ?? iconTheme.size ?? defaultSize,
      color: resolved,
      strokeWidth: strokeWidth ?? defaultStrokeWidth,
    );
  }
}
