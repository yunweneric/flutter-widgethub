import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterui/app/core/service_locators.dart';
import 'package:flutterui/app/shared/logic/sidebar/sidebar_bloc.dart';
import 'package:flutterui/app/shared/logic/theme/theme_bloc.dart';
import 'package:flutterui/app/shared/presentation/theme/app_tokens.dart';
import 'package:flutterui/app/shared/presentation/utils/icons.dart';
import 'package:flutterui/app/shared/presentation/utils/images.dart';
import 'package:flutterui/app/shared/presentation/widgets/app_icon_button.dart';
import 'package:flutterui/app/shared/presentation/widgets/app_search_bar.dart';
import 'package:flutterui/app/shared/presentation/widgets/icon.dart';
import 'package:go_router/go_router.dart';
import 'package:flutterui/app/core/routes/route_names.dart';

/// Top navigation bar (mobile) — 56px with menu, logo and actions.
class HomeMobileNav extends StatefulWidget {
  final bool isHomeScreenLayout;
  const HomeMobileNav({super.key, required this.isHomeScreenLayout});

  @override
  State<HomeMobileNav> createState() => _HomeMobileNavState();
}

class _HomeMobileNavState extends State<HomeMobileNav> {
  final sidebarBloc = getIt.get<SidebarBloc>();

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return BlocBuilder<SidebarBloc, SidebarState>(
      builder: (context, sidebarState) {
        return Container(
          width: double.infinity,
          height: 56,
          padding: const EdgeInsets.symmetric(horizontal: AppSpace.lg),
          decoration: BoxDecoration(
            color: tokens.background.withValues(alpha: 0.95),
            border: Border(bottom: BorderSide(color: tokens.border)),
          ),
          child: Row(
            children: [
              AppIconButton(
                onPressed: () {
                  sidebarBloc.add(
                    UpdateSideBarEvent(newStatus: !sidebarState.isOpen),
                  );
                },
                child: const AppIcon(icon: AppIcons.menu, size: 20),
              ),
              const SizedBox(width: AppSpace.sm),
              GestureDetector(
                onTap: () => context.go(RouteNames.home),
                child: Image.asset(
                  isDark ? AppImages.logoLight : AppImages.logoDark,
                  width: 84,
                ),
              ),
              const Spacer(),
              AppIconButton(
                onPressed: () => showSearchModal(context),
                child: const AppIcon(icon: AppIcons.search, size: 16),
              ),
              const SizedBox(width: AppSpace.xs),
              Builder(builder: (context) {
                final theme = getIt.get<ThemeBloc>();
                return AppIconButton(
                  onPressed: () => theme.add(
                    ChangeTheme(
                        themeMode:
                            isDark ? ThemeMode.light : ThemeMode.dark),
                  ),
                  child: AppIcon(
                      icon: isDark ? AppIcons.moon : AppIcons.sun, size: 16),
                );
              }),
            ],
          ),
        );
      },
    );
  }
}
