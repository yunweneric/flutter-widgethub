/// Design tokens for the application (shadcn-style).
///
/// Defines the complete set of semantic color tokens, radius and spacing
/// scales used across the app. Colors follow the shadcn/ui zinc palette:
/// a neutral near-black/white system where hierarchy is expressed through
/// subtle surface shifts and 1px borders rather than saturated color.
library;

import 'package:flutter/material.dart';

/// Raw zinc gray scale (Tailwind/shadcn zinc).
///
/// Prefer the semantic slots on [AppTokens]; reach for the raw scale only
/// when a semantic token genuinely does not exist for the use case.
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

/// Border radius scale.
class AppRadii {
  AppRadii._();

  static const double sm = 6;
  static const double md = 8;
  static const double lg = 12;
  static const double xl = 16;

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

/// Semantic color tokens, mirroring the shadcn/ui CSS variables.
///
/// Registered on [ThemeData.extensions] and resolved with
/// `Theme.of(context).extension<AppTokens>()` or the [AppTokensX.tokens]
/// shortcut.
class AppTokens extends ThemeExtension<AppTokens> {
  final Color background;
  final Color foreground;
  final Color card;
  final Color cardForeground;
  final Color popover;
  final Color popoverForeground;
  final Color primary;
  final Color primaryForeground;
  final Color secondary;
  final Color secondaryForeground;
  final Color muted;
  final Color mutedForeground;
  final Color accent;
  final Color accentForeground;
  final Color destructive;
  final Color destructiveForeground;
  final Color border;
  final Color input;
  final Color ring;

  /// Background for code blocks — dark in both themes, like shadcn docs.
  final Color codeBackground;

  /// Foreground for code blocks.
  final Color codeForeground;

  const AppTokens({
    required this.background,
    required this.foreground,
    required this.card,
    required this.cardForeground,
    required this.popover,
    required this.popoverForeground,
    required this.primary,
    required this.primaryForeground,
    required this.secondary,
    required this.secondaryForeground,
    required this.muted,
    required this.mutedForeground,
    required this.accent,
    required this.accentForeground,
    required this.destructive,
    required this.destructiveForeground,
    required this.border,
    required this.input,
    required this.ring,
    required this.codeBackground,
    required this.codeForeground,
  });

  /// Light theme tokens (shadcn zinc).
  static const AppTokens light = AppTokens(
    background: Colors.white,
    foreground: ZincColors.zinc950,
    card: Colors.white,
    cardForeground: ZincColors.zinc950,
    popover: Colors.white,
    popoverForeground: ZincColors.zinc950,
    primary: ZincColors.zinc900,
    primaryForeground: ZincColors.zinc50,
    secondary: ZincColors.zinc100,
    secondaryForeground: ZincColors.zinc900,
    muted: ZincColors.zinc100,
    mutedForeground: ZincColors.zinc500,
    accent: ZincColors.zinc100,
    accentForeground: ZincColors.zinc900,
    destructive: Color(0xFFEF4444),
    destructiveForeground: ZincColors.zinc50,
    border: ZincColors.zinc200,
    input: ZincColors.zinc200,
    ring: ZincColors.zinc900,
    codeBackground: ZincColors.zinc900,
    codeForeground: ZincColors.zinc200,
  );

  /// Dark theme tokens (shadcn zinc).
  static const AppTokens dark = AppTokens(
    background: ZincColors.zinc950,
    foreground: ZincColors.zinc50,
    card: ZincColors.zinc900,
    cardForeground: ZincColors.zinc50,
    popover: ZincColors.zinc900,
    popoverForeground: ZincColors.zinc50,
    primary: ZincColors.zinc50,
    primaryForeground: ZincColors.zinc900,
    secondary: ZincColors.zinc800,
    secondaryForeground: ZincColors.zinc50,
    muted: ZincColors.zinc800,
    mutedForeground: ZincColors.zinc400,
    accent: ZincColors.zinc800,
    accentForeground: ZincColors.zinc50,
    destructive: Color(0xFF7F1D1D),
    destructiveForeground: ZincColors.zinc50,
    border: ZincColors.zinc800,
    input: ZincColors.zinc800,
    ring: ZincColors.zinc300,
    codeBackground: ZincColors.zinc900,
    codeForeground: ZincColors.zinc200,
  );

  @override
  AppTokens copyWith({
    Color? background,
    Color? foreground,
    Color? card,
    Color? cardForeground,
    Color? popover,
    Color? popoverForeground,
    Color? primary,
    Color? primaryForeground,
    Color? secondary,
    Color? secondaryForeground,
    Color? muted,
    Color? mutedForeground,
    Color? accent,
    Color? accentForeground,
    Color? destructive,
    Color? destructiveForeground,
    Color? border,
    Color? input,
    Color? ring,
    Color? codeBackground,
    Color? codeForeground,
  }) {
    return AppTokens(
      background: background ?? this.background,
      foreground: foreground ?? this.foreground,
      card: card ?? this.card,
      cardForeground: cardForeground ?? this.cardForeground,
      popover: popover ?? this.popover,
      popoverForeground: popoverForeground ?? this.popoverForeground,
      primary: primary ?? this.primary,
      primaryForeground: primaryForeground ?? this.primaryForeground,
      secondary: secondary ?? this.secondary,
      secondaryForeground: secondaryForeground ?? this.secondaryForeground,
      muted: muted ?? this.muted,
      mutedForeground: mutedForeground ?? this.mutedForeground,
      accent: accent ?? this.accent,
      accentForeground: accentForeground ?? this.accentForeground,
      destructive: destructive ?? this.destructive,
      destructiveForeground:
          destructiveForeground ?? this.destructiveForeground,
      border: border ?? this.border,
      input: input ?? this.input,
      ring: ring ?? this.ring,
      codeBackground: codeBackground ?? this.codeBackground,
      codeForeground: codeForeground ?? this.codeForeground,
    );
  }

  @override
  AppTokens lerp(ThemeExtension<AppTokens>? other, double t) {
    if (other is! AppTokens) return this;
    return AppTokens(
      background: Color.lerp(background, other.background, t)!,
      foreground: Color.lerp(foreground, other.foreground, t)!,
      card: Color.lerp(card, other.card, t)!,
      cardForeground: Color.lerp(cardForeground, other.cardForeground, t)!,
      popover: Color.lerp(popover, other.popover, t)!,
      popoverForeground:
          Color.lerp(popoverForeground, other.popoverForeground, t)!,
      primary: Color.lerp(primary, other.primary, t)!,
      primaryForeground:
          Color.lerp(primaryForeground, other.primaryForeground, t)!,
      secondary: Color.lerp(secondary, other.secondary, t)!,
      secondaryForeground:
          Color.lerp(secondaryForeground, other.secondaryForeground, t)!,
      muted: Color.lerp(muted, other.muted, t)!,
      mutedForeground: Color.lerp(mutedForeground, other.mutedForeground, t)!,
      accent: Color.lerp(accent, other.accent, t)!,
      accentForeground:
          Color.lerp(accentForeground, other.accentForeground, t)!,
      destructive: Color.lerp(destructive, other.destructive, t)!,
      destructiveForeground:
          Color.lerp(destructiveForeground, other.destructiveForeground, t)!,
      border: Color.lerp(border, other.border, t)!,
      input: Color.lerp(input, other.input, t)!,
      ring: Color.lerp(ring, other.ring, t)!,
      codeBackground: Color.lerp(codeBackground, other.codeBackground, t)!,
      codeForeground: Color.lerp(codeForeground, other.codeForeground, t)!,
    );
  }
}

/// Convenience accessors for design tokens.
extension AppTokensX on BuildContext {
  /// Resolves the current [AppTokens] from the active theme.
  AppTokens get tokens =>
      Theme.of(this).extension<AppTokens>() ??
      (Theme.of(this).brightness == Brightness.dark
          ? AppTokens.dark
          : AppTokens.light);
}
