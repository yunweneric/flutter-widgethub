/// 404 Not Found error screen.
///
/// Displays when a user navigates to a route that doesn't exist.
/// Provides a way to navigate back to the home page.
library;

import 'package:flutter/material.dart';
import 'package:flutterui/app/core/routes/route_names.dart';
import 'package:flutterui/app/shared/presentation/theme/app_tokens.dart';
import 'package:flutterui/app/shared/presentation/theme/app_typography.dart';
import 'package:flutterui/app/shared/presentation/utils/lang_util.dart';
import 'package:flutterui/app/shared/presentation/utils/sizing.dart';
import 'package:flutterui/app/shared/presentation/widgets/ui/app_button.dart';
import 'package:go_router/go_router.dart';

/// Screen displayed when a route is not found.
class NotFoundScreen extends StatelessWidget {
  /// Creates a not found screen.
  const NotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    return Scaffold(
      backgroundColor: tokens.background,
      body: SizedBox(
        width: AppSizing.width(context),
        height: AppSizing.height(context),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '404',
              style: AppTypography.mono(
                color: tokens.mutedForeground,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: AppSpace.md),
            Text(LangUtil.trans("pageNotFound"), style: context.text.h2),
            const SizedBox(height: AppSpace.xl),
            AppButton(
              label: LangUtil.trans("home"),
              variant: AppButtonVariant.outline,
              onPressed: () => context.go(RouteNames.home),
            ),
          ],
        ),
      ),
    );
  }
}
