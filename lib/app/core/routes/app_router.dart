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

class BuildComponentLayout extends StatelessWidget {
  final GoRouterState state;

  const BuildComponentLayout({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return ComponentCategoryScreen(subCategory: state.pathParameters['id']);
  }
}

class BuildTemplateLayout extends StatelessWidget {
  final GoRouterState state;

  const BuildTemplateLayout({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return TemplateCategoryScreen(id: state.pathParameters['id']);
  }
}

class BuildComponentDetailsWidget extends StatelessWidget {
  final GoRouterState state;

  const BuildComponentDetailsWidget({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return ComponentDetailsWrapper(
      id: state.pathParameters['subCategory'] as String,
    );
  }
}

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

// class AppRouter {
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
