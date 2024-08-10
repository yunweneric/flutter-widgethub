import 'package:flutterui/components/data/logic/component/component_bloc.dart';
import 'package:flutterui/screens/routes/app_router.dart';
import 'package:flutterui/shared/logic/language/language_bloc.dart';
import 'package:flutterui/shared/logic/navigation/navigation_bloc.dart';
import 'package:flutterui/shared/logic/theme/theme_bloc.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

class ServiceLocators {
  static Future<void> register() async {
    final appRouter = AppRouter();
    getIt.registerSingleton<AppRouter>(appRouter);

    final themBloc = ThemeBloc();
    final languageBloc = LanguageBloc();
    final componentBloc = ComponentBloc();
    final navigationBloc = NavigationBloc();
    getIt
      ..registerSingleton<ThemeBloc>(themBloc)
      ..registerSingleton<ComponentBloc>(componentBloc)
      ..registerSingleton<NavigationBloc>(navigationBloc)
      ..registerSingleton<LanguageBloc>(languageBloc);

    print('Service Locators registered!');
  }
}
