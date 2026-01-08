part of 'theme_bloc.dart';

/// Base class for theme-related events.
sealed class ThemeEvent {}

/// Event to change the application theme mode.
///
/// [themeMode] The new theme mode to apply (light, dark, or system).
class ChangeTheme extends ThemeEvent {
  /// The theme mode to change to.
  final ThemeMode themeMode;

  /// Creates a change theme event.
  ChangeTheme({required this.themeMode});
}
