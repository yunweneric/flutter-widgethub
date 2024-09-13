//// import 'package:flutter/material.dart';
// import 'package:fwh/core/service_locators.dart';
// import 'package:fwh/shared/logic/navigation/navigation_bloc.dart';

// class MyObserver extends AutoRouterObserver {
//   final navigationBloc = getIt.get<NavigationBloc>();
//   // final autoRoute = getIt.get<AppRouter>();
//   @override
//   void didPush(Route route, Route? previousRoute) {
//     // navigationBloc.add(NavigationEventUpdated(route: route.data?.path ?? "/"));
//     // print('New route pushed: ${route.settings.name}');
//     // print('New route pushed: ${route.data?.path}');
//   }

//   // only override to observer tab routes
//   @override
//   void didInitTabRoute(TabPageRoute route, TabPageRoute? previousRoute) {
//     print('Tab route visited: ${route.name}');
//   }

//   @override
//   void didChangeTabRoute(TabPageRoute route, TabPageRoute previousRoute) {
//     print('Tab route re-visited: ${route.name}');
//   }
// }
