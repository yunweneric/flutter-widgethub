import 'package:auto_route/auto_route.dart';
import 'package:flutterui/screens/routes/app_router.gr.dart';

@AutoRouterConfig(
  replaceInRouteName: 'Screen,Route',
  // generateForDir: ["lib/screens/home"],
  // modules: [DashboardRouter],
)
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(path: '/', page: HomeRoute.page),
        // ...DashboardRouter().routes,

        AutoRoute(
          path: '/components',
          page: ComponentLayoutRoute.page,
          children: [
            AutoRoute(path: '', page: ComponentCategoryRoute.page),
            AutoRoute(path: 'buttons', page: ComponentDetailsRoute.page),
          ],
        ),
      ];

  @override
  List<AutoRouteGuard> get guards => [];
}
