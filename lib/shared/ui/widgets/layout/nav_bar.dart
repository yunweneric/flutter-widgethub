import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterui/core/service_locators.dart';
import 'package:flutterui/screens/routes/app_router.gr.dart';
import 'package:flutterui/screens/routes/route_names.dart';
import 'package:flutterui/shared/data/enums/theme.dart';
import 'package:flutterui/shared/logic/theme/theme_bloc.dart';
import 'package:flutterui/shared/ui/models/nav_link.dart';
import 'package:flutterui/shared/ui/utils/icons.dart';
import 'package:flutterui/shared/ui/utils/sizing.dart';
import 'package:flutterui/shared/ui/utils/util.dart';
import 'package:flutterui/shared/ui/widgets/app_container.dart';
import 'package:flutterui/shared/ui/widgets/app_search_bar.dart';
import 'package:flutterui/shared/ui/widgets/icon.dart';
import 'package:flutterui/shared/ui/widgets/layout/mobile_nav.dart';

class NavBar extends StatefulWidget {
  final bool isHomeScreenLayout;
  final VoidCallback onTap;

  const NavBar({super.key, required this.onTap, required this.isHomeScreenLayout});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  List<NavLink> links = [
    NavLink(title: "Components", path: ComponentCategoryRoute(category: RouteNames.components)),
    NavLink(title: "Support", path: const SupportRoute()),
  ];
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return AppSizing.isMobile(context)
            ? MobileNav(onTap: widget.onTap)
            : AppContainer(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        TextButton(
                          style: TextButton.styleFrom(padding: EdgeInsets.zero),
                          child: Text("Logo", style: Theme.of(context).textTheme.displayLarge),
                          onPressed: () {
                            context.router.push(const HomeRoute());
                          },
                        ),
                        AppSizing.kwSpacer(50.w),
                        Row(
                          children: [
                            ...links.map((item) {
                              final activeRoute = context.router.currentPath;
                              final isActive = activeRoute == item.path;
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextButton(
                                  onPressed: () {
                                    context.router.push(item.path);
                                  },
                                  child: Text(
                                    item.title,
                                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                          color: isActive ? Theme.of(context).primaryColor : null,
                                        ),
                                  ),
                                ),
                              );
                            })
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const AppSearchBar(),
                        CircleAvatar(
                          backgroundColor: Colors.transparent,
                          child: TextButton(
                            style: TextButton.styleFrom(fixedSize: Size(25.w, 25.w)),
                            child: const AppIcon(icon: AppIcons.linkedIn),
                            onPressed: () => UtilHelper.openUrl("https://www.linkedin.com/in/yunweneric"),
                          ),
                        ),
                        AppSizing.kwSpacer(5.w),
                        CircleAvatar(
                          backgroundColor: Colors.transparent,
                          child: TextButton(
                            onPressed: () => UtilHelper.openUrl("https://twitter.com/yunweneric"),
                            child: const AppIcon(icon: AppIcons.x),
                          ),
                        ),
                        AppSizing.kwSpacer(5.w),
                        CircleAvatar(
                          backgroundColor: Colors.transparent,
                          child: TextButton(
                            onPressed: () => UtilHelper.openUrl("https://github.com/yunweneric/"),
                            child: const AppIcon(icon: AppIcons.github),
                          ),
                        ),
                        AppSizing.kwSpacer(5.w),
                        Builder(
                          builder: (context) {
                            final theme = getIt.get<ThemeBloc>();
                            final isDark = Theme.of(context).brightness == Brightness.dark;
                            return CircleAvatar(
                              backgroundColor: Colors.transparent,
                              child: TextButton(
                                onPressed: () => theme.add(
                                  ChangeTheme(themeMode: isDark ? ThemeMode.light : ThemeMode.dark),
                                ),
                                child: AppIcon(
                                  icon: isDark ? AppIcons.moon : AppIcons.sun,
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    )
                    // navBar
                  ],
                ),
              );
      },
    );
  }
}
