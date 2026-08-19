/// Application theme configuration (LingoDesk design language).
///
/// Builds light and dark [ThemeData] from the active [AppPalette]
/// variant: warm tinted neutrals, hairline-bordered flat cards, 12px
/// radii, bold Urbanist type, and primary buttons that pick up a soft
/// brand glow under the pointer.
library;

import 'package:flutter/material.dart';
import 'package:flutterui/app/shared/presentation/theme/app_motion.dart';
import 'package:flutterui/app/shared/presentation/theme/app_palette.dart';
import 'package:flutterui/app/shared/presentation/theme/app_tokens.dart';
import 'package:flutterui/app/shared/presentation/theme/app_typography.dart';

/// Theme configuration class.
///
/// [light] and [dark] are thin wrappers over [_build], parameterized by
/// the palette variant and brightness.
class AppTheme {
  static ThemeData light([AppPalette palette = AppPalettes.teal]) =>
      _build(palette, Brightness.light);

  static ThemeData dark([AppPalette palette = AppPalettes.teal]) =>
      _build(palette, Brightness.dark);

  static ThemeData _build(AppPalette palette, Brightness brightness) {
    final bool isDark = brightness == Brightness.dark;
    final AppTokens t = AppTokens(palette: palette, isDark: isDark);
    final TextTheme textTheme = AppTypography.textTheme(t);

    final ColorScheme colorScheme = ColorScheme(
      brightness: brightness,
      primary: t.brand,
      onPrimary: t.onBrand,
      secondary: t.brandFill,
      onSecondary: t.onBrandFill,
      error: t.destructive,
      onError: Colors.white,
      surface: t.background,
      onSurface: t.foreground,
      surfaceContainerHighest: t.active,
      onSurfaceVariant: t.muted,
      outline: t.border,
      outlineVariant: t.border,
      shadow: Colors.black,
      scrim: Colors.black54,
      inverseSurface: t.foreground,
      onInverseSurface: t.background,
      inversePrimary: t.onBrand,
      surfaceTint: Colors.transparent,
    );

    final OutlineInputBorder inputBorder = OutlineInputBorder(
      borderSide: BorderSide(color: t.border),
      borderRadius: AppRadii.mdAll,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      extensions: [palette],
      colorScheme: colorScheme,
      scaffoldBackgroundColor: t.background,
      canvasColor: t.background,

      // Legacy slots still consumed by existing screens/library content.
      primaryColor: t.brand,
      primaryColorDark: t.foreground,
      primaryColorLight: t.background,
      cardColor: t.card,
      highlightColor: t.active,
      hoverColor: t.active,
      splashColor: Colors.transparent,
      splashFactory: NoSplash.splashFactory,
      dividerColor: t.border,

      textTheme: textTheme,
      iconTheme: IconThemeData(color: t.muted, size: 18),
      primaryIconTheme: IconThemeData(color: t.muted, size: 18),

      appBarTheme: AppBarTheme(
        backgroundColor: isDark ? t.background : t.card,
        foregroundColor: t.foreground,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        surfaceTintColor: Colors.transparent,
        titleTextStyle: textTheme.titleLarge,
        iconTheme: IconThemeData(color: t.foreground, size: 18),
      ),

      dividerTheme: DividerThemeData(
        color: t.border,
        thickness: 1,
        space: 1,
      ),

      // Primary actions pick up a soft brand glow under the pointer and
      // settle flat again when pressed.
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: t.brand,
          foregroundColor: t.onBrand,
          disabledBackgroundColor: t.brand.withValues(alpha: 0.4),
          disabledForegroundColor: t.onBrand.withValues(alpha: 0.7),
          minimumSize: const Size(48, 48),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          shape: RoundedRectangleBorder(borderRadius: AppRadii.mdAll),
          textStyle: textTheme.labelLarge,
          animationDuration: AppMotion.fast,
        ).copyWith(
          elevation: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.disabled) ||
                states.contains(WidgetState.pressed)) {
              return 0.0;
            }
            return states.contains(WidgetState.hovered) ? 4.0 : 0.0;
          }),
          shadowColor: WidgetStatePropertyAll(t.brand.withValues(alpha: 0.5)),
        ),
      ),

      // Secondary actions answer the pointer by taking on the accent
      // border instead of changing weight or size.
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: t.foreground,
          minimumSize: const Size(48, 48),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          shape: RoundedRectangleBorder(borderRadius: AppRadii.mdAll),
          textStyle: textTheme.labelLarge,
          animationDuration: AppMotion.fast,
        ).copyWith(
          side: WidgetStateBorderSide.resolveWith((states) {
            if (states.contains(WidgetState.disabled)) {
              return BorderSide(
                  color: isDark ? Colors.white10 : t.border);
            }
            if (states.contains(WidgetState.hovered) ||
                states.contains(WidgetState.focused) ||
                states.contains(WidgetState.pressed)) {
              return BorderSide(color: t.accent);
            }
            return BorderSide(color: isDark ? Colors.white24 : t.border);
          }),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: t.foreground,
          padding: const EdgeInsets.symmetric(
              horizontal: AppSpace.md, vertical: 10),
          minimumSize: const Size(0, 40),
          shape: RoundedRectangleBorder(borderRadius: AppRadii.mdAll),
          textStyle: textTheme.labelLarge,
          animationDuration: AppMotion.fast,
        ).copyWith(
          overlayColor: WidgetStatePropertyAll(t.active),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.symmetric(
            horizontal: AppSpace.md, vertical: 12),
        hintStyle: textTheme.bodyMedium,
        labelStyle: textTheme.bodyMedium,
        floatingLabelStyle: textTheme.bodySmall?.copyWith(color: t.muted),
        errorStyle: textTheme.bodySmall?.copyWith(color: t.destructive),
        filled: false,
        border: inputBorder,
        enabledBorder: inputBorder,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: t.accent, width: 1.5),
          borderRadius: AppRadii.mdAll,
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: t.destructive),
          borderRadius: AppRadii.mdAll,
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: t.destructive, width: 1.5),
          borderRadius: AppRadii.mdAll,
        ),
      ),

      chipTheme: ChipThemeData(
        backgroundColor: isDark ? t.active : t.card,
        selectedColor: t.brandFill,
        side: BorderSide(color: isDark ? Colors.white24 : t.border),
        padding: const EdgeInsets.symmetric(
            horizontal: AppSpace.sm, vertical: AppSpace.xs),
        labelStyle: AppTypography.sans(
          color: t.foreground,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
        shape: RoundedRectangleBorder(borderRadius: AppRadii.mdAll),
        elevation: 0,
        pressElevation: 0,
      ),

      cardTheme: CardThemeData(
        color: t.card,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: AppRadii.mdAll,
          side: BorderSide(color: t.border),
        ),
      ),

      dialogTheme: DialogThemeData(
        backgroundColor: t.card,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: AppRadii.lgAll,
          side: BorderSide(color: t.border),
        ),
        titleTextStyle: textTheme.titleLarge,
        contentTextStyle: textTheme.bodyMedium,
      ),

      checkboxTheme: CheckboxThemeData(
        // Round, so every checkbox reads as one family with the radios
        // and selection dots instead of a stray square.
        shape: const CircleBorder(),
        side: BorderSide(
            color: isDark ? Colors.white38 : t.border, width: 1.4),
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (!states.contains(WidgetState.selected)) {
            return Colors.transparent;
          }
          return states.contains(WidgetState.disabled)
              ? t.brand.withValues(alpha: 0.4)
              : t.brand;
        }),
        checkColor: WidgetStatePropertyAll(t.onBrand),
      ),

      tooltipTheme: TooltipThemeData(
        waitDuration: const Duration(milliseconds: 400),
        decoration: BoxDecoration(
          color: isDark ? t.active : t.foreground,
          borderRadius: AppRadii.smAll,
          border: Border.all(
            color: isDark ? Colors.white24 : Colors.transparent,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        textStyle: AppTypography.sans(
          color: isDark ? Colors.white : t.background,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),

      popupMenuTheme: PopupMenuThemeData(
        color: t.card,
        surfaceTintColor: Colors.transparent,
        elevation: 4,
        shadowColor: Colors.black.withValues(alpha: 0.12),
        shape: RoundedRectangleBorder(
          borderRadius: AppRadii.mdAll,
          side: BorderSide(color: t.border),
        ),
        textStyle: textTheme.bodyMedium?.copyWith(color: t.foreground),
      ),

      textSelectionTheme: TextSelectionThemeData(
        selectionColor: t.brandFill,
        cursorColor: t.accent,
      ),

      scrollbarTheme: ScrollbarThemeData(
        thumbColor: WidgetStatePropertyAll(
          t.muted.withValues(alpha: 0.35),
        ),
        radius: const Radius.circular(4),
        thickness: const WidgetStatePropertyAll(6),
      ),

      snackBarTheme: SnackBarThemeData(
        backgroundColor: t.foreground,
        contentTextStyle: textTheme.bodyMedium?.copyWith(color: t.background),
        behavior: SnackBarBehavior.floating,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: AppRadii.mdAll),
      ),
    );
  }
}
