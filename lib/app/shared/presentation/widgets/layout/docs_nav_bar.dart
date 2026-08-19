import 'package:flutter/material.dart';
import 'package:flutterui/app/core/routes/route_names.dart';
import 'package:flutterui/app/core/service_locators.dart';
import 'package:flutterui/app/shared/presentation/theme/app_tokens.dart';
import 'package:flutterui/app/shared/presentation/theme/app_typography.dart';
import 'package:flutterui/app/shared/presentation/utils/lang_util.dart';
import 'package:flutterui/app/shared/presentation/utils/project_links.dart';
import 'package:flutterui/app/shared/presentation/widgets/app_logo.dart';
import 'package:flutterui/app/shared/presentation/widgets/app_search_bar.dart';
import 'package:flutterui/app/shared/presentation/widgets/device_frame_selector_button.dart';
import 'package:flutterui/app/shared/presentation/widgets/github_icon_with_stars.dart';
import 'package:flutterui/app/shared/presentation/widgets/language_button.dart';
import 'package:flutterui/app/shared/presentation/widgets/layout/main_content.dart';
import 'package:flutterui/app/shared/presentation/widgets/layout/side_bar.dart';
import 'package:flutterui/app/shared/presentation/widgets/theme_variant_button.dart';
import 'package:go_router/go_router.dart';

/// Top bar for the docs shell (desktop).
///
/// Unlike the floating pill on the landing page, this bar is edge-to-edge
/// and shares the docs grid: the logo sits in a cell exactly as wide as
/// the sidebar — same fill, same right-hand rule, so the sidebar's
/// vertical line runs unbroken from the top of the page — and the nav
/// links start on the left edge of the centred content column below.
/// Actions stay flush right where the pointer expects them.
class DocsNavBar extends StatelessWidget {
  /// Height of the bar, including its bottom hairline.
  static const double navHeight = 64;

  const DocsNavBar({super.key});

  /// Left inset that puts a child on the same line as the content column
  /// below, given the width available beside the sidebar.
  static double contentInset(double available) {
    final double column = available < MainContent.maxContentWidth
        ? available
        : MainContent.maxContentWidth;
    return (available - column) / 2 + AppSpace.xxl;
  }

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    return Container(
      height: navHeight,
      decoration: BoxDecoration(
        color: tokens.background,
        border: Border(bottom: BorderSide(color: tokens.border)),
      ),
      child: Row(
        children: [
          // Sidebar cell — continues the sidebar band up into the bar.
          Container(
            width: SideBar.width,
            height: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: AppSpace.lg),
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              color: tokens.sidebar,
              border: Border(right: BorderSide(color: tokens.border)),
            ),
            child: AppLogo(
              width: 104,
              onTap: () => context.go(RouteNames.home),
            ),
          ),

          // Content cell — links on the content column's left edge.
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final double available = constraints.maxWidth;

                // The bar sheds its optional parts before it can overflow.
                // Section links go first — the sidebar already navigates —
                // then the language picker.
                final bool showLinks = available >= 720;
                final bool showLanguage = available >= 620;

                return Padding(
                  padding: EdgeInsets.only(
                    left: contentInset(available),
                    right: AppSpace.xl,
                  ),
                  child: Row(
                    children: [
                      if (showLinks) const _DocsNavLinks(),
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
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

/// The three section links, with the active one underlined against the
/// bar's bottom hairline.
class _DocsNavLinks extends StatelessWidget {
  const _DocsNavLinks();

  @override
  Widget build(BuildContext context) {
    final activeRoute =
        getIt.get<GoRouter>().routeInformationProvider.value.uri.path;

    // Longest-prefix match, so /components/templates doesn't also light
    // up the plain /components link.
    bool isActive(String path) =>
        activeRoute.startsWith(path) &&
        !(path == RouteNames.components &&
            (activeRoute.startsWith(RouteNames.templates) ||
                activeRoute.startsWith(RouteNames.effects)));

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _DocsNavLink(
          label: LangUtil.trans("components"),
          path: RouteNames.components,
          isActive: isActive(RouteNames.components),
        ),
        _DocsNavLink(
          label: LangUtil.trans("templates"),
          path: RouteNames.templates,
          isActive: isActive(RouteNames.templates),
        ),
        _DocsNavLink(
          label: LangUtil.trans("effects"),
          path: RouteNames.effects,
          isActive: isActive(RouteNames.effects),
        ),
      ],
    );
  }
}

/// One section link. The active tab sits on a 2px accent rule flush with
/// the bottom of the bar, tying the nav to the section below it.
class _DocsNavLink extends StatefulWidget {
  final String label;
  final String path;
  final bool isActive;

  const _DocsNavLink({
    required this.label,
    required this.path,
    required this.isActive,
  });

  @override
  State<_DocsNavLink> createState() => _DocsNavLinkState();
}

class _DocsNavLinkState extends State<_DocsNavLink> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: () => context.go(widget.path),
        child: Container(
          height: DocsNavBar.navHeight,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: AppSpace.md),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: widget.isActive ? tokens.accent : Colors.transparent,
                width: 2,
              ),
            ),
          ),
          child: Text(
            widget.label,
            style: AppTypography.sans(
              color: widget.isActive
                  ? tokens.foreground
                  : _hovered
                      ? tokens.foreground
                      : tokens.muted,
              fontSize: 14,
              fontWeight: widget.isActive ? FontWeight.w700 : FontWeight.w600,
              height: 1.0,
            ),
          ),
        ),
      ),
    );
  }
}
