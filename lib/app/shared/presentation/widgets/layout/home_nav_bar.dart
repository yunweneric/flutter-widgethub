import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterui/app/core/core.dart';
import 'package:flutterui/app/shared/presentation/utils/icons.dart';
import 'package:flutterui/app/shared/presentation/widgets/app_icon_button.dart';
import 'package:flutterui/app/shared/presentation/widgets/app_search_bar.dart';
import 'package:flutterui/app/shared/presentation/widgets/icon.dart';
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
                        IconButton(
                          onPressed: () => context.go(RouteNames.home),
                          onHover: (value) => setState(() {
                            isLogoHovered = value;
                          }),
                          icon: AnimatedScale(
                            duration: const Duration(milliseconds: 200),
                            scale: isLogoHovered ? 1.1 : 1.0,
                            child: AnimatedSwitcher(
                              duration: const Duration(milliseconds: 100),
                              child: Theme.of(context).brightness ==
                                      Brightness.light
                                  ? Image.asset(AppImages.logoDark, width: 100)
                                  : Image.asset(
                                      AppImages.logoLight,
                                      width: 100,
                                    ),
                            ),
                          ),
                        ),
                        KwSpacer(width: 50.w),
                        Row(
                          children: [
                            ...links.map((item) {
                              final activeRoute = getIt
                                  .get<GoRouter>()
                                  .routeInformationProvider
                                  .value
                                  .uri
                                  .path;
                              final isActive = activeRoute == item.path;
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextButton(
                                  onPressed: () => context.go(item.path),
                                  child: Text(
                                    item.title,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          color: isActive
                                              ? Theme.of(context).primaryColor
                                              : null,
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
                        const LanguageButton(),
                        AppIconButton(
                          onPressed: () => showSearchModal(context),
                          child: const AppIcon(icon: AppIcons.search),
                        ),
                        KwSpacer(width: 8.w),
                        const DeviceFrameSelectorButton(),
                        KwSpacer(width: 8.w),
                        const GitHubIconWithStars(
                          owner: 'yunweneric',
                          repo: 'flutter-widgethub',
                          url:
                              'https://github.com/yunweneric/flutter-widgethub/',
                        ),
                        KwSpacer(width: 8.w),
                        Builder(
                          builder: (context) {
                            final theme = getIt.get<ThemeBloc>();
                            final isDark =
                                Theme.of(context).brightness == Brightness.dark;
                            return AppIconButton(
                              onPressed: () => theme.add(
                                ChangeTheme(
                                    themeMode: isDark
                                        ? ThemeMode.light
                                        : ThemeMode.dark),
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
