import 'package:flutter/material.dart';
import 'package:flutterui/app/shared/presentation/theme/app_tokens.dart';

/// Floating navigation bar shell (LingoDesk style).
///
/// A detached rounded pill sitting on the page background: hairline
/// border, translucent card surface and a soft shadow, centered on a
/// max-width column.
class AppContainer extends StatelessWidget {
  final Widget child;
  final bool isHomeScreenLayout;

  /// Maximum width for the nav pill.
  static const double maxContentWidth = 1160;

  /// Total vertical space the floating bar occupies (pill + margins).
  static const double navHeight = 84;

  const AppContainer(
      {super.key, required this.child, required this.isHomeScreenLayout});

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: double.infinity,
      height: navHeight,
      padding: const EdgeInsets.fromLTRB(
          AppSpace.lg, AppSpace.md, AppSpace.lg, AppSpace.md),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: maxContentWidth),
          child: Container(
            height: 60,
            padding: const EdgeInsets.symmetric(horizontal: AppSpace.lg),
            decoration: BoxDecoration(
              color: (isDark ? tokens.card : tokens.card)
                  .withValues(alpha: isDark ? 0.9 : 0.92),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: tokens.border),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.06),
                  blurRadius: 24,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
