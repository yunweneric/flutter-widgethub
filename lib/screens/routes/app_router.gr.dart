// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i8;
import 'package:flutter/material.dart' as _i9;
import 'package:flutterui/components/ui/export/data.dart' as _i10;
import 'package:flutterui/components/ui/templates/index.dart' as _i5;
import 'package:flutterui/screens/categories/ui/component_category.dart' as _i2;
import 'package:flutterui/screens/categories/ui/component_details.dart' as _i3;
import 'package:flutterui/screens/categories/widget/component_layout.dart'
    as _i4;
import 'package:flutterui/screens/coming_soon/ui/coming_soon_screen.dart'
    as _i1;
import 'package:flutterui/screens/errors/ui/not_found.dart' as _i7;
import 'package:flutterui/screens/home/ui/home_screen.dart' as _i6;

/// generated route for
/// [_i1.ComingSoonScreen]
class ComingSoonRoute extends _i8.PageRouteInfo<void> {
  const ComingSoonRoute({List<_i8.PageRouteInfo>? children})
      : super(
          ComingSoonRoute.name,
          initialChildren: children,
        );

  static const String name = 'ComingSoonRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i1.ComingSoonScreen();
    },
  );
}

/// generated route for
/// [_i2.ComponentCategoryScreen]
class ComponentCategoryRoute
    extends _i8.PageRouteInfo<ComponentCategoryRouteArgs> {
  ComponentCategoryRoute({
    _i9.Key? key,
    required String category,
    List<_i8.PageRouteInfo>? children,
  }) : super(
          ComponentCategoryRoute.name,
          args: ComponentCategoryRouteArgs(
            key: key,
            category: category,
          ),
          initialChildren: children,
        );

  static const String name = 'ComponentCategoryRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ComponentCategoryRouteArgs>();
      return _i2.ComponentCategoryScreen(
        key: args.key,
        category: args.category,
      );
    },
  );
}

class ComponentCategoryRouteArgs {
  const ComponentCategoryRouteArgs({
    this.key,
    required this.category,
  });

  final _i9.Key? key;

  final String category;

  @override
  String toString() {
    return 'ComponentCategoryRouteArgs{key: $key, category: $category}';
  }
}

/// generated route for
/// [_i3.ComponentDetailsScreen]
class ComponentDetailsRoute
    extends _i8.PageRouteInfo<ComponentDetailsRouteArgs> {
  ComponentDetailsRoute({
    _i9.Key? key,
    required _i10.Component component,
    List<_i8.PageRouteInfo>? children,
  }) : super(
          ComponentDetailsRoute.name,
          args: ComponentDetailsRouteArgs(
            key: key,
            component: component,
          ),
          initialChildren: children,
        );

  static const String name = 'ComponentDetailsRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ComponentDetailsRouteArgs>();
      return _i3.ComponentDetailsScreen(
        key: args.key,
        component: args.component,
      );
    },
  );
}

class ComponentDetailsRouteArgs {
  const ComponentDetailsRouteArgs({
    this.key,
    required this.component,
  });

  final _i9.Key? key;

  final _i10.Component component;

  @override
  String toString() {
    return 'ComponentDetailsRouteArgs{key: $key, component: $component}';
  }
}

/// generated route for
/// [_i4.ComponentLayoutScreen]
class ComponentLayoutRoute extends _i8.PageRouteInfo<ComponentLayoutRouteArgs> {
  ComponentLayoutRoute({
    _i9.Key? key,
    List<_i9.Widget>? widgets,
    List<_i8.PageRouteInfo>? children,
  }) : super(
          ComponentLayoutRoute.name,
          args: ComponentLayoutRouteArgs(
            key: key,
            widgets: widgets,
          ),
          initialChildren: children,
        );

  static const String name = 'ComponentLayoutRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ComponentLayoutRouteArgs>(
          orElse: () => const ComponentLayoutRouteArgs());
      return _i4.ComponentLayoutScreen(
        key: args.key,
        widgets: args.widgets,
      );
    },
  );
}

class ComponentLayoutRouteArgs {
  const ComponentLayoutRouteArgs({
    this.key,
    this.widgets,
  });

  final _i9.Key? key;

  final List<_i9.Widget>? widgets;

  @override
  String toString() {
    return 'ComponentLayoutRouteArgs{key: $key, widgets: $widgets}';
  }
}

/// generated route for
/// [_i5.ComponentTemplatesScreen]
class ComponentTemplatesRoute extends _i8.PageRouteInfo<void> {
  const ComponentTemplatesRoute({List<_i8.PageRouteInfo>? children})
      : super(
          ComponentTemplatesRoute.name,
          initialChildren: children,
        );

  static const String name = 'ComponentTemplatesRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i5.ComponentTemplatesScreen();
    },
  );
}

/// generated route for
/// [_i6.HomeScreen]
class HomeRoute extends _i8.PageRouteInfo<void> {
  const HomeRoute({List<_i8.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i6.HomeScreen();
    },
  );
}

/// generated route for
/// [_i7.NotFoundScreen]
class NotFoundRoute extends _i8.PageRouteInfo<void> {
  const NotFoundRoute({List<_i8.PageRouteInfo>? children})
      : super(
          NotFoundRoute.name,
          initialChildren: children,
        );

  static const String name = 'NotFoundRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i7.NotFoundScreen();
    },
  );
}
