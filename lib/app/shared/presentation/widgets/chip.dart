import 'package:flutter/material.dart';
import 'package:flutterui/app/shared/presentation/theme/app_tokens.dart';
import 'package:flutterui/app/shared/presentation/theme/app_typography.dart';
import 'package:flutterui/app/shared/presentation/widgets/icon.dart';

/// Compact toggle chip used in toolbars (e.g. Preview | Code | Copy).
///
/// Restyled to the shadcn look: active = solid secondary surface with
/// foreground text, inactive = ghost with muted foreground.
class AppChip extends StatefulWidget {
  final String icon;
  final String? title;
  final bool? active;
  final EdgeInsetsGeometry? padding;
  final void Function()? onTap;

  const AppChip({
    super.key,
    required this.icon,
    this.title,
    this.active,
    this.padding,
    this.onTap,
  });

  @override
  State<AppChip> createState() => _AppChipState();
}

class _AppChipState extends State<AppChip> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final bool active = widget.active ?? false;

    final Color bg = active
        ? tokens.secondary
        : _hovered
            ? tokens.accent.withValues(alpha: 0.7)
            : Colors.transparent;
    final Color fg = active ? tokens.foreground : tokens.mutedForeground;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          curve: Curves.easeOut,
          padding: widget.padding ??
              const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
          decoration: BoxDecoration(
            color: bg,
            borderRadius: AppRadii.smAll,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppIcon(icon: widget.icon, color: fg, size: 15),
              if (widget.title != null) ...[
                const SizedBox(width: 6),
                Text(
                  widget.title!,
                  style: AppTypography.sans(
                    color: fg,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    height: 1.0,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
