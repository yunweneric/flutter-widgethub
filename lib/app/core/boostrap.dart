/// Application bootstrap and initialization logic.
///
/// This file contains the bootstrap function that initializes all core
/// services and dependencies before the app starts, including:
/// - Widget binding initialization
/// - HydratedBloc storage setup
/// - Localization setup
/// - Service locator registration
/// - Error handling configuration
import 'dart:async';
import 'dart:developer';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterui/app/core/config.dart';
import 'package:flutterui/app/core/service_locators.dart';
import 'package:flutterui/app/shared/presentation/helpers/observers/bloc_observer.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

/// Initializes the application with all required services and dependencies.
///
/// This function must be called before running the app. It sets up:
/// - Widget bindings
/// - Persistent storage for BLoC state (HydratedBloc)
/// - Device orientation preferences
/// - Localization system
/// - URL strategy for web
/// - Global error handling
/// - BLoC observer for debugging
/// - Service locator registration
/// - ScreenUtil initialization
///
/// [builder] Function that returns the root widget of the application.
/// [env] The application environment (DEV, PROD, or STAGING).
Future<void> bootstrap(FutureOr<Widget> Function() builder, {required AppEnv env}) async {
  // Needs to be called so that we can await for EasyLocalization.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorageDirectory.web
        : HydratedStorageDirectory((await getTemporaryDirectory()).path),
  );
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  //await dotenv.load();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  await EasyLocalization.ensureInitialized();
  usePathUrlStrategy();

  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  Bloc.observer = SimpleBlocObserver();

  // Initialize the app storage
  // AppConfig.instance.init(env: env);

  // Initialize the service locator
  await ServiceLocators.register();
  await ScreenUtil.ensureScreenSize();

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en', "US"),
        Locale('fr', 'FR'),
      ],
      path: 'assets/translations',
      fallbackLocale: const Locale('en', "US"),
      // assetLoader: const RemoteLocalesLoader(),
      child: await builder(),
    ),
  );
}
