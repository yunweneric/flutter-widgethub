import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterui/app/core/app.dart';
import 'package:flutterui/app/core/config.dart';
import 'package:flutterui/app/shared/presentation/helpers/observers/bloc_observer.dart';
import 'package:flutterui/app/core/service_locators.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:easy_localization/easy_localization.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
    await EasyLocalization.ensureInitialized();

  usePathUrlStrategy();
  AppConfig.instance.init(env: AppEnv.DEV);
  await ServiceLocators.register();
  Bloc.observer = SimpleBlocObserver();
  runApp(const MyApp());
}
