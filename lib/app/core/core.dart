/// Core module barrel file.
///
/// Exports all core application components including:
/// - Main app widget
/// - Bootstrap function
/// - Configuration
/// - Service locators
/// - Scroll behavior
/// - Route configuration
///
/// This file serves as a convenient import point for core functionality.
library;

// Main app components
export 'app.dart';
export 'boostrap.dart';
export 'config.dart';
export 'service_locators.dart';
export 'app_scroll_behavior.dart';

// Main entry points (hide main function to avoid conflicts)
export 'main_dev.dart' hide main;
export 'main_prod.dart' hide main;

// Routes
export 'routes/app_router.dart';
export 'routes/route_names.dart';
