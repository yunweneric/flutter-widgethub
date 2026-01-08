/// Service locator configuration and dependency injection setup.
///
/// This file manages the application's dependency injection using GetIt.
/// It registers all singleton services including BLoCs and the router.
library;

import 'package:flutterui/app/shared/logic/language_bloc/language_bloc.dart';
import 'package:flutterui/components/data/logic/component/component_bloc.dart';
import 'package:flutterui/app/core/routes/app_router.dart';
import 'package:flutterui/app/shared/logic/navigation/navigation_bloc.dart';
import 'package:flutterui/app/shared/logic/sidebar/sidebar_bloc.dart';
import 'package:flutterui/app/shared/logic/theme/theme_bloc.dart';
import 'package:flutterui/app/shared/logic/device_frame/device_frame_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

/// Global GetIt instance for dependency injection.
final getIt = GetIt.instance;

/// Service locator registration class.
///
/// Handles the registration of all application-wide singleton services
/// including BLoCs and the router configuration.
class ServiceLocators {
  /// Registers all application services as singletons.
  ///
  /// This method must be called during app initialization (typically in bootstrap).
  /// Registers:
  /// - [GoRouter] for navigation
  /// - [ThemeBloc] for theme management
  /// - [ComponentBloc] for component state
  /// - [SidebarBloc] for sidebar state
  /// - [NavigationBloc] for navigation state
  /// - [LanguageBloc] for language/localization state
  static Future<void> register() async {
    // final appRouter = appRouter;
    getIt.registerSingleton<GoRouter>(appRouter);

    final themBloc = ThemeBloc();
    final sidebarBloc = SidebarBloc();
    final languageBloc = LanguageBloc();
    final componentBloc = ComponentBloc();
    final navigationBloc = NavigationBloc();
    final deviceFrameBloc = DeviceFrameBloc();
    getIt
      ..registerSingleton<ThemeBloc>(themBloc)
      ..registerSingleton<ComponentBloc>(componentBloc)
      ..registerSingleton<SidebarBloc>(sidebarBloc)
      ..registerSingleton<NavigationBloc>(navigationBloc)
      ..registerSingleton<LanguageBloc>(languageBloc)
      ..registerSingleton<DeviceFrameBloc>(deviceFrameBloc);

    print('Service Locators registered!');
  }
}
