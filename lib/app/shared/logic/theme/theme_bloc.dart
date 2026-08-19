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
          variant: AppThemeVariant.blue,
        )) {
    on<ChangeTheme>((event, emit) {
      emit(UpdateTheme(themeMode: event.themeMode, variant: state.variant));
    });
    on<ChangeThemeVariant>((event, emit) {
      emit(UpdateTheme(themeMode: state.themeMode, variant: event.variant));
    });
  }

  /// Bumped whenever the house variant changes, so sessions that stored a
  /// pick under the previous default land on the new one instead of being
  /// stuck on a look they never chose.
  static const int _schemaVersion = 2;

  @override
  ThemeState? fromJson(Map<String, dynamic> json) {
    final ThemeMode mode = switch (json['themeMode']) {
      'light' => ThemeMode.light,
      'dark' => ThemeMode.dark,
      _ => ThemeMode.system,
    };
    final bool current = json['v'] == _schemaVersion;
    return UpdateTheme(
      themeMode: mode,
      variant: current
          ? AppThemeVariant.fromId(json['variant'] as String?)
          : AppThemeVariant.blue,
    );
  }

  @override
  Map<String, dynamic>? toJson(ThemeState state) => {
        'v': _schemaVersion,
        'themeMode': state.themeMode.name,
        'variant': state.variant.id,
      };
}
