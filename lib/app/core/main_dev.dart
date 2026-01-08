/// Development environment entry point.
///
/// This file initializes the application in development mode with
/// development-specific configurations and debugging features enabled.
import 'package:flutterui/app/core/app.dart';
import 'package:flutterui/app/core/boostrap.dart';
import 'package:flutterui/app/core/config.dart';

/// Development entry point.
///
/// Initializes the app with development environment settings.
/// Use this entry point when running the app in development mode.
void main() {
  bootstrap(() => const MyApp(), env: AppEnv.DEV);
}
