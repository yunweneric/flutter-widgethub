import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterui/app/core/core.dart';
import 'package:flutterui/app/shared/shared.dart';
import 'package:go_router/go_router.dart';

class HomeNavBar extends StatefulWidget {
  final bool isHomeScreenLayout;

  const HomeNavBar({super.key, required this.isHomeScreenLayout});

  @override
  State<HomeNavBar> createState() => _HomeNavBarState();
}

class _HomeNavBarState extends State<HomeNavBar> {
  List<NavLink> links = [
    NavLink(title: LangUtil.trans(("components")), path: RouteNames.components),
  ];

  bool isLogoHovered = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return AppSizing.isMobile(context)
            ? HomeMobileNav(
                isHomeScreenLayout: widget.isHomeScreenLayout,
              )
            : AppContainer(
                isHomeScreenLayout: widget.isHomeScreenLayout,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        TextButton(
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                            overlayColor: Theme.of(context).scaffoldBackgroundColor,
                          ),
                          child: AnimatedScale(
                            duration: const Duration(milliseconds: 100),
                            scale: isLogoHovered ? 1.1 : 1.0,
                            child: AnimatedSwitcher(
                              duration: const Duration(milliseconds: 100),
                              child: Theme.of(context).brightness == Brightness.light
                                  ? Image.asset(AppImages.logoDark, width: 100)
                                  : Image.asset(
                                      AppImages.logoLight,
                                      width: 100,
                                    ),
                            ),
                          ),
                          onPressed: () => context.go(RouteNames.home),
                          onHover: (value) => setState(() {
                            isLogoHovered = value;
                          }),
                        ),
                        AppSizing.kwSpacer(50.w),
                        Row(
                          children: [
                            ...links.map((item) {
                              final activeRoute =
                                  getIt.get<GoRouter>().routeInformationProvider.value.uri.path;
                              final isActive = activeRoute == item.path;
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextButton(
                                  onPressed: () => context.go(item.path),
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
                        AppSizing.kwSpacer(10.w),
                        const LanguageButton(),
                        TextButton(
                          onPressed: () => UtilHelper.openUrl(
                              "https://github.com/yunweneric/flutter-widgethub/"),
                          child: const AppIcon(icon: AppIcons.github),
                        ),
                        AppSizing.kwSpacer(5.w),
                        Builder(
                          builder: (context) {
                            final theme = getIt.get<ThemeBloc>();
                            final isDark = Theme.of(context).brightness == Brightness.dark;
                            return TextButton(
                              onPressed: () => theme.add(
                                ChangeTheme(themeMode: isDark ? ThemeMode.light : ThemeMode.dark),
                              ),
                              child: AppIcon(
                                icon: isDark ? AppIcons.moon : AppIcons.sun,
                              ),
                            );
                          },
                        ),
                      ],
                    )
                  ],
                ),
              );
      },
    );
  }
}
