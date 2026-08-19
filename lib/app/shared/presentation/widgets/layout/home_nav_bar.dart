import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterui/app/core/core.dart';
import 'package:flutterui/app/shared/shared.dart';
import 'package:go_router/go_router.dart';

/// Top navigation, in whichever shape the current page calls for.
///
/// Mobile gets the compact bar; the docs shell gets [DocsNavBar], which
/// shares the sidebar/content grid; the landing page keeps the floating
/// pill — logo and links on the left, actions on the right.
class HomeNavBar extends StatefulWidget {
  final bool isHomeScreenLayout;

  const HomeNavBar({super.key, required this.isHomeScreenLayout});

  @override
  State<HomeNavBar> createState() => _HomeNavBarState();
}

class _HomeNavBarState extends State<HomeNavBar> {
  List<NavLink> links = [
    NavLink(title: LangUtil.trans("components"), path: RouteNames.components),
    NavLink(title: LangUtil.trans("templates"), path: RouteNames.templates),
    NavLink(title: LangUtil.trans("effects"), path: RouteNames.effects),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        if (AppSizing.isMobile(context)) {
          return HomeMobileNav(isHomeScreenLayout: widget.isHomeScreenLayout);
        }

        // The docs shell has a sidebar to align to; the landing page does
        // not, and keeps the floating pill.
        if (!widget.isHomeScreenLayout) return const DocsNavBar();

        // One row, no overlay: links sit beside the logo and the actions
        // are pushed right by a single Spacer, so the two groups can no
        // longer collide the way absolutely-centred links did.
        return AppContainer(
          isHomeScreenLayout: widget.isHomeScreenLayout,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final double available = constraints.maxWidth;

              // Shed the optional parts before the pill can overflow.
              final bool showLinks = available >= 900;
              final bool showLanguage = available >= 600;

              return Row(
                children: [
                  AppLogo(
                    width: 96,
                    onTap: () => context.go(RouteNames.home),
                  ),
                  if (showLinks) ...[
                    const SizedBox(width: AppSpace.lg),
                    ...links.map((item) => _NavLinkItem(item: item)),
                  ],
                  const Spacer(),
                  const AppSearchBar(),
                  const SizedBox(width: AppSpace.sm),
                  if (showLanguage) ...[
                    const LanguageButton(),
                    const SizedBox(width: AppSpace.xs),
                  ],
                  const DeviceFrameSelectorButton(),
                  const SizedBox(width: AppSpace.xs),
                  const GitHubIconWithStars(
                    owner: ProjectLinks.owner,
                    repo: ProjectLinks.repoName,
                    url: ProjectLinks.repo,
                  ),
                  const SizedBox(width: AppSpace.xs),
                  const ThemeControlButton(),
                ],
              );
            },
          ),
        );
      },
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
    // Longest-prefix match, so /components/templates doesn't also light
    // up the plain /components link.
    final bool isActive = activeRoute.startsWith(widget.item.path) &&
        !(widget.item.path == RouteNames.components &&
            (activeRoute.startsWith(RouteNames.templates) ||
                activeRoute.startsWith(RouteNames.effects)));

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
              color: isActive
                  ? tokens.accent
                  : _hovered
                      ? tokens.foreground
                      : tokens.muted,
              fontSize: 14,
              fontWeight: isActive ? FontWeight.w700 : FontWeight.w600,
              height: 1.0,
            ),
          ),
        ),
      ),
    );
  }
}
