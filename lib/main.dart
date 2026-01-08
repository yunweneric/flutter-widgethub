/// Main entry point for the Flutter WidgetHub application.
///
/// This file initializes the application in production mode by calling
/// the bootstrap function with the production environment configuration.
library;

import 'package:flutterui/app/core/app.dart';
import 'package:flutterui/app/core/boostrap.dart';
import 'package:flutterui/app/core/config.dart';

/// Application entry point.
///
/// Initializes the app with production environment settings and starts
/// the [MyApp] widget.
void main() {
  bootstrap(() => const MyApp(), env: AppEnv.PROD);
}
