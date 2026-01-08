/// Language and localization management BLoC.
///
/// Manages application language state and handles language changes.
/// Uses HydratedBloc to persist language preference across app restarts.
import 'dart:ui';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'language_event.dart';
part 'language_state.dart';

/// BLoC for managing application language and localization state.
///
/// Handles language changes and persists the selected language using
/// HydratedBloc. Initializes with English (US) as the default locale.
class LanguageBloc extends HydratedBloc<LanguageEvent, LanguageState> {
  /// Creates a language bloc with English (US) as initial locale.
  LanguageBloc() : super(const LanguageState.initial()) {
    on<UpdateAppLanguageEvent>((event, emit) {
      emit(LanguageState.updated(event.newLocale));
    });
  }

  @override
  LanguageState? fromJson(Map<String, dynamic> json) {
    try {
      return LanguageState.updated(
        Locale(
          json['languageCode'] as String? ?? 'en',
          json['countryCode'] as String? ?? 'US',
        ),
      );
    } catch (e) {
      return const LanguageState.initial();
    }
  }

  @override
  Map<String, dynamic>? toJson(LanguageState state) {
    return {
      "languageCode": state.currentLocale.languageCode,
      "countryCode": state.currentLocale.countryCode,
    };
  }
}
