import 'package:fwh/components/data/logic/component/component_bloc.dart';
import 'package:fwh/app/core/routes/app_router.dart';
import 'package:fwh/app/shared/logic/language/language_bloc.dart';
import 'package:fwh/app/shared/logic/navigation/navigation_bloc.dart';
import 'package:fwh/app/shared/logic/sidebar/sidebar_bloc.dart';
import 'package:fwh/app/shared/logic/theme/theme_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

final getIt = GetIt.instance;

class ServiceLocators {
  static Future<void> register() async {
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
