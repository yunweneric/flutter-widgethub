import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutterui/components/data/logic/component/component_bloc.dart';
import 'package:flutterui/screens/routes/app_router.dart';
import 'package:flutterui/shared/logic/language/language_bloc.dart';
import 'package:flutterui/shared/logic/navigation/navigation_bloc.dart';
import 'package:flutterui/shared/logic/sidebar/sidebar_bloc.dart';
import 'package:flutterui/shared/logic/theme/theme_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

final getIt = GetIt.instance;

class ServiceLocators {
  static Future<void> register() async {
    FirebaseAnalytics analytics = FirebaseAnalytics.instance;
    getIt.registerSingleton<FirebaseAnalytics>(analytics);

    // final appRouter = appRouter;
    getIt.registerSingleton<GoRouter>(appRouter);

    final themBloc = ThemeBloc();
    final sidebarBloc = SidebarBloc();
    final languageBloc = LanguageBloc();
    final componentBloc = ComponentBloc();
    final navigationBloc = NavigationBloc();
    getIt
      ..registerSingleton<ThemeBloc>(themBloc)
      ..registerSingleton<ComponentBloc>(componentBloc)
      ..registerSingleton<SidebarBloc>(sidebarBloc)
      ..registerSingleton<NavigationBloc>(navigationBloc)
      ..registerSingleton<LanguageBloc>(languageBloc);

    print('Service Locators registered!');
  }
}
