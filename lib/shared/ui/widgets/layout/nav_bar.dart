import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutterui/core/service_locators.dart';
import 'package:flutterui/shared/data/enums/theme.dart';
import 'package:flutterui/shared/logic/theme/theme_bloc.dart';
import 'package:flutterui/shared/ui/models/nav_link.dart';
import 'package:flutterui/shared/ui/utils/icons.dart';
import 'package:flutterui/shared/ui/utils/sizing.dart';
import 'package:flutterui/shared/ui/widgets/app_container.dart';
import 'package:flutterui/shared/ui/widgets/icon.dart';
import 'package:flutterui/shared/ui/widgets/layout/mobile_nav.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  List<NavLink> links = [
    NavLink(title: "Components", path: "/components"),
    NavLink(title: "Templates", path: "/templates"),
    NavLink(title: "Pricing", path: "/pricing"),
  ];
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return AppSizing.isMobile(context)
            ? MobileNav()
            : AppContainer(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        TextButton(
                          child: Text("Logo", style: Theme.of(context).textTheme.displayLarge),
                          onPressed: () {
                            context.router.pushNamed("/");
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
                            ? TextButton(onPressed: () {}, child: AppIcon(icon: AppIcons.search))
                            : SizedBox(
                                width: 280.w,
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
                        TextButton(
                          style: TextButton.styleFrom(
                            fixedSize: Size(25.w, 25.w),
                          ),
                          child: AppIcon(
                            icon: AppIcons.linkedIn,
                            color: Theme.of(context).primaryColorDark,
                          ),
                          onPressed: () {},
                        ),
                        AppSizing.kwSpacer(5.w),
                        TextButton(
                          onPressed: () {},
                          child: AppIcon(
                            icon: AppIcons.x,
                            color: Theme.of(context).primaryColorDark,
                          ),
                        ),
                        AppSizing.kwSpacer(5.w),
                        TextButton(
                          onPressed: () {},
                          child: AppIcon(icon: AppIcons.github),
                        ),
                        AppSizing.kwSpacer(5.w),
                        Builder(
                          builder: (context) {
                            final theme = getIt.get<ThemeBloc>();
                            final isDark = Theme.of(context).brightness == Brightness.dark;
                            return TextButton(
                              onPressed: () => theme.add(
                                ChangeTheme(themeMode: isDark ? AppThemeMode.LIGHT : AppThemeMode.DARK),
                              ),
                              child: AppIcon(
                                icon: isDark ? AppIcons.moon : AppIcons.sun,
                                color: Theme.of(context).primaryColorDark,
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
