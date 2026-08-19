import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterui/app/core/core.dart';
import 'package:flutterui/app/shared/presentation/theme/app_tokens.dart';
import 'package:flutterui/app/shared/presentation/theme/app_typography.dart';
import 'package:flutterui/app/shared/presentation/utils/icons.dart';
import 'package:flutterui/app/shared/presentation/widgets/app_icon_button.dart';
import 'package:flutterui/app/shared/presentation/widgets/app_search_bar.dart';
import 'package:flutterui/app/shared/presentation/widgets/device_frame_selector_button.dart';
import 'package:flutterui/app/shared/presentation/widgets/github_icon_with_stars.dart';
import 'package:flutterui/app/shared/presentation/widgets/icon.dart';
import 'package:flutterui/app/shared/presentation/widgets/language_button.dart';
import 'package:flutterui/app/shared/shared.dart';
import 'package:go_router/go_router.dart';

/// Top navigation bar (desktop) — 64px, hairline border, shadcn docs style.
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

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return AppSizing.isMobile(context)
            ? HomeMobileNav(isHomeScreenLayout: widget.isHomeScreenLayout)
            : AppContainer(
                isHomeScreenLayout: widget.isHomeScreenLayout,
                child: Row(
                  children: [
                    _Logo(onTap: () => context.go(RouteNames.home)),
                    const SizedBox(width: AppSpace.xl),
                    ...links.map((item) => _NavLinkItem(item: item)),
                    const Spacer(),
                    const AppSearchBar(),
                    const SizedBox(width: AppSpace.sm),
                    const LanguageButton(),
                    const SizedBox(width: AppSpace.xs),
                    const DeviceFrameSelectorButton(),
                    const SizedBox(width: AppSpace.xs),
                    const GitHubIconWithStars(
                      owner: 'yunweneric',
                      repo: 'flutter-widgethub',
                      url: 'https://github.com/yunweneric/flutter-widgethub/',
                    ),
                    const SizedBox(width: AppSpace.xs),
                    const _ThemeToggleButton(),
                  ],
                ),
              );
      },
    );
  }
}

class _Logo extends StatefulWidget {
  final VoidCallback onTap;

  const _Logo({required this.onTap});

  @override
  State<_Logo> createState() => _LogoState();
}

class _LogoState extends State<_Logo> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 150),
          opacity: _hovered ? 0.8 : 1.0,
          child: Image.asset(
            isDark ? AppImages.logoLight : AppImages.logoDark,
            width: 96,
          ),
        ),
      ),
    );
  }
}

class _NavLinkItem extends StatefulWidget {
  final NavLink item;

  const _NavLinkItem({required this.item});

  @override
  State<_NavLinkItem> createState() => _NavLinkItemState();
}

class _NavLinkItemState extends State<_NavLinkItem> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final activeRoute =
        getIt.get<GoRouter>().routeInformationProvider.value.uri.path;
    final bool isActive = activeRoute.startsWith(widget.item.path);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: () => context.go(widget.item.path),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpace.md),
          child: Text(
            widget.item.title,
            style: AppTypography.sans(
              color: isActive || _hovered
                  ? tokens.foreground
                  : tokens.mutedForeground,
              fontSize: 14,
              fontWeight: FontWeight.w500,
              height: 1.0,
            ),
          ),
        ),
      ),
    );
  }
}

class _ThemeToggleButton extends StatelessWidget {
  const _ThemeToggleButton();

  @override
  Widget build(BuildContext context) {
    final theme = getIt.get<ThemeBloc>();
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return AppIconButton(
      onPressed: () => theme.add(
        ChangeTheme(themeMode: isDark ? ThemeMode.light : ThemeMode.dark),
      ),
      child: AppIcon(icon: isDark ? AppIcons.moon : AppIcons.sun, size: 16),
    );
  }
}
