/// Hero section widget for the home screen.
///
/// Landing hero: announcement badge, display headline with the live
/// component count highlighted, muted lead, CTA pair, and a self-scrolling
/// wall of live component previews on the right.
library;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterui/app/core/routes/route_names.dart';
import 'package:flutterui/app/core/service_locators.dart';
import 'package:flutterui/app/presentation/home/model/component_block_model.dart';
import 'package:flutterui/app/presentation/home/screens/theme_toggle.dart';
import 'package:flutterui/app/shared/data/enums/component_category_enum.dart';
import 'package:flutterui/app/shared/data/enums/sub_component_category_enum.dart';
import 'package:flutterui/app/shared/data/models/component.dart';
import 'package:flutterui/app/shared/presentation/theme/app_tokens.dart';
import 'package:flutterui/app/shared/presentation/theme/app_typography.dart';
import 'package:flutterui/app/shared/presentation/utils/lang_util.dart';
import 'package:flutterui/app/shared/presentation/utils/sizing.dart';
import 'package:flutterui/app/shared/presentation/utils/util.dart';
import 'package:flutterui/app/shared/presentation/widgets/ui/app_badge.dart';
import 'package:flutterui/app/shared/presentation/widgets/ui/app_button.dart';
import 'package:flutterui/components/data/logic/component/component_bloc.dart';
import 'package:flutterui/components/presentation/templates/leave_review/leave_a_review_widget.dart';
import 'package:flutterui/components/presentation/templates/nike_zoomer/nike_zoomer_widget.dart';
import 'package:go_router/go_router.dart';

/// Hero section with live component previews.
class HeroSection extends StatefulWidget {
  /// Callback invoked when the "Browse All Assets" button is pressed.
  final VoidCallback onBrowserAll;

  /// Creates a hero section widget.
  const HeroSection({super.key, required this.onBrowserAll});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection> {
  final componentBloc = getIt.get<ComponentBloc>();

  @override
  void initState() {
    componentBloc.add(GetAllComponentsEvent());
    super.initState();
  }

  void _goToComponents() {
    componentBloc.add(
      UpdateActiveCategoryEvent(
        category: AppCategoryModel(
          widget: widget,
          category: ComponentCategoryEnum.INTRODUCTION,
          subCategory: SubComponentCategoryEnum.ALL_COMPONENTS,
        ),
      ),
    );
    context.go(RouteNames.components);
  }

  void _openComponent(Component component) {
    componentBloc.add(UpdateActiveComponentEvent(newComponent: component));
    context.go(
      "/components/${component.category.link()}"
      "/${component.subcategory.link()}/${component.id}/",
    );
  }

  /// Newest components first, capped so the wall stays cheap to render.
  List<Component> _showcase(List<Component> all) {
    final list = all.reversed.toList();
    return list.length > 8 ? list.sublist(0, 8) : list;
  }

  @override
  Widget build(BuildContext context) {
    final bool isMobile = AppSizing.isMobile(context);

    return BlocBuilder<ComponentBloc, ComponentState>(
      builder: (context, state) {
        final count = UtilHelper.countComponents(state.allComponents);
        final showcase = _showcase(state.allComponents);

        final Widget copy = _HeroCopy(
          count: count,
          onExplore: _goToComponents,
          onBrowseAll: widget.onBrowserAll,
        );

        final Widget stage = _InteractiveStage(
          components: showcase,
          onOpen: _openComponent,
        );

        return Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1400),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? AppSpace.lg : AppSpace.xl,
              ),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final bool wide = constraints.maxWidth >= 940;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                          height: isMobile ? AppSpace.xxl : AppSpace.huge),
                      if (wide)
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(flex: 5, child: copy),
                            const SizedBox(width: AppSpace.xxxl),
                            Expanded(flex: 6, child: stage),
                          ],
                        )
                      else ...[
                        copy,
                        const SizedBox(height: AppSpace.xxl),
                        stage,
                      ],
                      SizedBox(
                          height: isMobile ? AppSpace.xxl : AppSpace.huge),
                      _StatsStrip(state: state),
                    ],
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}

/// Left column: badge, headline, lead, CTAs and the tech row.
class _HeroCopy extends StatelessWidget {
  final String count;
  final VoidCallback onExplore;
  final VoidCallback onBrowseAll;

  const _HeroCopy({
    required this.count,
    required this.onExplore,
    required this.onBrowseAll,
  });

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final bool isMobile = AppSizing.isMobile(context);
    final String theme =
        Theme.of(context).brightness == Brightness.dark ? 'dark' : 'light';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppBadge(
          label: LangUtil.trans("heroBadge"),
          variant: AppBadgeVariant.secondary,
          leading: _PulsingDot(color: tokens.accent),
        ),
        const SizedBox(height: AppSpace.xl),
        _HeadlineText(
          count: count,
          style: isMobile ? context.text.h1 : context.text.display,
        ),
        const SizedBox(height: AppSpace.xl),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 520),
          child: SelectableText(
            LangUtil.trans("heroDescription"),
            style: context.text.lead,
          ),
        ),
        const SizedBox(height: AppSpace.xxl),
        Wrap(
          spacing: AppSpace.md,
          runSpacing: AppSpace.md,
          children: [
            AppButton(
              label: LangUtil.trans("exploreNow"),
              size: AppButtonSize.lg,
              onPressed: onExplore,
            ),
            AppButton(
              label: LangUtil.trans("browseAllAssets"),
              variant: AppButtonVariant.outline,
              size: AppButtonSize.lg,
              trailing: const Icon(Icons.arrow_forward_rounded, size: 16),
              onPressed: onBrowseAll,
            ),
          ],
        ),
        const SizedBox(height: AppSpace.xxl),
        // Tech row — logos plus a quiet licence note.
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: AppSpace.xl,
          runSpacing: AppSpace.md,
          children: [
            Opacity(
              opacity: 0.75,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset("assets/images/flutter_$theme.png", width: 88),
                  const SizedBox(width: AppSpace.xl),
                  Image.asset("assets/images/dart_$theme.png", width: 88),
                ],
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(width: 1, height: 16, color: tokens.border),
                const SizedBox(width: AppSpace.lg),
                Icon(Icons.bolt_rounded, size: 15, color: tokens.accent),
                const SizedBox(width: 6),
                Text(
                  LangUtil.trans("heroCopyPaste"),
                  style: context.text.muted,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

/// Headline with the component count picked out in the accent colour.
class _HeadlineText extends StatelessWidget {
  final String count;
  final TextStyle style;

  const _HeadlineText({required this.count, required this.style});

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final String title = LangUtil.trans("heroTitle", args: {"count": count});
    final int at = count.isEmpty ? -1 : title.indexOf(count);

    if (at < 0) {
      return SelectableText(title, style: style);
    }

    return SelectableText.rich(
      TextSpan(
        style: style,
        children: [
          TextSpan(text: title.substring(0, at)),
          TextSpan(
            text: title.substring(at, at + count.length),
            style: style.copyWith(color: tokens.accent),
          ),
          TextSpan(text: title.substring(at + count.length)),
        ],
      ),
    );
  }
}

/// Small dot with a slow outward pulse — used inside the hero badge.
class _PulsingDot extends StatefulWidget {
  final Color color;

  const _PulsingDot({required this.color});

  @override
  State<_PulsingDot> createState() => _PulsingDotState();
}

class _PulsingDotState extends State<_PulsingDot>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1800),
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 8,
      height: 8,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          final double t = _controller.value;
          return Stack(
            alignment: Alignment.center,
            children: [
              Transform.scale(
                scale: 1 + t * 1.6,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: widget.color.withValues(alpha: (1 - t) * 0.5),
                  ),
                ),
              ),
              child!,
            ],
          );
        },
        child: Container(
          width: 6,
          height: 6,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: widget.color,
          ),
        ),
      ),
    );
  }
}

/// Right column: a full-size phone you can actually use, plus a dock to
/// switch between apps.
class _InteractiveStage extends StatefulWidget {
  final List<Component> components;
  final ValueChanged<Component> onOpen;

  const _InteractiveStage({required this.components, required this.onOpen});

  @override
  State<_InteractiveStage> createState() => _InteractiveStageState();
}

class _InteractiveStageState extends State<_InteractiveStage> {
  int _index = 0;

  /// Previews shown until the component bloc has loaded.
  static final List<_StageApp> _fallback = [
    const _StageApp(title: 'Nike Zoomer', child: NikeZoomerTemplate()),
    const _StageApp(title: 'Leave a review', child: LeaveReviewHomeScreen()),
    const _StageApp(title: 'Theme toggle', child: ThemeToggle()),
  ];

  List<_StageApp> get _apps => widget.components.isEmpty
      ? _fallback
      : [
          for (final component in widget.components)
            _StageApp(
              title: LangUtil.trans(component.title),
              subtitle: component.category.describe(),
              component: component,
              child: component.codeComponents.first.widget,
            ),
        ];

  void _select(int i) {
    final apps = _apps;
    if (apps.isEmpty) return;
    setState(() => _index = i % apps.length);
  }

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final bool isMobile = AppSizing.isMobile(context);
    final apps = _apps;
    if (apps.isEmpty) return const SizedBox.shrink();

    final int index = _index.clamp(0, apps.length - 1);
    final _StageApp app = apps[index];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          height: isMobile ? 520 : 620,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Accent bloom behind the device.
              Positioned.fill(
                child: IgnorePointer(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: RadialGradient(
                        radius: 0.7,
                        colors: [
                          tokens.accent.withValues(alpha: 0.18),
                          tokens.accent.withValues(alpha: 0.0),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              // The live app — fully interactive.
              _PhoneShell(
                key: ValueKey(app.title),
                child: app.child,
              ),
              // Step through apps without touching the screen.
              Positioned(
                left: 0,
                child: _StageArrow(
                  icon: Icons.chevron_left_rounded,
                  onTap: () => _select(index - 1 + apps.length),
                ),
              ),
              Positioned(
                right: 0,
                child: _StageArrow(
                  icon: Icons.chevron_right_rounded,
                  onTap: () => _select(index + 1),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpace.lg),
        // App dock.
        SizedBox(
          height: 40,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: apps.length,
            separatorBuilder: (_, __) => const SizedBox(width: AppSpace.sm),
            itemBuilder: (context, i) => _DockChip(
              app: apps[i],
              active: i == index,
              onTap: () => _select(i),
            ),
          ),
        ),
        const SizedBox(height: AppSpace.md),
        // Current app name + link to its page.
        Row(
          children: [
            Expanded(
              child: Text(
                app.subtitle == null
                    ? app.title
                    : '${app.title} · ${app.subtitle}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: context.text.muted,
              ),
            ),
            if (app.component != null)
              AppButton(
                label: LangUtil.trans("viewComponent"),
                variant: AppButtonVariant.link,
                size: AppButtonSize.sm,
                trailing: const Icon(Icons.north_east_rounded, size: 14),
                onPressed: () => widget.onOpen(app.component!),
              ),
          ],
        ),
      ],
    );
  }
}

/// One entry in the stage dock.
class _StageApp {
  final String title;
  final String? subtitle;
  final Widget child;
  final Component? component;

  const _StageApp({
    required this.title,
    required this.child,
    this.subtitle,
    this.component,
  });
}

/// Phone chrome around a live app.
///
/// The app is laid out against a real phone viewport (the [MediaQuery]
/// override is what makes viewport-relative components size themselves
/// correctly), then scaled to the stage. Scaling keeps hit-testing intact,
/// so everything inside stays tappable, draggable and scrollable.
class _PhoneShell extends StatelessWidget {
  final Widget child;

  /// Logical viewport the app is laid out against (iPhone 14-ish).
  static const Size viewport = Size(390, 844);

  const _PhoneShell({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    return FittedBox(
      fit: BoxFit.contain,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: ZincColors.zinc900,
          borderRadius: BorderRadius.circular(52),
          border: Border.all(color: ZincColors.zinc700, width: 2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.45),
              blurRadius: 60,
              spreadRadius: -10,
              offset: const Offset(0, 24),
            ),
            BoxShadow(
              color: tokens.accent.withValues(alpha: 0.12),
              blurRadius: 40,
              spreadRadius: -20,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(42),
          child: SizedBox(
            width: viewport.width,
            height: viewport.height,
            child: Stack(
              children: [
                MediaQuery(
                  data: MediaQuery.of(context).copyWith(
                    size: viewport,
                    padding: const EdgeInsets.only(top: 44, bottom: 20),
                    viewPadding: const EdgeInsets.only(top: 44, bottom: 20),
                    viewInsets: EdgeInsets.zero,
                  ),
                  child: Scaffold(body: child),
                ),
                // Dynamic island.
                Positioned(
                  top: 12,
                  left: 0,
                  right: 0,
                  child: IgnorePointer(
                    child: Center(
                      child: Container(
                        width: 104,
                        height: 26,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(13),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Circular prev/next control sitting over the stage edges.
class _StageArrow extends StatefulWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _StageArrow({required this.icon, required this.onTap});

  @override
  State<_StageArrow> createState() => _StageArrowState();
}

class _StageArrowState extends State<_StageArrow> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: _hovered ? tokens.accent : tokens.card,
            shape: BoxShape.circle,
            border: Border.all(color: tokens.border),
          ),
          child: Icon(
            widget.icon,
            size: 22,
            color: _hovered ? tokens.onBrand : tokens.foreground,
          ),
        ),
      ),
    );
  }
}

/// App switcher chip in the dock.
class _DockChip extends StatelessWidget {
  final _StageApp app;
  final bool active;
  final VoidCallback onTap;

  const _DockChip({
    required this.app,
    required this.active,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          curve: Curves.easeOut,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpace.md,
            vertical: AppSpace.sm,
          ),
          decoration: BoxDecoration(
            color: active ? tokens.brandFill : tokens.card,
            borderRadius: AppRadii.mdAll,
            border: Border.all(
              color: active ? tokens.accent : tokens.border,
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            app.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTypography.sans(
              color: active ? tokens.onBrandFill : tokens.muted,
              fontSize: 12,
              fontWeight: active ? FontWeight.w700 : FontWeight.w500,
              height: 1.0,
            ),
          ),
        ),
      ),
    );
  }
}

/// Row of headline stats under the hero.
class _StatsStrip extends StatelessWidget {
  final ComponentState state;

  const _StatsStrip({required this.state});

  @override
  Widget build(BuildContext context) {
    final int templates = state.allComponents
        .where((c) => c.category == ComponentCategoryEnum.TEMPLATES)
        .length;
    final int components = state.allComponents.length - templates;

    final stats = <(String, String, IconData)>[
      (
        components > 0 ? '$components' : '–',
        LangUtil.trans("statsComponents"),
        Icons.widgets_outlined,
      ),
      (
        templates > 0 ? '$templates' : '–',
        LangUtil.trans("statsTemplates"),
        Icons.dashboard_customize_outlined,
      ),
      (
        '100%',
        LangUtil.trans("statsFree"),
        Icons.lock_open_rounded,
      ),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final bool wide = constraints.maxWidth >= 720;
        final cards = [
          for (final stat in stats)
            _StatCard(value: stat.$1, label: stat.$2, icon: stat.$3),
        ];

        if (!wide) {
          return Column(
            children: [
              for (int i = 0; i < cards.length; i++) ...[
                if (i > 0) const SizedBox(height: AppSpace.md),
                cards[i],
              ],
            ],
          );
        }

        return Row(
          children: [
            for (int i = 0; i < cards.length; i++) ...[
              if (i > 0) const SizedBox(width: AppSpace.md),
              Expanded(child: cards[i]),
            ],
          ],
        );
      },
    );
  }
}

/// One bordered stat tile.
class _StatCard extends StatelessWidget {
  final String value;
  final String label;
  final IconData icon;

  const _StatCard({
    required this.value,
    required this.label,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    return Container(
      padding: const EdgeInsets.all(AppSpace.lg),
      decoration: BoxDecoration(
        color: tokens.card,
        borderRadius: AppRadii.lgAll,
        border: Border.all(color: tokens.border),
      ),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: tokens.brandFill,
              borderRadius: AppRadii.mdAll,
              border: Border.all(color: tokens.brandFillBorder),
            ),
            child: Icon(icon, size: 18, color: tokens.accent),
          ),
          const SizedBox(width: AppSpace.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  value,
                  style: AppTypography.sans(
                    color: tokens.foreground,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    height: 1.1,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: context.text.muted,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
