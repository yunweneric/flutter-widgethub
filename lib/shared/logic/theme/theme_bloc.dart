import 'package:bloc/bloc.dart';
import 'package:flutterui/shared/data/enums/theme.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeInitial(themeMode: AppThemeMode.SYSTEM)) {
    on<ChangeTheme>((event, emit) {
      emit(UpdateTheme(themeMode: event.themeMode));
    });
  }
}
