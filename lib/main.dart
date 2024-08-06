import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterui/core/app.dart';
import 'package:flutterui/core/observers/bloc_observer.dart';
import 'package:flutterui/core/service_locators.dart';

void main() async {
  await ServiceLocators.register();
  Bloc.observer = SimpleBlocObserver();
  runApp(const MyApp());
}
