/// Design tokens for the application (LingoDesk design language).
///
/// [AppTokens] resolves the semantic colour roles of the active
/// [AppPalette] variant at the current brightness. Switching variants in
/// the theme picker repaints every widget that reads tokens — which is
/// all of the chrome.
library;

import 'package:flutter/material.dart';
import 'package:flutterui/app/shared/presentation/theme/app_palette.dart';

/// Raw zinc gray scale.
///
/// Kept for the always-dark code-block surface and the legacy content
/// compatibility layer; chrome colour comes from [AppTokens].
class ZincColors {
  ZincColors._();

  static const Color zinc50 = Color(0xFFFAFAFA);
  static const Color zinc100 = Color(0xFFF4F4F5);
  static const Color zinc200 = Color(0xFFE4E4E7);
  static const Color zinc300 = Color(0xFFD4D4D8);
  static const Color zinc400 = Color(0xFFA1A1AA);
  static const Color zinc500 = Color(0xFF71717A);
  static const Color zinc600 = Color(0xFF52525B);
  static const Color zinc700 = Color(0xFF3F3F46);
  static const Color zinc800 = Color(0xFF27272A);
  static const Color zinc900 = Color(0xFF18181B);
  static const Color zinc950 = Color(0xFF09090B);
}

/// Border radius scale — 12px does almost all the work; 8px nested,
/// 16px dialogs and hero panes.
class AppRadii {
  AppRadii._();

  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 20;

  static BorderRadius get smAll => BorderRadius.circular(sm);
  static BorderRadius get mdAll => BorderRadius.circular(md);
  static BorderRadius get lgAll => BorderRadius.circular(lg);
  static BorderRadius get xlAll => BorderRadius.circular(xl);
}

/// 4pt spacing scale.
class AppSpace {
  AppSpace._();

  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 24;
  static const double xxl = 32;
  static const double xxxl = 48;
  static const double huge = 64;
}

/// Status colours — the one part of the palette that does *not* follow
/// the chosen variant. A failure is red and a success is green in all six
/// looks; only the brand roles change.
class AppStatusColors {
  const AppStatusColors._();

  static const complete = Color(0xFF15803D);
  static const error = Color(0xFFDC2626);
  static const warning = Color(0xFFB45309);

  static const successSoft = Color(0xFFE8F3EB);
  static const successSoftBorder = Color(0xFFC6E2D0);
  static const successDeep = Color(0xFF10301E);
  static const successDeepBorder = Color(0xFF2E7D4F);
  static const successLift = Color(0xFF4ADE80);

  static const errorSoft = Color(0xFFFDECEC);
  static const errorSoftBorder = Color(0xFFF6CFCF);
  static const errorDeep = Color(0xFF351A1A);
  static const errorDeepBorder = Color(0xFF9B3A3A);
  static const errorLift = Color(0xFFF87171);

  static const warningSoft = Color(0xFFFDF2E3);
  static const warningSoftBorder = Color(0xFFF0D9B4);
  static const warningDeep = Color(0xFF33240F);
  static const warningDeepBorder = Color(0xFF8E5F1E);
  static const warningLift = Color(0xFFFBBF24);
}

/// The handful of things the app ever needs to say about an outcome.
enum AppStatus { success, error, warning, info, neutral }

/// Colours for one [AppStatus] at the current brightness.
class AppStatusStyle {
  const AppStatusStyle({
    required this.accent,
    required this.fill,
    required this.border,
    required this.foreground,
  });

  final Color accent;
  final Color fill;
  final Color border;
  final Color foreground;

  static AppStatusStyle of(BuildContext context, AppStatus status) =>
      resolve(context.tokens, status);

  static AppStatusStyle resolve(AppTokens tokens, AppStatus status) {
    final isDark = tokens.isDark;
    switch (status) {
      case AppStatus.success:
        return AppStatusStyle(
          accent: isDark
              ? AppStatusColors.successLift
              : AppStatusColors.complete,
          fill: isDark
              ? AppStatusColors.successDeep
              : AppStatusColors.successSoft,
          border: isDark
              ? AppStatusColors.successDeepBorder
              : AppStatusColors.successSoftBorder,
          foreground: tokens.foreground,
        );
      case AppStatus.error:
        return AppStatusStyle(
          accent: isDark ? AppStatusColors.errorLift : AppStatusColors.error,
          fill: isDark ? AppStatusColors.errorDeep : AppStatusColors.errorSoft,
          border: isDark
              ? AppStatusColors.errorDeepBorder
              : AppStatusColors.errorSoftBorder,
          foreground: tokens.foreground,
        );
      case AppStatus.warning:
        return AppStatusStyle(
          accent: isDark
              ? AppStatusColors.warningLift
              : AppStatusColors.warning,
          fill: isDark
              ? AppStatusColors.warningDeep
              : AppStatusColors.warningSoft,
          border: isDark
              ? AppStatusColors.warningDeepBorder
              : AppStatusColors.warningSoftBorder,
          foreground: tokens.foreground,
        );
      case AppStatus.info:
        return AppStatusStyle(
          accent: tokens.accent,
          fill: tokens.brandFill,
          border: tokens.brandFillBorder,
          foreground: tokens.foreground,
        );
      case AppStatus.neutral:
        return AppStatusStyle(
          accent: tokens.muted,
          fill: tokens.card,
          border: tokens.border,
          foreground: tokens.foreground,
        );
    }
  }
}

/// Semantic colour tokens for the active theme variant and brightness.
class AppTokens {
  AppTokens({required this.palette, required this.isDark})
      : _scheme = isDark ? palette.dark : palette.light;

  final AppPalette palette;
  final bool isDark;
  final AppScheme _scheme;

  AppThemeVariant get variant => palette.variant;

  /// The always-dark scheme, for panes that stay dark in both modes.
  AppScheme get darkStage => palette.dark;

  // LingoDesk colour roles — the vocabulary new chrome code should use.
  Color get brand => _scheme.brand;
  Color get onBrand => _scheme.onBrand;
  Color get accent => _scheme.accent;
  Color get brandFill => _scheme.brandFill;
  Color get brandFillBorder => _scheme.brandFillBorder;
  Color get onBrandFill => _scheme.onBrandFill;
  Color get background => _scheme.background;
  Color get sidebar => _scheme.sidebar;
  Color get card => _scheme.card;
  Color get border => _scheme.border;
  Color get foreground => _scheme.foreground;
  Color get muted => _scheme.muted;
  Color get active => _scheme.active;

  // Compatibility getters for chrome written against the previous
  // shadcn-style token names. Same intent, resolved to scheme roles.
  Color get cardForeground => _scheme.foreground;
  Color get popover => _scheme.card;
  Color get popoverForeground => _scheme.foreground;
  Color get primary => _scheme.brand;
  Color get primaryForeground => _scheme.onBrand;
  Color get secondary => _scheme.brandFill;
  Color get secondaryForeground => _scheme.onBrandFill;
  Color get mutedForeground => _scheme.muted;
  Color get mutedSurface => _scheme.active;
  Color get accentForeground => _scheme.foreground;
  Color get destructive =>
      isDark ? AppStatusColors.errorLift : AppStatusColors.error;
  Color get destructiveForeground => Colors.white;
  Color get input => _scheme.border;
  Color get ring => _scheme.accent;

  /// Background for code blocks — dark in both themes.
  Color get codeBackground => ZincColors.zinc900;

  /// Foreground for code blocks.
  Color get codeForeground => ZincColors.zinc200;

  static AppTokens of(BuildContext context) {
    final theme = Theme.of(context);
    return AppTokens(
      // A theme built outside AppTheme carries no extension — fall back
      // to the house look.
      palette: theme.extension<AppPalette>() ?? AppPalettes.teal,
      isDark: theme.brightness == Brightness.dark,
    );
  }
}

/// Convenience accessors for design tokens.
extension AppTokensX on BuildContext {
  /// Resolves the current [AppTokens] from the active theme.
  AppTokens get tokens => AppTokens.of(this);
}
