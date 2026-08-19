import 'package:flutter/material.dart';
import 'package:flutterui/app/shared/presentation/theme/app_motion.dart';
import 'package:flutterui/app/shared/presentation/theme/app_tokens.dart';

/// The surface every chrome-level action control sits on.
///
/// Icon-only actions used to be bare glyphs on the nav pill, which read as
/// flat and gave no hit-target affordance until hover. They now share one
/// recessed, hairlined chip: a fill lifted off the pill, a border that
/// warms on hover and a hairline shadow in light mode, where there is no
/// ambient contrast to define the edge.
class AppActionSurface {
  const AppActionSurface._();

  /// Standard control height for nav-bar actions.
  static const double size = 36;

  static Color fill(AppTokens tokens, {required bool hovered}) {
    if (tokens.isDark) {
      return hovered
          ? Color.alphaBlend(Colors.white.withValues(alpha: 0.07), tokens.card)
          : tokens.active;
    }
    return hovered ? tokens.active : tokens.background;
  }

  static Color borderColor(AppTokens tokens, {required bool hovered}) =>
      hovered ? tokens.muted.withValues(alpha: 0.35) : tokens.border;

  /// Icon / label colour, so glyphs lift on hover instead of staying muted.
  static Color foreground(AppTokens tokens, {required bool hovered}) =>
      hovered ? tokens.foreground : tokens.mutedForeground;

  static BoxDecoration decoration(
    AppTokens tokens, {
    required bool hovered,
    Color? color,
    BorderRadius? radius,
  }) =>
      BoxDecoration(
        color: color ?? fill(tokens, hovered: hovered),
        borderRadius: radius ?? AppRadii.mdAll,
        border: Border.all(color: borderColor(tokens, hovered: hovered)),
        boxShadow: tokens.isDark
            ? null
            : [
                BoxShadow(
                  color: Colors.black.withValues(alpha: hovered ? 0.07 : 0.04),
                  blurRadius: hovered ? 6 : 3,
                  offset: Offset(0, hovered ? 2 : 1),
                ),
              ],
      );
}

/// Reusable icon button on the shared [AppActionSurface].
///
/// A 36x36 chip by default; pass [padding] with no [width] for a pill that
/// sizes to its content (the star counter, for one).
class AppIconButton extends StatefulWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;
  final String? tooltip;

  /// Fixed width; null lets [padding] size the control.
  final double? width;

  /// Drops the surface for contexts that already provide their own frame.
  final bool ghost;

  const AppIconButton({
    super.key,
    required this.child,
    this.onPressed,
    this.backgroundColor,
    this.padding,
    this.tooltip,
    this.width = AppActionSurface.size,
    this.ghost = false,
  });

  @override
  State<AppIconButton> createState() => _AppIconButtonState();
}

class _AppIconButtonState extends State<AppIconButton> {
  bool _hovered = false;
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final Color fg = AppActionSurface.foreground(tokens, hovered: _hovered);

    Widget button = MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onPressed,
        onTapDown: (_) => setState(() => _pressed = true),
        onTapUp: (_) => setState(() => _pressed = false),
        onTapCancel: () => setState(() => _pressed = false),
        child: AnimatedScale(
          scale: _pressed ? 0.94 : 1,
          duration: AppMotion.fast,
          curve: Curves.easeOut,
          child: AnimatedContainer(
            duration: AppMotion.fast,
            curve: Curves.easeOut,
            width: widget.width,
            height: AppActionSurface.size,
            padding: widget.padding,
            alignment: Alignment.center,
            decoration: widget.ghost
                ? BoxDecoration(
                    color: _hovered ? tokens.active : Colors.transparent,
                    borderRadius: AppRadii.mdAll,
                  )
                : AppActionSurface.decoration(
                    tokens,
                    hovered: _hovered,
                    color: widget.backgroundColor,
                  ),
            // Children pick the glyph colour up from here, so hover lifts
            // the whole control at once.
            child: IconTheme.merge(
              data: IconThemeData(color: fg),
              child: widget.child,
            ),
          ),
        ),
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
