import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterui/core/service_locators.dart';
import 'package:flutterui/screens/routes/app_router.gr.dart';
import 'package:flutterui/shared/data/enums/theme.dart';
import 'package:flutterui/shared/logic/theme/theme_bloc.dart';
import 'package:flutterui/shared/ui/models/nav_link.dart';
import 'package:flutterui/shared/ui/utils/icons.dart';
import 'package:flutterui/shared/ui/utils/sizing.dart';
import 'package:flutterui/shared/ui/utils/util.dart';
import 'package:flutterui/shared/ui/widgets/app_container.dart';
import 'package:flutterui/shared/ui/widgets/icon.dart';
import 'package:flutterui/shared/ui/widgets/layout/mobile_nav.dart';

class NavBar extends StatefulWidget {
  final bool isHomeScreenLayout;
  const NavBar({super.key, required this.isHomeScreenLayout});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  List<NavLink> links = [
    NavLink(title: "Components", path: "/components"),
    NavLink(title: "Support", path: "/pricing"),
  ];
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return AppSizing.isMobile(context)
            ? const MobileNav()
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
                            // getIt.get<AppRouter>().pushNamed(RouteNames.home);
                            // context.router.pushNamed(RouteNames.home);
                            context.router.push(const HomeRoute());
                          },
                        ),
                        AppSizing.kwSpacer(50.w),
                        Container(
                          child: Row(
                            children: [
                              ...links.map((item) {
                                final activeRoute = context.router.currentPath;
                                final isActive = activeRoute == item.path;
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextButton(
                                    onPressed: () {
                                      context.router.pushNamed(item.path);
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
                        )
                      ],
                    ),
                    Row(
                      children: [
                        AppSizing.isTablet(context)
                            ? TextButton(onPressed: () {}, child: const AppIcon(icon: AppIcons.search))
                            : SizedBox(
                                width: 220.w,
                                child: Transform.scale(
                                  scale: 0.8,
                                  child: TextField(
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(horizontal: 10.w),
                                      hintText: "Search component...",
                                      prefixIcon: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: AppIcon(icon: AppIcons.search, color: Theme.of(context).highlightColor),
                                      ),
                                      // suffixIcon: AppIcon(icon:AppIcons.search1, size: 20.w, color: Theme.of(context).highlightColor),
                                    ),
                                  ),
                                ),
                              ),
                        CircleAvatar(
                          backgroundColor: Colors.transparent,
                          child: TextButton(
                            style: TextButton.styleFrom(
                              fixedSize: Size(25.w, 25.w),
                            ),
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
                                  ChangeTheme(themeMode: isDark ? AppThemeMode.LIGHT : AppThemeMode.DARK),
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
