/// Application theme configuration (shadcn-style).
///
/// Builds light and dark [ThemeData] from the semantic design tokens in
/// [AppTokens]. A single parameterized builder derives both modes, so the
/// look stays consistent: neutral zinc palette, 1px borders, 6-12px radii,
/// no elevation, ring-colored focus states.
library;

import 'package:flutter/material.dart';
import 'package:flutterui/app/shared/presentation/theme/app_tokens.dart';
import 'package:flutterui/app/shared/presentation/theme/app_typography.dart';

/// Theme configuration class.
///
/// [light] and [dark] are thin wrappers over [_build], parameterized only
/// by the token set and brightness.
class AppTheme {
  static ThemeData light() => _build(AppTokens.light, Brightness.light);

  static ThemeData dark() => _build(AppTokens.dark, Brightness.dark);

  static ThemeData _build(AppTokens tokens, Brightness brightness) {
    final TextTheme textTheme = AppTypography.textTheme(tokens);

    final ColorScheme colorScheme = ColorScheme(
      brightness: brightness,
      primary: tokens.primary,
      onPrimary: tokens.primaryForeground,
      secondary: tokens.secondary,
      onSecondary: tokens.secondaryForeground,
      error: tokens.destructive,
      onError: tokens.destructiveForeground,
      surface: tokens.background,
      onSurface: tokens.foreground,
      surfaceContainerHighest: tokens.muted,
      onSurfaceVariant: tokens.mutedForeground,
      outline: tokens.border,
      outlineVariant: tokens.border,
      shadow: Colors.black,
      scrim: Colors.black54,
      inverseSurface: tokens.foreground,
      onInverseSurface: tokens.background,
      inversePrimary: tokens.primaryForeground,
      surfaceTint: Colors.transparent,
    );

    final OutlineInputBorder inputBorder = OutlineInputBorder(
      borderSide: BorderSide(color: tokens.input),
      borderRadius: AppRadii.mdAll,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      extensions: [tokens],
      colorScheme: colorScheme,
      scaffoldBackgroundColor: tokens.background,
      canvasColor: tokens.background,

      // Legacy slots still consumed by existing screens/library content.
      primaryColor: tokens.primary,
      primaryColorDark: tokens.foreground,
      primaryColorLight: tokens.background,
      cardColor: tokens.card,
      highlightColor: tokens.muted,
      hoverColor: tokens.accent.withValues(alpha: 0.6),
      splashColor: Colors.transparent,
      splashFactory: NoSplash.splashFactory,
      dividerColor: tokens.border,

      textTheme: textTheme,
      iconTheme: IconThemeData(color: tokens.mutedForeground, size: 18),
      primaryIconTheme: IconThemeData(color: tokens.mutedForeground, size: 18),

      appBarTheme: AppBarTheme(
        backgroundColor: tokens.background,
        foregroundColor: tokens.foreground,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: textTheme.titleLarge,
        iconTheme: IconThemeData(color: tokens.foreground, size: 18),
      ),

      dividerTheme: DividerThemeData(
        color: tokens.border,
        thickness: 1,
        space: 1,
      ),

      // shadcn "default" button: solid primary, radius 8, no elevation.
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: tokens.primary,
          foregroundColor: tokens.primaryForeground,
          disabledBackgroundColor: tokens.primary.withValues(alpha: 0.5),
          disabledForegroundColor:
              tokens.primaryForeground.withValues(alpha: 0.7),
          padding:
              const EdgeInsets.symmetric(horizontal: AppSpace.lg, vertical: 12),
          minimumSize: const Size(0, 40),
          shape: RoundedRectangleBorder(borderRadius: AppRadii.mdAll),
          textStyle: textTheme.labelLarge,
        ),
      ),

      // shadcn "outline" button.
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          elevation: 0,
          foregroundColor: tokens.foreground,
          backgroundColor: tokens.background,
          side: BorderSide(color: tokens.input),
          padding:
              const EdgeInsets.symmetric(horizontal: AppSpace.lg, vertical: 12),
          minimumSize: const Size(0, 40),
          shape: RoundedRectangleBorder(borderRadius: AppRadii.mdAll),
          textStyle: textTheme.labelLarge,
        ),
      ),

      // shadcn "ghost" button.
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: tokens.foreground,
          padding: const EdgeInsets.symmetric(
              horizontal: AppSpace.md, vertical: 10),
          minimumSize: const Size(0, 36),
          shape: RoundedRectangleBorder(borderRadius: AppRadii.mdAll),
          textStyle: textTheme.labelLarge,
        ).copyWith(
          overlayColor: WidgetStatePropertyAll(
            tokens.accent.withValues(alpha: 0.8),
          ),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.symmetric(
            horizontal: AppSpace.md, vertical: 10),
        hintStyle: textTheme.bodyMedium,
        labelStyle: textTheme.bodyMedium,
        floatingLabelStyle:
            textTheme.bodySmall?.copyWith(color: tokens.mutedForeground),
        errorStyle: textTheme.bodySmall?.copyWith(color: tokens.destructive),
        filled: false,
        border: inputBorder,
        enabledBorder: inputBorder,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: tokens.ring, width: 1.5),
          borderRadius: AppRadii.mdAll,
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: tokens.destructive),
          borderRadius: AppRadii.mdAll,
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: tokens.destructive, width: 1.5),
          borderRadius: AppRadii.mdAll,
        ),
      ),

      chipTheme: ChipThemeData(
        backgroundColor: tokens.secondary,
        selectedColor: tokens.primary,
        side: BorderSide.none,
        padding: const EdgeInsets.symmetric(
            horizontal: AppSpace.sm, vertical: AppSpace.xs),
        labelStyle: textTheme.labelSmall
            ?.copyWith(color: tokens.secondaryForeground),
        shape: RoundedRectangleBorder(borderRadius: AppRadii.smAll),
        elevation: 0,
        pressElevation: 0,
      ),

      cardTheme: CardThemeData(
        color: tokens.card,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: AppRadii.lgAll,
          side: BorderSide(color: tokens.border),
        ),
      ),

      dialogTheme: DialogThemeData(
        backgroundColor: tokens.popover,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: AppRadii.lgAll,
          side: BorderSide(color: tokens.border),
        ),
        titleTextStyle: textTheme.titleLarge,
        contentTextStyle: textTheme.bodyMedium,
      ),

      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          color: tokens.foreground,
          borderRadius: AppRadii.smAll,
        ),
        textStyle: textTheme.bodySmall?.copyWith(color: tokens.background),
        padding: const EdgeInsets.symmetric(
            horizontal: AppSpace.sm, vertical: AppSpace.xs),
      ),

      popupMenuTheme: PopupMenuThemeData(
        color: tokens.popover,
        surfaceTintColor: Colors.transparent,
        elevation: 4,
        shadowColor: Colors.black.withValues(alpha: 0.1),
        shape: RoundedRectangleBorder(
          borderRadius: AppRadii.mdAll,
          side: BorderSide(color: tokens.border),
        ),
        textStyle: textTheme.bodyMedium?.copyWith(color: tokens.foreground),
      ),

      scrollbarTheme: ScrollbarThemeData(
        thumbColor: WidgetStatePropertyAll(
          tokens.mutedForeground.withValues(alpha: 0.3),
        ),
        radius: const Radius.circular(4),
        thickness: const WidgetStatePropertyAll(6),
      ),

      snackBarTheme: SnackBarThemeData(
        backgroundColor: tokens.foreground,
        contentTextStyle:
            textTheme.bodyMedium?.copyWith(color: tokens.background),
        behavior: SnackBarBehavior.floating,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: AppRadii.mdAll),
      ),
    );
  }
}
