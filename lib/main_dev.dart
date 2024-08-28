import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterui/core/app.dart';
import 'package:flutterui/core/config.dart';
import 'package:flutterui/core/observers/bloc_observer.dart';
import 'package:flutterui/core/service_locators.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();
  AppConfig.instance.init(env: AppEnv.DEV);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await ServiceLocators.register();
  await getIt.get<FirebaseAnalytics>().logAppOpen();
  Bloc.observer = SimpleBlocObserver();
  runApp(const MyApp());
}
