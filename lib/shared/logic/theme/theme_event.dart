part of 'theme_bloc.dart';

sealed class ThemeEvent {}

class ChangeTheme extends ThemeEvent {
  final ThemeMode themeMode;

  ChangeTheme({required this.themeMode});
}
