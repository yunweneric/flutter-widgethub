import 'package:flutter/material.dart';
import 'package:flutterui/core/app.dart';
import 'package:flutterui/core/service_locators.dart';

void main() async {
  ServiceLocators.register();
  runApp(const MyApp());
}
