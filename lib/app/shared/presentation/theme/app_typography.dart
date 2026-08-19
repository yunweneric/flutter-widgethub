/// Typography system (LingoDesk design language).
///
/// Urbanist is the app's only UI family — warm, geometric, set bold for
/// headings and buttons with no letter-spacing tricks. Code blocks keep
/// JetBrains Mono, because WidgetHub shows real source code.
///
/// Two layers:
///  1. [AppTypography.textTheme] — the Material [TextTheme] registered on
///     [ThemeData]. Slot sizes stay compatible with how existing library
///     content consumes them.
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

  /// Base UI style (Urbanist).
  static TextStyle sans({
    required Color color,
    required double fontSize,
    FontWeight fontWeight = FontWeight.w400,
    double? height,
    double? letterSpacing,
  }) {
    return GoogleFonts.urbanist(
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
      height: height,
      letterSpacing: letterSpacing ?? 0,
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
  /// Headings use the foreground token set bold; body and label slots use
  /// the muted foreground, matching how the existing screens and library
  /// content already consume them.
  static TextTheme textTheme(AppTokens tokens) {
    final Color fg = tokens.foreground;
    final Color muted = tokens.muted;

    return TextTheme(
      // Legacy-compatible slots (sizes preserved).
      displayLarge: sans(
          color: fg, fontSize: 32, fontWeight: FontWeight.w700, height: 1.15),
      displayMedium: sans(
          color: fg, fontSize: 17, fontWeight: FontWeight.w700, height: 1.3),
      displaySmall: sans(
          color: fg, fontSize: 13, fontWeight: FontWeight.w700, height: 1.35),
      // Full heading ramp (LingoDesk scale).
      headlineLarge: sans(
          color: fg, fontSize: 40, fontWeight: FontWeight.w700, height: 1.05),
      headlineMedium: sans(
          color: fg, fontSize: 30, fontWeight: FontWeight.w700, height: 1.12),
      headlineSmall: sans(
          color: fg, fontSize: 22, fontWeight: FontWeight.w700, height: 1.2),
      titleLarge: sans(
          color: fg, fontSize: 22, fontWeight: FontWeight.w700, height: 1.2),
      titleMedium: sans(
          color: fg, fontSize: 16, fontWeight: FontWeight.w700, height: 1.35),
      titleSmall: sans(
          color: fg, fontSize: 14, fontWeight: FontWeight.w700, height: 1.35),
      // Body.
      bodyLarge: sans(color: fg, fontSize: 16, height: 1.55),
      bodyMedium: sans(color: muted, fontSize: 14, height: 1.45),
      bodySmall: sans(color: muted, fontSize: 12, height: 1.45),
      // Labels.
      labelLarge: sans(
          color: fg, fontSize: 14, fontWeight: FontWeight.w700, height: 1.2),
      labelMedium: sans(color: muted, fontSize: 14, height: 1.35),
      labelSmall: sans(color: muted, fontSize: 12, height: 1.35),
    );
  }
}

/// Semantic text styles for the app chrome (docs-site typography).
///
/// Resolved from the active theme via `context.text`.
class AppTextStyles {
  final AppTokens _tokens;

  const AppTextStyles(this._tokens);

  /// Hero display headline — 48/700, snug.
  TextStyle get display => AppTypography.sans(
      color: _tokens.foreground,
      fontSize: 48,
      fontWeight: FontWeight.w700,
      height: 1.08);

  /// Page title — 36/700.
  TextStyle get h1 => AppTypography.sans(
      color: _tokens.foreground,
      fontSize: 36,
      fontWeight: FontWeight.w700,
      height: 1.12);

  /// Section title — 30/700.
  TextStyle get h2 => AppTypography.sans(
      color: _tokens.foreground,
      fontSize: 30,
      fontWeight: FontWeight.w700,
      height: 1.15);

  /// Sub-section title — 24/700.
  TextStyle get h3 => AppTypography.sans(
      color: _tokens.foreground,
      fontSize: 24,
      fontWeight: FontWeight.w700,
      height: 1.2);

  /// Minor heading — 20/700.
  TextStyle get h4 => AppTypography.sans(
      color: _tokens.foreground,
      fontSize: 20,
      fontWeight: FontWeight.w700,
      height: 1.25);

  /// Lead paragraph under titles — 18/400 muted.
  TextStyle get lead =>
      AppTypography.sans(color: _tokens.muted, fontSize: 18, height: 1.55);

  /// Default paragraph — 16/400.
  TextStyle get p =>
      AppTypography.sans(color: _tokens.foreground, fontSize: 16, height: 1.55);

  /// Emphasized small text — 14/600.
  TextStyle get small => AppTypography.sans(
      color: _tokens.foreground,
      fontSize: 14,
      fontWeight: FontWeight.w600,
      height: 1.35);

  /// Muted small text — 14/400.
  TextStyle get muted =>
      AppTypography.sans(color: _tokens.muted, fontSize: 14, height: 1.45);

  /// Sidebar/group overline — 11/700 with wide tracking.
  TextStyle get overline => AppTypography.sans(
      color: _tokens.muted,
      fontSize: 11,
      fontWeight: FontWeight.w700,
      letterSpacing: 0.8,
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
