/// shadcn-style card primitive.
library;

import 'package:flutter/material.dart';
import 'package:flutterui/app/shared/presentation/theme/app_motion.dart';
import 'package:flutterui/app/shared/presentation/theme/app_tokens.dart';

/// Bordered surface with a large radius — the shadcn card.
///
/// Optionally hoverable (subtle border emphasis + lift) and tappable.
class AppCard extends StatefulWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;
  final bool hoverable;
  final Color? color;
  final BorderRadius? borderRadius;
  final Clip clipBehavior;

  const AppCard({
    super.key,
    required this.child,
    this.padding,
    this.onTap,
    this.hoverable = false,
    this.color,
    this.borderRadius,
    this.clipBehavior = Clip.none,
  });

  @override
  State<AppCard> createState() => _AppCardState();
}

class _AppCardState extends State<AppCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final bool interactive = widget.hoverable || widget.onTap != null;

    final bool lifted = interactive && _hovered;
    Widget card = AnimatedContainer(
      duration: AppMotion.fast,
      curve: AppMotion.curve,
      padding: widget.padding,
      clipBehavior: widget.clipBehavior,
      transform: Matrix4.translationValues(
          0, lifted ? -AppMotion.hoverLift : 0, 0),
      decoration: BoxDecoration(
        color: widget.color ?? tokens.card,
        borderRadius: widget.borderRadius ?? AppRadii.mdAll,
        border: Border.all(
          color: lifted ? tokens.accent : tokens.border,
        ),
        boxShadow: lifted
            ? [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.06),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ]
            : null,
      ),
      child: widget.child,
    );

    if (!interactive) return card;

    return MouseRegion(
      cursor: widget.onTap != null
          ? SystemMouseCursors.click
          : MouseCursor.defer,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(onTap: widget.onTap, child: card),
    );
  }
}
