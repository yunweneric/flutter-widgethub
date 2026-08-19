/// shadcn-style badge primitive.
library;

import 'package:flutter/material.dart';
import 'package:flutterui/app/shared/presentation/theme/app_tokens.dart';
import 'package:flutterui/app/shared/presentation/theme/app_typography.dart';

/// Visual style of an [AppBadge].
enum AppBadgeVariant { primary, secondary, outline, destructive }

/// Small pill label for statuses, categories and counts.
///
/// ```dart
/// AppBadge(label: 'New');
/// AppBadge(label: 'iOS', variant: AppBadgeVariant.outline);
/// ```
class AppBadge extends StatelessWidget {
  final String label;
  final Widget? leading;
  final AppBadgeVariant variant;

  const AppBadge({
    super.key,
    required this.label,
    this.leading,
    this.variant = AppBadgeVariant.secondary,
  });

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    final (Color bg, Color fg, Color? border) = switch (variant) {
      AppBadgeVariant.primary => (
          tokens.primary,
          tokens.primaryForeground,
          null
        ),
      AppBadgeVariant.secondary => (
          tokens.secondary,
          tokens.secondaryForeground,
          null
        ),
      AppBadgeVariant.outline => (
          Colors.transparent,
          tokens.foreground,
          tokens.border
        ),
      AppBadgeVariant.destructive => (
          tokens.destructive,
          tokens.destructiveForeground,
          null
        ),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(999),
        border: border != null ? Border.all(color: border) : null,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (leading != null) ...[
            IconTheme(
              data: IconThemeData(color: fg, size: 12),
              child: leading!,
            ),
            const SizedBox(width: 4),
          ],
          Text(
            label,
            style: AppTypography.sans(
              color: fg,
              fontSize: 12,
              fontWeight: FontWeight.w600,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}
