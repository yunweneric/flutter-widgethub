/// Application routing configuration using GoRouter.
///
/// This file defines all routes for the application including:
/// - Home and landing pages
/// - Component category screens
/// - Template detail screens
/// - Component detail screens
/// - Request component screen
///
/// Routes are organized using ShellRoute for shared layouts and
/// include custom fade transitions for smooth navigation.
import 'package:flutter/material.dart';
import 'package:flutterui/app/presentation/categories/screens/component_category_screen.dart';
import 'package:flutterui/app/presentation/categories/screens/component_details_wrapper.dart';
import 'package:flutterui/app/presentation/categories/screens/template_category_screen.dart';
import 'package:flutterui/app/presentation/categories/screens/template_details_screen.dart';
import 'package:flutterui/app/presentation/categories/widget/component_layout.dart';
import 'package:flutterui/app/presentation/home/screens/home_screen.dart';
import 'package:flutterui/app/presentation/request_component/request_component_screen.dart';
import 'package:flutterui/app/core/routes/route_names.dart';
import 'package:go_router/go_router.dart';

/// Widget builder for component category layouts.
///
/// Extracts the category ID from route parameters and displays
/// the appropriate component category screen.
class BuildComponentLayout extends StatelessWidget {
  /// The current router state containing path parameters.
  final GoRouterState state;

  /// Creates a component layout builder.
  const BuildComponentLayout({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return ComponentCategoryScreen(subCategory: state.pathParameters['id']);
  }
}

/// Widget builder for template category layouts.
///
/// Extracts the template category ID from route parameters and displays
/// the appropriate template category screen.
class BuildTemplateLayout extends StatelessWidget {
  /// The current router state containing path parameters.
  final GoRouterState state;

  /// Creates a template layout builder.
  const BuildTemplateLayout({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return TemplateCategoryScreen(id: state.pathParameters['id']);
  }
}

/// Widget builder for component detail screens.
///
/// Extracts the subcategory ID from route parameters and displays
/// the component details wrapper.
class BuildComponentDetailsWidget extends StatelessWidget {
  /// The current router state containing path parameters.
  final GoRouterState state;

  /// Creates a component details builder.
  const BuildComponentDetailsWidget({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return ComponentDetailsWrapper(
      id: state.pathParameters['subCategory'] as String,
    );
  }
}

/// Creates a [GoRoute] with a custom fade transition animation.
///
/// [path] The route path pattern.
/// [builder] Function that builds the widget for this route.
/// Returns a configured [GoRoute] with fade transition.
GoRoute buildAnimatedRoute({
  required String path,
  required Function(BuildContext context, GoRouterState state) builder,
}) {
  return GoRoute(
    path: path,
    pageBuilder: (context, state) {
      return CustomTransitionPage(
        key: state.pageKey,
        child: builder(context, state),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: CurveTween(curve: Curves.easeInOutCirc).animate(animation),
            child: child,
          );
        },
      );
    },
  );
}

/// Global application router instance.
///
/// Configured with all application routes including:
/// - Home route
/// - Component category routes (blocks, animations, effects)
/// - Template category routes
/// - Component detail routes
/// - Template detail routes
///
/// Uses a ShellRoute to provide a shared layout for component-related routes
/// and includes custom fade transitions for smooth navigation.
final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    // Regular GoRoute for HomeScreen
    buildAnimatedRoute(
      path: "/",
      builder: (context, state) => const HomeScreen(),
    ),

    buildAnimatedRoute(
      path: RouteNames.requestComponent,
      builder: (context, state) => const RequestComponentScreen(),
    ),

    // ShellRoute for routes with a shared layout
    ShellRoute(
      builder: (context, state, child) => ComponentLayoutScreen(child: child),
      routes: [
        // Nested route 1 under ShellRoute

        buildAnimatedRoute(
          path: RouteNames.components,
          builder: (context, state) => BuildComponentLayout(state: state),
        ),
        buildAnimatedRoute(
          path: RouteNames.introduction,
          builder: (context, state) => BuildComponentLayout(state: state),
        ),
        buildAnimatedRoute(
          path: '${RouteNames.introduction}/:id',
          builder: (context, state) => BuildComponentLayout(state: state),
        ),

        // **     ----------------------------------------------    //
        // **     Template Routes
        // **     ----------------------------------------------    //
        buildAnimatedRoute(
          path: RouteNames.templates,
          builder: (context, state) => BuildComponentLayout(state: state),
        ),
        buildAnimatedRoute(
          path: '${RouteNames.templates}/:id',
          builder: (context, state) => BuildComponentLayout(state: state),
        ),
        buildAnimatedRoute(
          path: '${RouteNames.templates}/:subCategory/:id',
          builder: (context, state) => BuildTemplateLayout(state: state),
        ),

        // Example URL for this route:
        // /templates/{category}/{subCategory}/{id}/{index}
        // For example:
        // /templates/templates/apps/basuu-language-kit/0001920

        buildAnimatedRoute(
          path: '${RouteNames.templates}/:subCategory/:id/:index',
          builder: (context, state) => TemplateDetailsScreen(
            id: state.pathParameters['id'] as String,
            index: int.parse(state.pathParameters['index'] as String),
          ),
        ),

        // **     ----------------------------------------------    //
        // **     Block Routes
        // **     ----------------------------------------------    //
        buildAnimatedRoute(
          path: RouteNames.blocks,
          builder: (context, state) => BuildComponentLayout(state: state),
        ),
        buildAnimatedRoute(
          path: '${RouteNames.blocks}/:id',
          builder: (context, state) => BuildComponentLayout(state: state),
        ),
        buildAnimatedRoute(
          path: '${RouteNames.blocks}/:id/:subCategory',
          builder: (context, state) => BuildComponentDetailsWidget(state: state),
        ),

        // **     ----------------------------------------------    //
        // **     Animation Routes
        // **     ----------------------------------------------    //
        buildAnimatedRoute(
          path: RouteNames.animations,
          builder: (context, state) => BuildComponentLayout(state: state),
        ),
        buildAnimatedRoute(
          path: '${RouteNames.animations}/:id',
          builder: (context, state) => BuildComponentLayout(state: state),
        ),
        buildAnimatedRoute(
          path: '${RouteNames.animations}/:id/:subCategory',
          builder: (context, state) => BuildComponentDetailsWidget(state: state),
        ),

        // **     ----------------------------------------------    //
        // **     Effects Routes
        // **     ----------------------------------------------    //
        buildAnimatedRoute(
          path: RouteNames.effects,
          builder: (context, state) => BuildComponentLayout(state: state),
        ),
        buildAnimatedRoute(
          path: '${RouteNames.effects}/:id',
          builder: (context, state) => BuildComponentLayout(state: state),
        ),
        buildAnimatedRoute(
          path: '${RouteNames.effects}/:id/:subCategory',
          builder: (context, state) => BuildComponentDetailsWidget(state: state),
        ),
      ],
    ),
  ],
);
// }
