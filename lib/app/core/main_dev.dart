import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fwh/app/core/app.dart';
import 'package:fwh/app/core/config.dart';
import 'package:fwh/app/shared/presentation/helpers/observers/bloc_observer.dart';
import 'package:fwh/app/core/service_locators.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();
  AppConfig.instance.init(env: AppEnv.DEV);
  await ServiceLocators.register();
  Bloc.observer = SimpleBlocObserver();
  runApp(const MyApp());
}
