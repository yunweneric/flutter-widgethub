import 'dart:ui';
import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'language_event.dart';
part 'language_state.dart';

class LanguageBloc extends HydratedBloc<LanguageEvent, LanguageState> {
  LanguageBloc() : super(const LanguageInitial(currentLocale: Locale('en', "US"))) {
    on<UpdateAppLanguageEvent>((event, emit) {
      event.context.setLocale(event.newLocale);
      emit(UpdateLanguage(currentLocale: event.newLocale));
    });
  }

  @override
  LanguageState? fromJson(Map<String, dynamic> json) {
    return UpdateLanguage(
      currentLocale: Locale(json['countryCode'], json['languageCode']),
    );
  }

  @override
  Map<String, dynamic>? toJson(LanguageState state) {
    return {
      "countryCode": state.currentLocale.countryCode,
      "languageCode": state.currentLocale.languageCode,
    };
  }
}
