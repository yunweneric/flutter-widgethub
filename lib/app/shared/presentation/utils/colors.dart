/// Application color constants (legacy compatibility layer).
///
/// The palette is now defined by the semantic design tokens in
/// `theme/app_tokens.dart` (shadcn zinc). This class re-points the old
/// constants at the zinc scale so existing code keeps compiling while it
/// migrates to `context.tokens`.
library;

import 'package:flutter/material.dart';
import 'package:flutterui/app/shared/presentation/theme/app_tokens.dart';

/// Legacy color constants, aligned to the zinc token palette.
///
/// Prefer `context.tokens` (see [AppTokens]) in new code — these constants
/// cannot adapt to the active theme mode.
class AppColors {
  static const Color primary = ZincColors.zinc900;

  // Background colors
  static const Color bg = Colors.white;
  static const Color bgDark = ZincColors.zinc950;
  static const Color bgCardDark = ZincColors.zinc900;

  static const Color darkPrimary = ZincColors.zinc800;
  static const Color bgGray = ZincColors.zinc500;
  static const Color bgGray2 = ZincColors.zinc200;
  static const Color bgGray3 = ZincColors.zinc50;

  // Card colors
  static const Color cardColor = ZincColors.zinc100;
  static const Color red = Color(0xFFEF4444);
  static const Color darkRed = Color(0xFF7F1D1D);

  // Text colors
  static const Color textBlack = ZincColors.zinc950;
  static const Color textGrey = ZincColors.zinc500;
  static const Color textWhite = ZincColors.zinc50;
}
