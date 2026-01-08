/// Production environment entry point.
///
/// This file initializes the application in production mode with
/// production-optimized configurations and performance settings.
library;

import 'package:flutterui/app/core/app.dart';
import 'package:flutterui/app/core/boostrap.dart';
import 'package:flutterui/app/core/config.dart';

/// Production entry point.
///
/// Initializes the app with production environment settings.
/// Use this entry point for production builds and releases.
void main() {
  bootstrap(() => const MyApp(), env: AppEnv.PROD);
}
