import 'package:flutter/material.dart';
import 'package:flutterui/app/core/routes/route_names.dart';
import 'package:flutterui/app/core/service_locators.dart';
import 'package:flutterui/app/presentation/home/data/export/sidebar_categories.dart';
import 'package:flutterui/app/presentation/home/model/component_block_model.dart';
import 'package:flutterui/app/presentation/home/widgets/component_block.dart';
import 'package:flutterui/app/presentation/home/widgets/section_header.dart';
import 'package:flutterui/app/shared/data/enums/component_category_enum.dart';
import 'package:flutterui/app/shared/data/enums/sub_component_category_enum.dart';
import 'package:flutterui/app/shared/presentation/theme/app_tokens.dart';
import 'package:flutterui/app/shared/presentation/theme/app_typography.dart';
import 'package:flutterui/app/shared/presentation/utils/icons.dart';
import 'package:flutterui/app/shared/presentation/utils/lang_util.dart';
import 'package:flutterui/app/shared/presentation/utils/sizing.dart';
import 'package:flutterui/app/shared/presentation/widgets/device_section_frame.dart';
import 'package:flutterui/app/shared/presentation/widgets/icon.dart';
import 'package:flutterui/app/shared/presentation/widgets/ui/app_button.dart';
import 'package:flutterui/components/data/logic/component/component_bloc.dart';
import 'package:go_router/go_router.dart';

/// "Browse the library" landing section: category switcher on top,
/// live previews of the active category below.
class AssetsSection extends StatefulWidget {
  const AssetsSection({super.key});

  @override
  State<AssetsSection> createState() => _AssetsSectionState();
}

class _AssetsSectionState extends State<AssetsSection> {
  late AppCategoryGroupModel activeBlock;
  List<AppCategoryGroupModel> blocks = sideBarCategories.where((item) {
    final condition = item.category != ComponentCategoryEnum.GETTING_STARTED &&
        item.category != ComponentCategoryEnum.INTRODUCTION;
    return condition;
  }).toList();
  final componentBloc = getIt.get<ComponentBloc>();

  @override
  void initState() {
    activeBlock = blocks.first;
    super.initState();
  }

  /// Columns the tile grid is laid out on: one on the smallest phones,
  /// two on phones and tablets, four from desktop up so a whole category
  /// fits on a single row.
  int get _columns {
    if (AppSizing.isXMobile(context)) return 1;
    if (AppSizing.isMobile(context) || AppSizing.isTablet(context)) return 2;
    return 4;
  }

  /// Tile height relative to its width — phones get taller previews since
  /// their tiles span (nearly) the full viewport.
  double get _tileRatio {
    if (AppSizing.isXMobile(context)) return 1.4;
    if (AppSizing.isMobile(context)) return 0.85;
    return 0.75;
  }

  @override
  Widget build(BuildContext context) {
    final bool isMobile = AppSizing.isMobile(context);

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1400),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? AppSpace.lg : AppSpace.xl,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SectionHeader(
                eyebrow: LangUtil.trans("assets"),
                title: LangUtil.trans("assetsTitle"),
                description: LangUtil.trans("assetsDescription"),
              ),
              const SizedBox(height: AppSpace.xl),
              AppButton(
                label: LangUtil.trans("browseAllAssets"),
                variant: AppButtonVariant.outline,
                trailing: const AppIcon(icon: AppIcons.arrowForward, size: 16),
                onPressed: () {
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
                },
              ),
              const SizedBox(height: AppSpace.xxl),
              LayoutBuilder(
                builder: (context, constraints) {
                  // Everything is measured off the real content width so the
                  // grid stays exact once the section hits its max width.
                  final int columns = _columns;
                  final double gap = isMobile ? AppSpace.lg : AppSpace.xl;
                  final double tileWidth =
                      (constraints.maxWidth - gap * (columns - 1)) / columns;
                  final double tileHeight = tileWidth * _tileRatio;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (!isMobile) ...[
                        Wrap(
                          spacing: gap,
                          runSpacing: AppSpace.lg,
                          children: [
                            ...blocks.map(
                              (item) => MouseRegion(
                                cursor: SystemMouseCursors.click,
                                child: GestureDetector(
                                  onTap: () =>
                                      setState(() => activeBlock = item),
                                  child: ComponentBlock(
                                    item: item,
                                    width: tileWidth,
                                    isActive: activeBlock == item,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: AppSpace.xl),
                      ],
                      Builder(
                        builder: (context) {
                          final List<AppCategoryModel> items = isMobile
                              ? blocks.expand((item) => item.items).toList()
                              : activeBlock.items;
                          return AnimatedSwitcher(
                            duration: const Duration(milliseconds: 600),
                            key: ValueKey(activeBlock),
                            child: items.isEmpty && !isMobile
                                ? _ComingSoonBlock(
                                    height: tileHeight,
                                    width: constraints.maxWidth,
                                  )
                                : Wrap(
                                    spacing: gap,
                                    runSpacing: gap,
                                    crossAxisAlignment:
                                        WrapCrossAlignment.start,
                                    children: [
                                      ...items.map(
                                        (item) => _CategoryPreviewCard(
                                          item: item,
                                          parentWidth: tileWidth,
                                          parentHeight: tileHeight,
                                        ),
                                      ),
                                    ],
                                  ),
                          );
                        },
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: AppSpace.huge),
            ],
          ),
        ),
      ),
    );
  }
}

/// Preview tile + label for a subcategory on the landing page.
class _CategoryPreviewCard extends StatefulWidget {
  final AppCategoryModel item;
  final double parentWidth;
  final double parentHeight;

  const _CategoryPreviewCard({
    required this.item,
    required this.parentWidth,
    required this.parentHeight,
  });

  @override
  State<_CategoryPreviewCard> createState() => _CategoryPreviewCardState();
}

class _CategoryPreviewCardState extends State<_CategoryPreviewCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final name = LangUtil.trans("${widget.item.subCategory}");
    final formatted = name[0].toUpperCase() +
        name.split("_").join(" ").substring(1).toLowerCase();

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: () {
          context.go(
              "/components/${widget.item.category.link()}/${widget.item.subCategory.link()}");
        },
        child: SizedBox(
          width: widget.parentWidth,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DeviceSectionFrame(
                deviceAlignment: widget.item.alignment,
                parentWidth: widget.parentWidth,
                parentHeight: widget.parentHeight,
                childWidth: widget.parentWidth * 0.5,
                childHeight: widget.parentWidth * 1.1,
                child: widget.item.widget,
              ),
              const SizedBox(height: AppSpace.md),
              Text(
                formatted,
                style: AppTypography.sans(
                  color: _hovered ? tokens.foreground : tokens.mutedForeground,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Placeholder for empty categories.
class _ComingSoonBlock extends StatelessWidget {
  final double height;
  final double width;

  const _ComingSoonBlock({required this.height, required this.width});

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: AppRadii.lgAll,
        border: Border.all(color: tokens.border),
        color: tokens.active.withValues(alpha: 0.4),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            LangUtil.trans("comingSoon"),
            style: context.text.h3,
          ),
          const SizedBox(height: AppSpace.sm),
          Text(
            LangUtil.trans("comingSoonDescription"),
            style: context.text.muted,
          ),
        ],
      ),
    );
  }
}
