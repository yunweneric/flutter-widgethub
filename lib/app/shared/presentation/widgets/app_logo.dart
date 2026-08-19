import 'package:flutter/material.dart';
import 'package:flutterui/app/shared/presentation/theme/app_motion.dart';
import 'package:flutterui/app/shared/presentation/theme/app_tokens.dart';
import 'package:flutterui/app/shared/presentation/utils/images.dart';

/// Brand logo that follows the active theme variant.
///
/// The mark is tinted with the palette's accent, so switching variants
/// (or brightness) recolours the logo along with the rest of the chrome.
class AppLogo extends StatefulWidget {
  final double width;
  final VoidCallback? onTap;

  const AppLogo({super.key, this.width = 96, this.onTap});

  @override
  State<AppLogo> createState() => _AppLogoState();
}

class _AppLogoState extends State<AppLogo> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    final Widget logo = AnimatedOpacity(
      duration: AppMotion.fast,
      opacity: _hovered ? 0.8 : 1.0,
      child: Image.asset(
        AppImages.logoDark,
        width: widget.width,
        color: tokens.accent,
      ),
    );

    if (widget.onTap == null) return logo;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(onTap: widget.onTap, child: logo),
    );
  }
}
