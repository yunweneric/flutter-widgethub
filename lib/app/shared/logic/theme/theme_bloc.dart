/// Theme management BLoC.
///
/// Manages application theme state and handles theme changes between
/// light, dark, and system modes.
library;

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'theme_event.dart';
part 'theme_state.dart';

/// BLoC for managing application theme state.
///
/// Handles theme mode changes and maintains the current theme state.
/// Initializes with system theme mode by default.
class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  /// Creates a theme bloc with system theme as initial state.
  ThemeBloc() : super(ThemeInitial(themeMode: ThemeMode.system)) {
    on<ChangeTheme>((event, emit) {
      emit(UpdateTheme(themeMode: event.themeMode));
    });
  }
}
