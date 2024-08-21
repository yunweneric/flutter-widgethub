//// import 'package:flutterui/screens/routes/app_router.gr.dart';
// import 'package:flutterui/screens/routes/route_names.dart';

// @AutoRouterConfig(
//   replaceInRouteName: 'Screen,Route',
//   // generateForDir: ["lib/screens/home"],
//   // modules: [DashboardRouter],
// )
// class AppRouter extends RootStackRouter {
//   @override
//   RouteType get defaultRouteType => const RouteType.custom(transitionsBuilder: TransitionsBuilders.fadeIn);

//   @override
//   List<AutoRoute> get routes => [
//         AutoRoute(initial: true, path: RouteNames.home, page: HomeRoute.page),
//         AutoRoute(path: RouteNames.support, page: SupportRoute.page),
//         AutoRoute(
//           path: '/components',
//           page: ComponentLayoutRoute.page,
//           children: [
//             AutoRoute(path: "", page: ComponentCategoryRoute.page),
//             AutoRoute(page: TemplatesCategoryRoute.page, path: RouteNames.templates),
//             AutoRoute(path: RouteNames.notFound, page: NotFoundRoute.page),
//             AutoRoute(page: NotFoundRoute.page),
//             AutoRoute(path: "*", page: NotFoundRoute.page),
//           ],
//         ),
//         // AutoRoute(path: "/${RouteNames.notFound}", page: NotFoundRoute.page),
//         // AutoRoute(path: "*", page: NotFoundRoute.page),
//       ];

//   @override
//   List<AutoRouteGuard> get guards => [];
// }

import 'package:flutterui/screens/categories/ui/component_category.dart';
import 'package:flutterui/screens/categories/ui/component_details_wrapper.dart';
import 'package:flutterui/screens/categories/widget/component_layout.dart';
import 'package:flutterui/screens/home/ui/home_screen.dart';
import 'package:flutterui/screens/routes/route_names.dart';
import 'package:flutterui/screens/support/ui/support_screen.dart';
import 'package:go_router/go_router.dart';

// class AppRouter {
final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    // Regular GoRoute for HomeScreen
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: RouteNames.support,
      builder: (context, state) => const SupportScreen(),
    ),
    // ShellRoute for routes with a shared layout
    ShellRoute(
      builder: (context, state, child) => ComponentLayoutScreen(child: child),
      routes: [
        // Nested route 1 under ShellRoute
        GoRoute(
          path: RouteNames.components,
          builder: (context, state) => ComponentCategoryScreen(category: "category"),
        ),
        GoRoute(
          path: RouteNames.gettingStarted,
          builder: (context, state) => ComponentCategoryScreen(category: "category"),
        ),
        GoRoute(
          path: RouteNames.templates,
          builder: (context, state) => ComponentCategoryScreen(category: "category"),
        ),
        GoRoute(
          path: '${RouteNames.templates}/:id',
          builder: (context, state) => ComponentCategoryScreen(category: "category"),
        ),
        GoRoute(
          path: '${RouteNames.templates}/:id/:componentId',
          builder: (context, state) => ComponentDetailsWrapper(),
        ),
        GoRoute(
          path: RouteNames.blocks,
          builder: (context, state) => ComponentCategoryScreen(category: "category"),
        ),
        GoRoute(
          path: '${RouteNames.blocks}/:id',
          builder: (context, state) => ComponentDetailsWrapper(),
        ),
        GoRoute(
          path: RouteNames.animations,
          builder: (context, state) => ComponentCategoryScreen(category: "category"),
        ),
        GoRoute(
          path: '${RouteNames.animations}/:id',
          builder: (context, state) => ComponentDetailsWrapper(),
        ),
        GoRoute(
          path: RouteNames.effects,
          builder: (context, state) => ComponentCategoryScreen(category: "category"),
        ),
        GoRoute(
          path: '${RouteNames.effects}/:id',
          builder: (context, state) => ComponentDetailsWrapper(),
        ),
      ],
    ),
  ],
);
// }
