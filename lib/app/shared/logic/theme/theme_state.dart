part of 'theme_bloc.dart';

/// Base class for theme state.
///
/// Carries the current theme mode and the active palette variant.
class ThemeState {
  /// The current theme mode.
  final ThemeMode themeMode;

  /// The active palette variant.
  final AppThemeVariant variant;

  /// Creates a theme state.
  ThemeState({required this.themeMode, required this.variant});

  /// The resolved palette for the active variant.
  AppPalette get palette => variant.palette;

  /// Properties for equality comparison.
  List get props => [themeMode, variant];
}

/// Initial theme state.
class ThemeInitial extends ThemeState {
  /// Creates an initial theme state.
  ThemeInitial({required super.themeMode, required super.variant});
}

/// Updated theme state.
class UpdateTheme extends ThemeState {
  /// Creates an updated theme state.
  UpdateTheme({required super.themeMode, required super.variant});
}
