import 'package:auto_route/auto_route.dart';
import 'package:flutterui/screens/routes/app_router.gr.dart';
import 'package:flutterui/screens/routes/route_names.dart';

@AutoRouterConfig(
  replaceInRouteName: 'Screen,Route',
  // generateForDir: ["lib/screens/home"],
  // modules: [DashboardRouter],
)
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => const RouteType.custom(
        transitionsBuilder: TransitionsBuilders.fadeIn,
      );

  @override
  List<AutoRoute> get routes => [
        AutoRoute(initial: true, page: HomeRoute.page),
        AutoRoute(
          path: '/components',
          page: ComponentLayoutRoute.page,
          children: [
            AutoRoute(path: "index", initial: true, page: ComponentCategoryRoute.page),
            AutoRoute(path: RouteNames.buttons, page: ComponentDetailsRoute.page),
            AutoRoute(path: RouteNames.notFound, page: NotFoundRoute.page),
            AutoRoute(page: NotFoundRoute.page),
          ],
        ),
        // AutoRoute(path: "/${RouteNames.notFound}", page: NotFoundRoute.page),
        // AutoRoute(path: "*", page: NotFoundRoute.page),
      ];

  @override
  List<AutoRouteGuard> get guards => [];
}
