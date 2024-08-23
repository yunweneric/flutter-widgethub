import 'package:flutter/material.dart';
import 'package:flutterui/screens/categories/ui/component_category_screen.dart';
import 'package:flutterui/screens/categories/ui/component_details_wrapper.dart';
import 'package:flutterui/screens/categories/widget/component_layout.dart';
import 'package:flutterui/screens/home/ui/home_screen.dart';
import 'package:flutterui/screens/request_component/request_component_screen.dart';
import 'package:flutterui/screens/routes/route_names.dart';
import 'package:flutterui/screens/support/ui/support_screen.dart';
import 'package:go_router/go_router.dart';

Widget buildComponentLayout(GoRouterState state) {
  return ComponentCategoryScreen(subCategory: state.pathParameters['id']);
}

Widget buildComponentDetailsWidget(GoRouterState state) {
  return ComponentDetailsWrapper(
    id: state.pathParameters['subCategory'] as String,
  );
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
      builder: (context, state) => HomeScreen(),
    ),
    buildAnimatedRoute(
      path: RouteNames.support,
      builder: (context, state) => SupportScreen(),
    ),
    buildAnimatedRoute(
      path: RouteNames.requestComponent,
      builder: (context, state) => RequestComponentScreen(),
    ),

    // ShellRoute for routes with a shared layout
    ShellRoute(
      builder: (context, state, child) => ComponentLayoutScreen(child: child),
      routes: [
        // Nested route 1 under ShellRoute

        buildAnimatedRoute(
          path: RouteNames.components,
          builder: (context, state) => buildComponentLayout(state),
        ),
        buildAnimatedRoute(
          path: RouteNames.gettingStarted,
          builder: (context, state) => buildComponentLayout(state),
        ),

        // **     ----------------------------------------------    //
        // **     Template Routes
        // **     ----------------------------------------------    //
        buildAnimatedRoute(
          path: RouteNames.templates,
          builder: (context, state) => buildComponentLayout(state),
        ),
        buildAnimatedRoute(
          path: '${RouteNames.templates}/:id',
          builder: (context, state) => buildComponentLayout(state),
        ),
        buildAnimatedRoute(
          path: '${RouteNames.templates}/:id/:subCategory',
          builder: (context, state) => buildComponentDetailsWidget(state),
        ),

        // **     ----------------------------------------------    //
        // **     Block Routes
        // **     ----------------------------------------------    //
        buildAnimatedRoute(
          path: RouteNames.blocks,
          builder: (context, state) => buildComponentLayout(state),
        ),
        buildAnimatedRoute(
          path: '${RouteNames.blocks}/:id',
          builder: (context, state) => buildComponentLayout(state),
        ),
        buildAnimatedRoute(
          path: '${RouteNames.blocks}/:id/:subCategory',
          builder: (context, state) => buildComponentDetailsWidget(state),
        ),

        // **     ----------------------------------------------    //
        // **     Animation Routes
        // **     ----------------------------------------------    //
        buildAnimatedRoute(
          path: RouteNames.animations,
          builder: (context, state) => buildComponentLayout(state),
        ),
        buildAnimatedRoute(
          path: '${RouteNames.animations}/:id',
          builder: (context, state) => buildComponentLayout(state),
        ),
        buildAnimatedRoute(
          path: '${RouteNames.animations}/:id/:subCategory',
          builder: (context, state) => buildComponentDetailsWidget(state),
        ),

        // **     ----------------------------------------------    //
        // **     Effects Routes
        // **     ----------------------------------------------    //
        buildAnimatedRoute(
          path: RouteNames.effects,
          builder: (context, state) => buildComponentLayout(state),
        ),
        buildAnimatedRoute(
          path: '${RouteNames.effects}/:id',
          builder: (context, state) => buildComponentLayout(state),
        ),
        buildAnimatedRoute(
          path: '${RouteNames.effects}/:id/:subCategory',
          builder: (context, state) => buildComponentDetailsWidget(state),
        ),
      ],
    ),
  ],
);
// }
