/// Variant-based theme palettes (LingoDesk design language).
///
/// A variant is a *whole* look, not just an accent swap: each one carries
/// its own neutrals so the chassis is tinted toward the accent hue instead
/// of leaving mismatched neutrals under a cool accent.
library;

import 'package:flutter/material.dart';

/// The six palettes the user can pick from in the theme picker.
enum AppThemeVariant {
  teal(
    id: 'teal',
    label: 'Teal Desk',
    description: 'The house look — saturated teal on warm stone.',
  ),
  indigo(
    id: 'indigo',
    label: 'Indigo Slate',
    description: 'Cool indigo over blue-grey neutrals.',
  ),
  violet(
    id: 'violet',
    label: 'Violet Dusk',
    description: 'Electric violet on a faintly purple chassis.',
  ),
  amber(
    id: 'amber',
    label: 'Amber Ember',
    description: 'Warm amber and toasted-sand neutrals.',
  ),
  rose(
    id: 'rose',
    label: 'Rose Quartz',
    description: 'Deep rose with soft blush surfaces.',
  ),
  graphite(
    id: 'graphite',
    label: 'Graphite Mono',
    description: 'No hue at all — contrast does the accenting.',
  );

  const AppThemeVariant({
    required this.id,
    required this.label,
    required this.description,
  });

  /// Stable string written to preferences. Never rename.
  final String id;
  final String label;
  final String description;

  AppPalette get palette => AppPalettes.of(this);

  static AppThemeVariant fromId(String? id) {
    for (final variant in AppThemeVariant.values) {
      if (variant.id == id) {
        return variant;
      }
    }
    return AppThemeVariant.teal;
  }
}

/// One variant resolved to a single brightness.
///
/// These are the only colour roles the chrome is allowed to reach for.
@immutable
class AppScheme {
  const AppScheme({
    required this.brand,
    required this.onBrand,
    required this.accent,
    required this.brandFill,
    required this.brandFillBorder,
    required this.onBrandFill,
    required this.background,
    required this.sidebar,
    required this.card,
    required this.border,
    required this.foreground,
    required this.muted,
    required this.active,
  });

  /// Solid accent for filled buttons and mark tiles. Always safe to put
  /// [onBrand] on top of it.
  final Color brand;
  final Color onBrand;

  /// Accent for text, icons, focus rings and hairlines — lifted away from
  /// [brand] on dark, where the light-mode accent goes muddy.
  final Color accent;

  /// Tinted fill for selected chips, rows and badges, with its hairline
  /// and the text colour that stays legible on it.
  final Color brandFill;
  final Color brandFillBorder;
  final Color onBrandFill;

  /// Stage.
  final Color background;
  final Color sidebar;
  final Color card;
  final Color border;
  final Color foreground;
  final Color muted;

  /// Hover / selected row wash.
  final Color active;

  static AppScheme lerp(AppScheme a, AppScheme b, double t) {
    Color mix(Color x, Color y) => Color.lerp(x, y, t)!;
    return AppScheme(
      brand: mix(a.brand, b.brand),
      onBrand: mix(a.onBrand, b.onBrand),
      accent: mix(a.accent, b.accent),
      brandFill: mix(a.brandFill, b.brandFill),
      brandFillBorder: mix(a.brandFillBorder, b.brandFillBorder),
      onBrandFill: mix(a.onBrandFill, b.onBrandFill),
      background: mix(a.background, b.background),
      sidebar: mix(a.sidebar, b.sidebar),
      card: mix(a.card, b.card),
      border: mix(a.border, b.border),
      foreground: mix(a.foreground, b.foreground),
      muted: mix(a.muted, b.muted),
      active: mix(a.active, b.active),
    );
  }
}

/// A variant's light and dark schemes, carried on [ThemeData] as an
/// extension so any widget can resolve the active palette from context.
@immutable
class AppPalette extends ThemeExtension<AppPalette> {
  const AppPalette({
    required this.variant,
    required this.light,
    required this.dark,
  });

  final AppThemeVariant variant;
  final AppScheme light;
  final AppScheme dark;

  AppScheme scheme(bool isDark) => isDark ? dark : light;

  @override
  AppPalette copyWith({
    AppThemeVariant? variant,
    AppScheme? light,
    AppScheme? dark,
  }) =>
      AppPalette(
        variant: variant ?? this.variant,
        light: light ?? this.light,
        dark: dark ?? this.dark,
      );

  @override
  AppPalette lerp(ThemeExtension<AppPalette>? other, double t) {
    if (other is! AppPalette) {
      return this;
    }
    return AppPalette(
      // Identity can't be blended — snap it at the halfway point.
      variant: t < 0.5 ? variant : other.variant,
      light: AppScheme.lerp(light, other.light, t),
      dark: AppScheme.lerp(dark, other.dark, t),
    );
  }
}

/// The palette table. Dark values are hand-picked rather than derived:
/// every variant needs its own deep stage, or the neutrals all collapse
/// to the same near-black.
class AppPalettes {
  const AppPalettes._();

  /// Dark-stage hairlines and secondary text are the same translucent
  /// whites everywhere, so they pick up whatever surface sits behind them.
  static const _darkBorder = Color(0x1FFFFFFF); // white12
  static const _darkMuted = Color(0xB3FFFFFF); // white70

  static AppPalette of(AppThemeVariant variant) => switch (variant) {
        AppThemeVariant.teal => teal,
        AppThemeVariant.indigo => indigo,
        AppThemeVariant.violet => violet,
        AppThemeVariant.amber => amber,
        AppThemeVariant.rose => rose,
        AppThemeVariant.graphite => graphite,
      };

  static const teal = AppPalette(
    variant: AppThemeVariant.teal,
    light: AppScheme(
      brand: Color(0xFF0F766E),
      onBrand: Colors.white,
      accent: Color(0xFF0F766E),
      brandFill: Color(0xFFE7F3F0),
      brandFillBorder: Color(0xFFCFE6E0),
      onBrandFill: Color(0xFF0F766E),
      background: Color(0xFFFAFAF9),
      sidebar: Colors.white,
      card: Colors.white,
      border: Color(0xFFE7E5E4),
      foreground: Color(0xFF1C1917),
      muted: Color(0xFF78716C),
      active: Color(0xFFF0EFEC),
    ),
    dark: AppScheme(
      brand: Color(0xFF0F766E),
      onBrand: Colors.white,
      accent: Color(0xFF2FA396),
      brandFill: Color(0xFF14433D),
      brandFillBorder: Color(0xFF2A7F73),
      onBrandFill: Color(0xFFCFE6E0),
      background: Color(0xFF0E1B18),
      sidebar: Color(0xFF0C1714),
      card: Color(0xFF16241F),
      border: _darkBorder,
      foreground: Colors.white,
      muted: _darkMuted,
      active: Color(0xFF1C2B26),
    ),
  );

  static const indigo = AppPalette(
    variant: AppThemeVariant.indigo,
    light: AppScheme(
      brand: Color(0xFF4338CA),
      onBrand: Colors.white,
      accent: Color(0xFF4338CA),
      brandFill: Color(0xFFECECFB),
      brandFillBorder: Color(0xFFD5D5F4),
      onBrandFill: Color(0xFF3730A3),
      background: Color(0xFFF8F9FB),
      sidebar: Colors.white,
      card: Colors.white,
      border: Color(0xFFE4E6EC),
      foreground: Color(0xFF16181F),
      muted: Color(0xFF6B7280),
      active: Color(0xFFEDEFF5),
    ),
    dark: AppScheme(
      brand: Color(0xFF4F46E5),
      onBrand: Colors.white,
      accent: Color(0xFF8B95F8),
      brandFill: Color(0xFF23214D),
      brandFillBorder: Color(0xFF4F46E5),
      onBrandFill: Color(0xFFC7CBFB),
      background: Color(0xFF10121B),
      sidebar: Color(0xFF0C0E16),
      card: Color(0xFF191C28),
      border: _darkBorder,
      foreground: Colors.white,
      muted: _darkMuted,
      active: Color(0xFF232739),
    ),
  );

  static const violet = AppPalette(
    variant: AppThemeVariant.violet,
    light: AppScheme(
      brand: Color(0xFF7C3AED),
      onBrand: Colors.white,
      accent: Color(0xFF6D28D9),
      brandFill: Color(0xFFF3EBFE),
      brandFillBorder: Color(0xFFE1D2FA),
      onBrandFill: Color(0xFF6D28D9),
      background: Color(0xFFFBF9FD),
      sidebar: Colors.white,
      card: Colors.white,
      border: Color(0xFFEAE4F0),
      foreground: Color(0xFF1B1523),
      muted: Color(0xFF786A85),
      active: Color(0xFFF2ECF7),
    ),
    dark: AppScheme(
      brand: Color(0xFF7C3AED),
      onBrand: Colors.white,
      accent: Color(0xFFB394FB),
      brandFill: Color(0xFF2C1B4A),
      brandFillBorder: Color(0xFF6D28D9),
      onBrandFill: Color(0xFFDDCCFD),
      background: Color(0xFF140F1C),
      sidebar: Color(0xFF100B17),
      card: Color(0xFF1F1829),
      border: _darkBorder,
      foreground: Colors.white,
      muted: _darkMuted,
      active: Color(0xFF2A203B),
    ),
  );

  static const amber = AppPalette(
    variant: AppThemeVariant.amber,
    light: AppScheme(
      brand: Color(0xFFB45309),
      onBrand: Colors.white,
      accent: Color(0xFFB45309),
      brandFill: Color(0xFFFDF3E2),
      brandFillBorder: Color(0xFFF2DEB6),
      onBrandFill: Color(0xFF92400E),
      background: Color(0xFFFCFAF6),
      sidebar: Colors.white,
      card: Colors.white,
      border: Color(0xFFEDE6DA),
      foreground: Color(0xFF1F1A13),
      muted: Color(0xFF7C7264),
      active: Color(0xFFF5F0E5),
    ),
    dark: AppScheme(
      brand: Color(0xFFD97706),
      onBrand: Colors.white,
      accent: Color(0xFFF5B33C),
      brandFill: Color(0xFF3A2810),
      brandFillBorder: Color(0xFF9A6A16),
      onBrandFill: Color(0xFFFCE7BE),
      background: Color(0xFF17120B),
      sidebar: Color(0xFF120E08),
      card: Color(0xFF221B12),
      border: _darkBorder,
      foreground: Colors.white,
      muted: _darkMuted,
      active: Color(0xFF2E2417),
    ),
  );

  static const rose = AppPalette(
    variant: AppThemeVariant.rose,
    light: AppScheme(
      brand: Color(0xFFBE185D),
      onBrand: Colors.white,
      accent: Color(0xFFBE185D),
      brandFill: Color(0xFFFCE9F1),
      brandFillBorder: Color(0xFFF6CFE0),
      onBrandFill: Color(0xFF9D174D),
      background: Color(0xFFFDF9FA),
      sidebar: Colors.white,
      card: Colors.white,
      border: Color(0xFFEEE2E7),
      foreground: Color(0xFF1F1418),
      muted: Color(0xFF7E6B72),
      active: Color(0xFFF6EDF0),
    ),
    dark: AppScheme(
      brand: Color(0xFFDB2777),
      onBrand: Colors.white,
      accent: Color(0xFFF581B0),
      brandFill: Color(0xFF3C1327),
      brandFillBorder: Color(0xFFA8386B),
      onBrandFill: Color(0xFFFBD3E4),
      background: Color(0xFF171013),
      sidebar: Color(0xFF120B0E),
      card: Color(0xFF23181D),
      border: _darkBorder,
      foreground: Colors.white,
      muted: _darkMuted,
      active: Color(0xFF2F2027),
    ),
  );

  static const graphite = AppPalette(
    variant: AppThemeVariant.graphite,
    light: AppScheme(
      brand: Color(0xFF27272A),
      onBrand: Colors.white,
      accent: Color(0xFF27272A),
      brandFill: Color(0xFFF0F0F1),
      brandFillBorder: Color(0xFFD8D8DD),
      onBrandFill: Color(0xFF27272A),
      background: Color(0xFFFAFAFA),
      sidebar: Colors.white,
      card: Colors.white,
      border: Color(0xFFE4E4E7),
      foreground: Color(0xFF18181B),
      muted: Color(0xFF71717A),
      active: Color(0xFFF0F0F1),
    ),
    // The one variant that inverts: with no hue to lift, the accent has
    // to become near-white on dark, and its text flips to near-black.
    dark: AppScheme(
      brand: Color(0xFFE4E4E7),
      onBrand: Color(0xFF18181B),
      accent: Color(0xFFE4E4E7),
      brandFill: Color(0xFF2B2B31),
      brandFillBorder: Color(0xFF52525B),
      onBrandFill: Color(0xFFFAFAFA),
      background: Color(0xFF0F0F11),
      sidebar: Color(0xFF0A0A0C),
      card: Color(0xFF1A1A1D),
      border: _darkBorder,
      foreground: Colors.white,
      muted: _darkMuted,
      active: Color(0xFF26262A),
    ),
  );
}
