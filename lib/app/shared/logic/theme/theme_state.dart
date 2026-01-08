part of 'theme_bloc.dart';

/// Base class for theme state.
///
/// Contains the current theme mode of the application.
class ThemeState {
  /// The current theme mode.
  final ThemeMode themeMode;

  /// Creates a theme state.
  ThemeState({required this.themeMode});

  /// Properties for equality comparison.
  List get props => [themeMode];
}

/// Initial theme state.
///
/// Represents the initial theme state when the app starts.
class ThemeInitial extends ThemeState {
  /// Creates an initial theme state.
  ThemeInitial({required super.themeMode});
}

/// Updated theme state.
///
/// Represents a theme state after a theme change has been applied.
class UpdateTheme extends ThemeState {
  /// The updated theme mode.
  @override
  final ThemeMode themeMode;

  /// Creates an updated theme state.
  UpdateTheme({required this.themeMode}) : super(themeMode: themeMode);
}
