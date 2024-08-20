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
  RouteType get defaultRouteType => const RouteType.custom(transitionsBuilder: TransitionsBuilders.fadeIn);

  @override
  List<AutoRoute> get routes => [
        AutoRoute(initial: true, path: RouteNames.home, page: HomeRoute.page),
        AutoRoute(path: RouteNames.support, page: SupportRoute.page),
        AutoRoute(
          path: '/components',
          page: ComponentLayoutRoute.page,
          children: [
            AutoRoute(path: "", page: ComponentCategoryRoute.page),
            AutoRoute(path: RouteNames.notFound, page: NotFoundRoute.page),
            AutoRoute(page: ComponentDetailsRoute.page),
            AutoRoute(page: NotFoundRoute.page),
            AutoRoute(path: "*", page: NotFoundRoute.page),
          ],
        ),
        // AutoRoute(path: "/${RouteNames.notFound}", page: NotFoundRoute.page),
        AutoRoute(path: "*", page: NotFoundRoute.page),
      ];

  @override
  List<AutoRouteGuard> get guards => [];
}
