import 'package:flutter/material.dart';
import 'package:flutterui/app/shared/presentation/theme/app_tokens.dart';

/// Navigation bar shell.
///
/// Full-width 64px bar with a hairline bottom border and a translucent
/// background, centering its content on a max-width column — the shadcn
/// docs header layout.
class AppContainer extends StatelessWidget {
  final Widget child;
  final bool isHomeScreenLayout;

  /// Maximum width for the nav content column.
  static const double maxContentWidth = 1400;

  const AppContainer(
      {super.key, required this.child, required this.isHomeScreenLayout});

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    return Container(
      width: double.infinity,
      height: 64,
      decoration: BoxDecoration(
        color: tokens.background.withValues(alpha: 0.92),
        border: Border(bottom: BorderSide(color: tokens.border)),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: maxContentWidth),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpace.xl),
            child: child,
          ),
        ),
      ),
    );
  }
}
