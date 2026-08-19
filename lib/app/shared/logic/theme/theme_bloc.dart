/// Theme management BLoC.
///
/// Manages the application theme mode (light / dark / system) and the
/// active palette variant (LingoDesk-style whole-look themes). Both are
/// persisted across sessions via HydratedBloc.
library;

import 'package:flutter/material.dart';
import 'package:flutterui/app/shared/presentation/theme/app_palette.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'theme_event.dart';
part 'theme_state.dart';

/// BLoC for managing application theme state.
class ThemeBloc extends HydratedBloc<ThemeEvent, ThemeState> {
  /// Creates a theme bloc with system mode and the house variant.
  ThemeBloc()
      : super(ThemeInitial(
          themeMode: ThemeMode.system,
          variant: AppThemeVariant.teal,
        )) {
    on<ChangeTheme>((event, emit) {
      emit(UpdateTheme(themeMode: event.themeMode, variant: state.variant));
    });
    on<ChangeThemeVariant>((event, emit) {
      emit(UpdateTheme(themeMode: state.themeMode, variant: event.variant));
    });
  }

  @override
  ThemeState? fromJson(Map<String, dynamic> json) {
    final ThemeMode mode = switch (json['themeMode']) {
      'light' => ThemeMode.light,
      'dark' => ThemeMode.dark,
      _ => ThemeMode.system,
    };
    return UpdateTheme(
      themeMode: mode,
      variant: AppThemeVariant.fromId(json['variant'] as String?),
    );
  }

  @override
  Map<String, dynamic>? toJson(ThemeState state) => {
        'themeMode': state.themeMode.name,
        'variant': state.variant.id,
      };
}
