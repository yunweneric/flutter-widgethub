/// Hero section widget for the home screen.
///
/// shadcn-style landing hero: announcement badge, display headline,
/// muted lead, CTA pair and a live component preview grid.
library;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
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
import 'package:flutterui/app/shared/presentation/widgets/device_section_frame.dart';
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

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final bool isMobile = AppSizing.isMobile(context);

    return BlocBuilder<ComponentBloc, ComponentState>(
      builder: (context, state) {
        final count = UtilHelper.countComponents(state.allComponents);
        List<Component> last3Components = state.allComponents.length > 3
            ? state.allComponents
                .sublist(
                    state.allComponents.length - 3, state.allComponents.length)
                .reversed
                .toList()
            : [];
        Widget? firstComponent;
        Widget? secondComponent;
        Widget? thirdComponent;

        if (last3Components.isNotEmpty) {
          final List<Widget> widgets = [];
          for (final component in last3Components) {
            for (final codeComponent in component.codeComponents) {
              widgets.add(codeComponent.widget);
            }
          }
          firstComponent = widgets.isNotEmpty ? widgets[0] : null;
          secondComponent = widgets.length > 1 ? widgets[1] : null;
          thirdComponent = widgets.length > 2 ? widgets[2] : null;
        }

        return Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1400),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? AppSpace.lg : AppSpace.xl,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: isMobile ? AppSpace.xxl : AppSpace.huge),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Left: copy + CTAs.
                      Expanded(
                        flex: isMobile ? 1 : 5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppBadge(
                              label: LangUtil.trans("heroBadge"),
                              variant: AppBadgeVariant.secondary,
                              leading: Container(
                                width: 6,
                                height: 6,
                                decoration: BoxDecoration(
                                  color: tokens.accent,
                                  borderRadius: BorderRadius.circular(999),
                                ),
                              ),
                            ),
                            const SizedBox(height: AppSpace.xl),
                            SelectableText(
                              LangUtil.trans("heroTitle", args: {
                                "count": count,
                              }),
                              style: isMobile
                                  ? context.text.h1
                                  : context.text.display,
                            ),
                            const SizedBox(height: AppSpace.xl),
                            ConstrainedBox(
                              constraints:
                                  const BoxConstraints(maxWidth: 520),
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
                                  onPressed: _goToComponents,
                                ),
                                AppButton(
                                  label: LangUtil.trans("browseAllAssets"),
                                  variant: AppButtonVariant.outline,
                                  size: AppButtonSize.lg,
                                  trailing: const Icon(
                                      Icons.arrow_forward_rounded,
                                      size: 16),
                                  onPressed: widget.onBrowserAll,
                                ),
                              ],
                            ),
                            const SizedBox(height: AppSpace.xxl),
                            Builder(builder: (context) {
                              final theme = Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? 'dark'
                                  : 'light';
                              return Opacity(
                                opacity: 0.75,
                                child: Row(
                                  children: [
                                    Image.asset(
                                        "assets/images/flutter_$theme.png",
                                        width: 88),
                                    const SizedBox(width: AppSpace.xl),
                                    Image.asset(
                                        "assets/images/dart_$theme.png",
                                        width: 88),
                                  ],
                                ),
                              );
                            }),
                          ],
                        ),
                      ),

                      // Right: live preview grid.
                      if (!isMobile) ...[
                        const SizedBox(width: AppSpace.xxxl),
                        Expanded(
                          flex: 6,
                          child: StaggeredGrid.count(
                            crossAxisCount: 4,
                            mainAxisSpacing: AppSpace.md,
                            crossAxisSpacing: AppSpace.md,
                            children: [
                              StaggeredGridTile.count(
                                crossAxisCellCount: 2,
                                mainAxisCellCount: 2.6,
                                child: _PreviewTile(
                                  child: AnimatedSwitcher(
                                    duration: const Duration(seconds: 1),
                                    child: firstComponent ??
                                        const NikeZoomerTemplate(),
                                  ),
                                ),
                              ),
                              StaggeredGridTile.count(
                                crossAxisCellCount: 2,
                                mainAxisCellCount: 3.6,
                                child: _PreviewTile(
                                  deviceAlignment: Alignment.center,
                                  child: AnimatedSwitcher(
                                    duration: const Duration(seconds: 2),
                                    child: secondComponent ??
                                        const LeaveReviewHomeScreen(),
                                  ),
                                ),
                              ),
                              StaggeredGridTile.count(
                                crossAxisCellCount: 2,
                                mainAxisCellCount: 1.0,
                                child: _PreviewTile(
                                  deviceAlignment: Alignment.topCenter,
                                  child: AnimatedSwitcher(
                                    duration: const Duration(seconds: 3),
                                    child: thirdComponent ??
                                        const ThemeToggle(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                  SizedBox(height: isMobile ? AppSpace.xxl : AppSpace.huge),

                  // Stats strip.
                  _StatsStrip(state: state, tokens: tokens),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

/// Bordered rounded tile that hosts a live device preview.
class _PreviewTile extends StatelessWidget {
  final Widget child;
  final Alignment? deviceAlignment;

  const _PreviewTile({required this.child, this.deviceAlignment});

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: tokens.active.withValues(alpha: 0.4),
        borderRadius: AppRadii.lgAll,
        border: Border.all(color: tokens.border),
      ),
      child: DeviceSectionFrame(
        deviceAlignment: deviceAlignment,
        child: child,
      ),
    );
  }
}

/// Row of headline stats under the hero.
class _StatsStrip extends StatelessWidget {
  final ComponentState state;
  final AppTokens tokens;

  const _StatsStrip({required this.state, required this.tokens});

  @override
  Widget build(BuildContext context) {
    final int templates = state.allComponents
        .where((c) => c.category == ComponentCategoryEnum.TEMPLATES)
        .length;
    final int components = state.allComponents.length - templates;

    final stats = [
      ('${components > 0 ? components : '–'}',
          LangUtil.trans("statsComponents")),
      ('${templates > 0 ? templates : '–'}', LangUtil.trans("statsTemplates")),
      ('100%', LangUtil.trans("statsFree")),
    ];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: AppSpace.xl),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: tokens.border),
        ),
      ),
      child: Wrap(
        spacing: AppSpace.huge,
        runSpacing: AppSpace.lg,
        children: [
          ...stats.map((stat) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  stat.$1,
                  style: AppTypography.sans(
                    color: tokens.accent,
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(stat.$2, style: context.text.muted),
              ],
            );
          }),
        ],
      ),
    );
  }
}
