// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i5;
import 'package:flutter/material.dart' as _i7;
import 'package:flutterui/screens/categories/routes/category_router.dart'
    as _i6;
import 'package:flutterui/screens/categories/screens/component_category.dart'
    as _i1;
import 'package:flutterui/screens/categories/screens/component_details.dart'
    as _i2;
import 'package:flutterui/screens/categories/widget/component_layout.dart'
    as _i3;
import 'package:flutterui/screens/home/home_screen.dart' as _i4;

abstract class $AppRouter extends _i5.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i5.PageFactory> pagesMap = {
    ComponentCategoryRoute.name: (routeData) {
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.ComponentCategoryScreen(),
      );
    },
    ComponentDetailsRoute.name: (routeData) {
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.ComponentDetailsScreen(),
      );
    },
    ComponentLayoutRoute.name: (routeData) {
      final args = routeData.argsAs<ComponentLayoutRouteArgs>(
          orElse: () => const ComponentLayoutRouteArgs());
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i3.ComponentLayoutScreen(
          key: args.key,
          widgets: args.widgets,
        ),
      );
    },
    HomeRoute.name: (routeData) {
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.HomeScreen(),
      );
    },
    ..._i6.DashboardRouter().pagesMap,
  };
}

/// generated route for
/// [_i1.ComponentCategoryScreen]
class ComponentCategoryRoute extends _i5.PageRouteInfo<void> {
  const ComponentCategoryRoute({List<_i5.PageRouteInfo>? children})
      : super(
          ComponentCategoryRoute.name,
          initialChildren: children,
        );

  static const String name = 'ComponentCategoryRoute';

  static const _i5.PageInfo<void> page = _i5.PageInfo<void>(name);
}

/// generated route for
/// [_i2.ComponentDetailsScreen]
class ComponentDetailsRoute extends _i5.PageRouteInfo<void> {
  const ComponentDetailsRoute({List<_i5.PageRouteInfo>? children})
      : super(
          ComponentDetailsRoute.name,
          initialChildren: children,
        );

  static const String name = 'ComponentDetailsRoute';

  static const _i5.PageInfo<void> page = _i5.PageInfo<void>(name);
}

/// generated route for
/// [_i3.ComponentLayoutScreen]
class ComponentLayoutRoute extends _i5.PageRouteInfo<ComponentLayoutRouteArgs> {
  ComponentLayoutRoute({
    _i7.Key? key,
    List<_i7.Widget>? widgets,
    List<_i5.PageRouteInfo>? children,
  }) : super(
          ComponentLayoutRoute.name,
          args: ComponentLayoutRouteArgs(
            key: key,
            widgets: widgets,
          ),
          initialChildren: children,
        );

  static const String name = 'ComponentLayoutRoute';

  static const _i5.PageInfo<ComponentLayoutRouteArgs> page =
      _i5.PageInfo<ComponentLayoutRouteArgs>(name);
}

class ComponentLayoutRouteArgs {
  const ComponentLayoutRouteArgs({
    this.key,
    this.widgets,
  });

  final _i7.Key? key;

  final List<_i7.Widget>? widgets;

  @override
  String toString() {
    return 'ComponentLayoutRouteArgs{key: $key, widgets: $widgets}';
  }
}

/// generated route for
/// [_i4.HomeScreen]
class HomeRoute extends _i5.PageRouteInfo<void> {
  const HomeRoute({List<_i5.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i5.PageInfo<void> page = _i5.PageInfo<void>(name);
}
