import 'package:flutter/material.dart';
import 'package:flutterui/app/core/routes/route_names.dart';
import 'package:flutterui/app/shared/presentation/theme/app_motion.dart';
import 'package:flutterui/app/shared/presentation/theme/app_tokens.dart';
import 'package:flutterui/app/shared/presentation/theme/app_typography.dart';
import 'package:flutterui/app/shared/presentation/utils/icons.dart';
import 'package:flutterui/app/shared/presentation/utils/lang_util.dart';
import 'package:flutterui/app/shared/presentation/utils/sizing.dart';
import 'package:flutterui/app/shared/presentation/utils/util.dart';
import 'package:flutterui/app/shared/presentation/widgets/app_icon_button.dart';
import 'package:flutterui/app/shared/presentation/widgets/app_logo.dart';
import 'package:flutterui/app/shared/presentation/widgets/github_icon_with_stars.dart';
import 'package:flutterui/app/shared/presentation/widgets/icon.dart';
import 'package:flutterui/app/shared/presentation/widgets/theme_variant_button.dart';
import 'package:go_router/go_router.dart';

/// Canonical links to the project's home on GitHub.
class ProjectLinks {
  ProjectLinks._();

  static const String repo = 'https://github.com/yunweneric/flutter-widgethub';
  static const String newIssue = '$repo/issues/new';
  static const String discussions = '$repo/discussions';
  static const String license = '$repo/blob/main/LICENSE';
  static const String contributing = '$repo/blob/main/CONTRIBUTION.md';
  static const String codeOfConduct = '$repo/blob/main/CODE_OF_CONDUCT.md';

  static const String owner = 'yunweneric';
  static const String repoName = 'flutter-widgethub';

  static const String x = 'https://x.com/yunweneric';
  static const String linkedIn = 'https://www.linkedin.com/in/yunweneric';
  static const String tiktok = 'https://www.tiktok.com/@yunweneric';
}

/// Site colophon: what this is, where to go next, and who made it.
///
/// Three link columns sit beside the brand block on desktop and wrap
/// underneath it on narrow viewports; a hairline rule separates the
/// navigation from the credit line.
class HomeFooter extends StatelessWidget {
  const HomeFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final bool isMobile = AppSizing.isMobile(context);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: tokens.sidebar,
        border: Border(top: BorderSide(color: tokens.border)),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1400),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? AppSpace.lg : AppSpace.xl,
              vertical: isMobile ? AppSpace.xxl : AppSpace.xxxl,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _FooterTop(isMobile: isMobile),
                const SizedBox(height: AppSpace.xxl),
                Container(height: 1, color: tokens.border),
                const SizedBox(height: AppSpace.lg),
                _FooterBottom(isMobile: isMobile),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Brand block plus the link columns.
class _FooterTop extends StatelessWidget {
  final bool isMobile;

  const _FooterTop({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    const brand = _FooterBrand();
    final columns = _FooterColumns(isMobile: isMobile);

    if (isMobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          brand,
          const SizedBox(height: AppSpace.xxl),
          columns,
        ],
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(width: 320, child: brand),
        const SizedBox(width: AppSpace.xxl),
        Expanded(child: columns),
      ],
    );
  }
}

/// Logo, one-line pitch and the social row.
class _FooterBrand extends StatelessWidget {
  const _FooterBrand();

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppLogo(width: 110, onTap: () => context.go(RouteNames.home)),
        const SizedBox(height: AppSpace.lg),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 320),
          child: Text(
            LangUtil.trans("footerTagline"),
            style: AppTypography.sans(
              color: tokens.mutedForeground,
              fontSize: 13.5,
              height: 1.55,
            ),
          ),
        ),
        const SizedBox(height: AppSpace.lg),
        Wrap(
          spacing: AppSpace.sm,
          runSpacing: AppSpace.sm,
          children: [
            const GitHubIconWithStars(
              owner: ProjectLinks.owner,
              repo: ProjectLinks.repoName,
              url: ProjectLinks.repo,
            ),
            _SocialButton(icon: AppIcons.x, url: ProjectLinks.x),
            _SocialButton(icon: AppIcons.linkedIn, url: ProjectLinks.linkedIn),
            _SocialButton(icon: AppIcons.tiktok, url: ProjectLinks.tiktok),
          ],
        ),
      ],
    );
  }
}

/// The three navigation columns.
class _FooterColumns extends StatelessWidget {
  final bool isMobile;

  const _FooterColumns({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    final columns = <Widget>[
      _FooterColumn(
        title: LangUtil.trans("footerBrowse"),
        links: [
          _FooterLinkData(
            label: LangUtil.trans("footerBlocks"),
            route: RouteNames.blocks,
          ),
          _FooterLinkData(
            label: LangUtil.trans("footerTemplates"),
            route: RouteNames.templates,
          ),
          _FooterLinkData(
            label: LangUtil.trans("footerAnimations"),
            route: RouteNames.animations,
          ),
          _FooterLinkData(
            label: LangUtil.trans("footerEffects"),
            route: RouteNames.effects,
          ),
        ],
      ),
      _FooterColumn(
        title: LangUtil.trans("resources"),
        links: [
          _FooterLinkData(
            label: LangUtil.trans("getStarted"),
            route: RouteNames.getStarted,
          ),
          _FooterLinkData(
            label: LangUtil.trans("footerRequestComponent"),
            route: RouteNames.requestComponent,
          ),
          _FooterLinkData(
            label: LangUtil.trans("footerContributing"),
            url: ProjectLinks.contributing,
          ),
          _FooterLinkData(
            label: LangUtil.trans("footerLicense"),
            url: ProjectLinks.license,
          ),
        ],
      ),
      _FooterColumn(
        title: LangUtil.trans("footerCommunity"),
        links: [
          _FooterLinkData(label: "GitHub", url: ProjectLinks.repo),
          _FooterLinkData(
            label: LangUtil.trans("footerDiscussions"),
            url: ProjectLinks.discussions,
          ),
          _FooterLinkData(
            label: LangUtil.trans("footerReportIssue"),
            url: ProjectLinks.newIssue,
          ),
          _FooterLinkData(
            label: LangUtil.trans("footerCodeOfConduct"),
            url: ProjectLinks.codeOfConduct,
          ),
        ],
      ),
    ];

    if (isMobile) {
      return Wrap(
        spacing: AppSpace.xxl,
        runSpacing: AppSpace.xl,
        children: [
          for (final column in columns) SizedBox(width: 140, child: column),
        ],
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final column in columns) Expanded(child: column),
      ],
    );
  }
}

/// One titled stack of links.
class _FooterColumn extends StatelessWidget {
  final String title;
  final List<_FooterLinkData> links;

  const _FooterColumn({required this.title, required this.links});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title.toUpperCase(), style: context.text.overline),
        const SizedBox(height: AppSpace.md),
        for (final link in links)
          Padding(
            padding: const EdgeInsets.only(bottom: AppSpace.sm),
            child: _FooterLink(data: link),
          ),
      ],
    );
  }
}

/// Where a footer link points: an in-app [route] or an external [url].
class _FooterLinkData {
  final String label;
  final String? route;
  final String? url;

  const _FooterLinkData({required this.label, this.route, this.url});
}

/// Muted link that picks up the palette accent on hover.
class _FooterLink extends StatefulWidget {
  final _FooterLinkData data;

  const _FooterLink({required this.data});

  @override
  State<_FooterLink> createState() => _FooterLinkState();
}

class _FooterLinkState extends State<_FooterLink> {
  bool _hovered = false;

  void _open() {
    final route = widget.data.route;
    if (route != null) {
      context.go(route);
      return;
    }
    final url = widget.data.url;
    if (url != null) UtilHelper.openUrl(url);
  }

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: _open,
        child: AnimatedDefaultTextStyle(
          duration: AppMotion.fast,
          style: AppTypography.sans(
            color: _hovered ? tokens.accent : tokens.mutedForeground,
            fontSize: 13.5,
            height: 1.4,
          ),
          child: Text(widget.data.label),
        ),
      ),
    );
  }
}

/// Square icon button that opens an external profile.
class _SocialButton extends StatelessWidget {
  final String icon;
  final String url;

  const _SocialButton({required this.icon, required this.url});

  @override
  Widget build(BuildContext context) {
    return AppIconButton(
      onPressed: () => UtilHelper.openUrl(url),
      child: AppIcon(icon: icon, size: 16),
    );
  }
}

/// Credit line, build note and the theme control.
class _FooterBottom extends StatelessWidget {
  final bool isMobile;

  const _FooterBottom({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final creditStyle = AppTypography.sans(
      color: tokens.mutedForeground,
      fontSize: 13,
      height: 1.5,
    );

    final credit = Text(
      LangUtil.trans("homeFooter", args: {
        "year": DateTime.now().year.toString(),
        "community": "Flutter Community",
      }),
      style: creditStyle,
      textAlign: isMobile ? TextAlign.center : TextAlign.left,
    );

    final buildNote = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppIcon(icon: AppIcons.code, size: 14, color: tokens.mutedForeground),
        const SizedBox(width: AppSpace.sm),
        Flexible(
          child: Text(LangUtil.trans("footerBuildNote"), style: creditStyle),
        ),
      ],
    );

    if (isMobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          credit,
          const SizedBox(height: AppSpace.sm),
          buildNote,
          const SizedBox(height: AppSpace.lg),
          const ThemeControlButton(),
        ],
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        credit,
        const SizedBox(width: AppSpace.xl),
        Flexible(child: buildNote),
        const Spacer(),
        const ThemeControlButton(),
      ],
    );
  }
}
