/// shadcn-style tabs primitive (segmented control).
///
/// The muted-background pill switcher used across shadcn docs for
/// Preview | Code toggles.
library;

import 'package:flutter/material.dart';
import 'package:flutterui/app/shared/presentation/theme/app_tokens.dart';
import 'package:flutterui/app/shared/presentation/theme/app_typography.dart';

/// A single tab entry.
class AppTabItem {
  final String label;
  final Widget? icon;

  const AppTabItem({required this.label, this.icon});
}

/// Segmented pill tab switcher.
///
/// ```dart
/// AppTabs(
///   items: [AppTabItem(label: 'Preview'), AppTabItem(label: 'Code')],
///   activeIndex: index,
///   onChanged: (i) => setState(() => index = i),
/// )
/// ```
class AppTabs extends StatelessWidget {
  final List<AppTabItem> items;
  final int activeIndex;
  final ValueChanged<int> onChanged;

  /// Hide labels and show icons only (compact/mobile).
  final bool iconsOnly;

  const AppTabs({
    super.key,
    required this.items,
    required this.activeIndex,
    required this.onChanged,
    this.iconsOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: tokens.muted,
        borderRadius: AppRadii.mdAll,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(items.length, (i) {
          final item = items[i];
          final bool active = i == activeIndex;
          final Color fg =
              active ? tokens.foreground : tokens.mutedForeground;

          return MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () => onChanged(i),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                curve: Curves.easeOut,
                padding: EdgeInsets.symmetric(
                  horizontal: iconsOnly ? 10 : 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: active ? tokens.background : Colors.transparent,
                  borderRadius: AppRadii.smAll,
                  boxShadow: active
                      ? [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.08),
                            blurRadius: 4,
                            offset: const Offset(0, 1),
                          ),
                        ]
                      : null,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (item.icon != null)
                      IconTheme(
                        data: IconThemeData(color: fg, size: 14),
                        child: item.icon!,
                      ),
                    if (item.icon != null && !iconsOnly)
                      const SizedBox(width: 6),
                    if (!iconsOnly)
                      Text(
                        item.label,
                        style: AppTypography.sans(
                          color: fg,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          height: 1.0,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
