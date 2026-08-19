import 'package:flutter/material.dart';
import 'package:flutterui/app/shared/presentation/theme/app_motion.dart';
import 'package:flutterui/app/shared/presentation/theme/app_tokens.dart';
import 'package:flutterui/app/shared/presentation/theme/app_typography.dart';
import 'package:flutterui/app/shared/presentation/utils/util.dart';
import 'package:go_router/go_router.dart';

/// Inline text link that fades to the palette accent on hover.
///
/// Points at either an in-app [route] or an external [url]; the external
/// case opens in a new tab on web.
class AppTextLink extends StatefulWidget {
  final String label;
  final String? route;
  final String? url;
  final double fontSize;

  const AppTextLink({
    super.key,
    required this.label,
    this.route,
    this.url,
    this.fontSize = 13.5,
  });

  @override
  State<AppTextLink> createState() => _AppTextLinkState();
}

class _AppTextLinkState extends State<AppTextLink> {
  bool _hovered = false;

  void _open() {
    final route = widget.route;
    if (route != null) {
      context.go(route);
      return;
    }
    final url = widget.url;
    if (url != null) UtilHelper.openUrl(url);
  }

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: _open,
        child: AnimatedDefaultTextStyle(
          duration: AppMotion.fast,
          style: AppTypography.sans(
            color: _hovered ? tokens.accent : tokens.mutedForeground,
            fontSize: widget.fontSize,
            height: 1.4,
          ),
          child: Text(widget.label),
        ),
      ),
    );
  }
}
