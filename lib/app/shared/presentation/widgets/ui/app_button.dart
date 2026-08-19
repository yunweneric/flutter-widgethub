/// shadcn-style button primitive.
///
/// A single button widget with `variant` + `size` axes, mirroring the
/// shadcn/ui button API: primary, secondary, outline, ghost, destructive
/// and link variants in sm / md / lg / icon sizes.
library;

import 'package:flutter/material.dart';
import 'package:flutterui/app/shared/presentation/theme/app_tokens.dart';
import 'package:flutterui/app/shared/presentation/theme/app_typography.dart';

/// Visual style of an [AppButton].
enum AppButtonVariant { primary, secondary, outline, ghost, destructive, link }

/// Size of an [AppButton].
enum AppButtonSize { sm, md, lg, icon }

/// shadcn-style button.
///
/// ```dart
/// AppButton(label: 'Get Started', onPressed: () {});
/// AppButton(
///   label: 'Browse',
///   variant: AppButtonVariant.outline,
///   trailing: Icon(Icons.arrow_forward, size: 16),
///   onPressed: () {},
/// );
/// AppButton.icon(icon: Icon(Icons.copy, size: 16), onPressed: () {});
/// ```
class AppButton extends StatefulWidget {
  final String? label;
  final Widget? leading;
  final Widget? trailing;
  final Widget? child;
  final AppButtonVariant variant;
  final AppButtonSize size;
  final VoidCallback? onPressed;
  final String? tooltip;

  const AppButton({
    super.key,
    this.label,
    this.leading,
    this.trailing,
    this.child,
    this.variant = AppButtonVariant.primary,
    this.size = AppButtonSize.md,
    this.onPressed,
    this.tooltip,
  }) : assert(label != null || child != null,
            'Provide either a label or a child');

  /// Square icon-only button (ghost by default).
  const AppButton.icon({
    super.key,
    required Widget icon,
    this.variant = AppButtonVariant.ghost,
    this.size = AppButtonSize.icon,
    this.onPressed,
    this.tooltip,
  })  : child = icon,
        label = null,
        leading = null,
        trailing = null;

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  bool _hovered = false;
  bool _pressed = false;

  EdgeInsets get _padding {
    switch (widget.size) {
      case AppButtonSize.sm:
        return const EdgeInsets.symmetric(horizontal: 12, vertical: 9);
      case AppButtonSize.md:
        return const EdgeInsets.symmetric(horizontal: 16, vertical: 13);
      case AppButtonSize.lg:
        return const EdgeInsets.symmetric(horizontal: 24, vertical: 15);
      case AppButtonSize.icon:
        return EdgeInsets.zero;
    }
  }

  double get _fontSize => widget.size == AppButtonSize.sm ? 13 : 14;

  ({Color bg, Color fg, Color? border}) _colors(AppTokens tokens) {
    final bool hovered = _hovered;
    switch (widget.variant) {
      case AppButtonVariant.primary:
        return (
          bg: hovered
              ? tokens.primary.withValues(alpha: 0.9)
              : tokens.primary,
          fg: tokens.primaryForeground,
          border: null,
        );
      case AppButtonVariant.secondary:
        return (
          bg: hovered
              ? tokens.secondary.withValues(alpha: 0.8)
              : tokens.secondary,
          fg: tokens.secondaryForeground,
          border: null,
        );
      case AppButtonVariant.outline:
        return (
          bg: hovered ? tokens.accent : tokens.background,
          fg: hovered ? tokens.accentForeground : tokens.foreground,
          border: tokens.input,
        );
      case AppButtonVariant.ghost:
        return (
          bg: hovered ? tokens.accent : Colors.transparent,
          fg: hovered ? tokens.accentForeground : tokens.foreground,
          border: null,
        );
      case AppButtonVariant.destructive:
        return (
          bg: hovered
              ? tokens.destructive.withValues(alpha: 0.9)
              : tokens.destructive,
          fg: tokens.destructiveForeground,
          border: null,
        );
      case AppButtonVariant.link:
        return (
          bg: Colors.transparent,
          fg: tokens.foreground,
          border: null,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final bool disabled = widget.onPressed == null;
    final colors = _colors(tokens);

    Widget content;
    if (widget.child != null) {
      content = IconTheme(
        data: IconThemeData(color: colors.fg, size: 16),
        child: widget.child!,
      );
    } else {
      content = Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.leading != null) ...[
            IconTheme(
              data: IconThemeData(color: colors.fg, size: 16),
              child: widget.leading!,
            ),
            const SizedBox(width: 8),
          ],
          Text(
            widget.label!,
            style: AppTypography.sans(
              color: colors.fg,
              fontSize: _fontSize,
              fontWeight: FontWeight.w500,
              height: 1.0,
            ).copyWith(
              decoration: widget.variant == AppButtonVariant.link && _hovered
                  ? TextDecoration.underline
                  : null,
              decorationColor: colors.fg,
            ),
          ),
          if (widget.trailing != null) ...[
            const SizedBox(width: 8),
            IconTheme(
              data: IconThemeData(color: colors.fg, size: 16),
              child: widget.trailing!,
            ),
          ],
        ],
      );
    }

    Widget button = AnimatedOpacity(
      duration: const Duration(milliseconds: 120),
      opacity: disabled ? 0.5 : (_pressed ? 0.85 : 1.0),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeOut,
        height: widget.size == AppButtonSize.icon ? 36 : null,
        width: widget.size == AppButtonSize.icon ? 36 : null,
        padding: _padding,
        alignment:
            widget.size == AppButtonSize.icon ? Alignment.center : null,
        decoration: BoxDecoration(
          color: colors.bg,
          borderRadius: AppRadii.mdAll,
          border:
              colors.border != null ? Border.all(color: colors.border!) : null,
        ),
        child: content,
      ),
    );

    button = MouseRegion(
      cursor: disabled ? MouseCursor.defer : SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: disabled ? null : widget.onPressed,
        onTapDown: disabled ? null : (_) => setState(() => _pressed = true),
        onTapUp: disabled ? null : (_) => setState(() => _pressed = false),
        onTapCancel:
            disabled ? null : () => setState(() => _pressed = false),
        child: button,
      ),
    );

    if (widget.tooltip != null) {
      button = Tooltip(
        message: widget.tooltip!,
        waitDuration: const Duration(milliseconds: 500),
        child: button,
      );
    }
    return button;
  }
}
