import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeInitial(themeMode: ThemeMode.system)) {
    on<ChangeTheme>((event, emit) {
      emit(UpdateTheme(themeMode: event.themeMode));
    });
  }
}
