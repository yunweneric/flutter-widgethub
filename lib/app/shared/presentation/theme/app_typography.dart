/// Typography system for the application (shadcn-style).
///
/// Two layers:
///  1. [AppTypography.textTheme] — the Material [TextTheme] registered on
///     [ThemeData]. Slot sizes stay compatible with how existing library
///     content consumes them (displayMedium as a 16-17px section heading,
///     bodyMedium as 14px muted body, etc.) while gaining a complete ramp,
///     tight heading tracking and token-driven colors.
///  2. [AppTextStyles] — semantic docs-site styles (display, h1-h4, lead,
///     muted, code...) used by the app chrome, resolved via `context.text`.
///
/// All sizes are fixed logical pixels — no `.sp` scaling.
library;

import 'package:flutter/material.dart';
import 'package:flutterui/app/shared/presentation/theme/app_tokens.dart';
import 'package:google_fonts/google_fonts.dart';

/// Builds the Material [TextTheme] from design tokens.
class AppTypography {
  AppTypography._();

  /// Base sans-serif style (Inter).
  static TextStyle sans({
    required Color color,
    required double fontSize,
    FontWeight fontWeight = FontWeight.w400,
    double? height,
    double? letterSpacing,
  }) {
    return GoogleFonts.inter(
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
      height: height,
      letterSpacing: letterSpacing,
    );
  }

  /// Base monospace style (JetBrains Mono) for code.
  static TextStyle mono({
    required Color color,
    double fontSize = 13,
    FontWeight fontWeight = FontWeight.w400,
    double? height,
  }) {
    return GoogleFonts.jetBrainsMono(
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
      height: height,
    );
  }

  /// Material text theme derived from [tokens].
  ///
  /// Headings use the foreground token with tight tracking; body and label
  /// slots use the muted foreground, matching how the existing screens and
  /// library content already consume them.
  static TextTheme textTheme(AppTokens tokens) {
    final Color fg = tokens.foreground;
    final Color muted = tokens.mutedForeground;

    return TextTheme(
      // Legacy-compatible slots (sizes preserved from the previous theme).
      displayLarge: sans(
          color: fg, fontSize: 32, fontWeight: FontWeight.w800, letterSpacing: -0.8, height: 1.2),
      displayMedium: sans(
          color: fg, fontSize: 17, fontWeight: FontWeight.w600, letterSpacing: -0.2, height: 1.35),
      displaySmall: sans(
          color: fg, fontSize: 13, fontWeight: FontWeight.w600, height: 1.35),
      // Full heading ramp.
      headlineLarge: sans(
          color: fg, fontSize: 28, fontWeight: FontWeight.w700, letterSpacing: -0.6, height: 1.25),
      headlineMedium: sans(
          color: fg, fontSize: 24, fontWeight: FontWeight.w600, letterSpacing: -0.45, height: 1.25),
      headlineSmall: sans(
          color: fg, fontSize: 20, fontWeight: FontWeight.w600, letterSpacing: -0.3, height: 1.3),
      titleLarge: sans(
          color: fg, fontSize: 18, fontWeight: FontWeight.w600, letterSpacing: -0.2, height: 1.35),
      titleMedium: sans(
          color: fg, fontSize: 16, fontWeight: FontWeight.w600, height: 1.4),
      titleSmall: sans(
          color: fg, fontSize: 14, fontWeight: FontWeight.w600, height: 1.4),
      // Body.
      bodyLarge: sans(color: fg, fontSize: 16, height: 1.6),
      bodyMedium: sans(
          color: muted, fontSize: 14, height: 1.55, letterSpacing: 0.05),
      bodySmall: sans(color: muted, fontSize: 12, height: 1.5),
      // Labels.
      labelLarge: sans(
          color: fg, fontSize: 14, fontWeight: FontWeight.w500, height: 1.4),
      labelMedium: sans(color: muted, fontSize: 14, height: 1.4),
      labelSmall:
          sans(color: muted, fontSize: 12, height: 1.4, letterSpacing: 0),
    );
  }
}

/// Semantic text styles for the app chrome (docs-site typography).
///
/// Resolved from the active theme via `context.text`.
class AppTextStyles {
  final AppTokens _tokens;

  const AppTextStyles(this._tokens);

  /// Hero display headline — 48/800, tight tracking.
  TextStyle get display => AppTypography.sans(
      color: _tokens.foreground,
      fontSize: 48,
      fontWeight: FontWeight.w800,
      letterSpacing: -1.6,
      height: 1.1);

  /// Page title — 36/700.
  TextStyle get h1 => AppTypography.sans(
      color: _tokens.foreground,
      fontSize: 36,
      fontWeight: FontWeight.w700,
      letterSpacing: -1.0,
      height: 1.15);

  /// Section title — 30/600.
  TextStyle get h2 => AppTypography.sans(
      color: _tokens.foreground,
      fontSize: 30,
      fontWeight: FontWeight.w600,
      letterSpacing: -0.75,
      height: 1.2);

  /// Sub-section title — 24/600.
  TextStyle get h3 => AppTypography.sans(
      color: _tokens.foreground,
      fontSize: 24,
      fontWeight: FontWeight.w600,
      letterSpacing: -0.6,
      height: 1.25);

  /// Minor heading — 20/600.
  TextStyle get h4 => AppTypography.sans(
      color: _tokens.foreground,
      fontSize: 20,
      fontWeight: FontWeight.w600,
      letterSpacing: -0.4,
      height: 1.3);

  /// Lead paragraph under titles — 18/400 muted.
  TextStyle get lead => AppTypography.sans(
      color: _tokens.mutedForeground, fontSize: 18, height: 1.55);

  /// Default paragraph — 16/400.
  TextStyle get p => AppTypography.sans(
      color: _tokens.foreground, fontSize: 16, height: 1.6);

  /// Emphasized small text — 14/500.
  TextStyle get small => AppTypography.sans(
      color: _tokens.foreground,
      fontSize: 14,
      fontWeight: FontWeight.w500,
      height: 1.4);

  /// Muted small text — 14/400.
  TextStyle get muted => AppTypography.sans(
      color: _tokens.mutedForeground, fontSize: 14, height: 1.5);

  /// Sidebar/group overline — 11/600 uppercase-style tracking.
  TextStyle get overline => AppTypography.sans(
      color: _tokens.mutedForeground,
      fontSize: 11,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.6,
      height: 1.4);

  /// Inline/code block text — JetBrains Mono 13.
  TextStyle get code =>
      AppTypography.mono(color: _tokens.codeForeground, height: 1.6);
}

/// Convenience accessor for semantic chrome text styles.
extension AppTextStylesX on BuildContext {
  /// Semantic docs-site text styles bound to the current theme tokens.
  AppTextStyles get text => AppTextStyles(tokens);
}
