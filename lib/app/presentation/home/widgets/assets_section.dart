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
import 'package:flutterui/app/shared/presentation/utils/lang_util.dart';
import 'package:flutterui/app/shared/presentation/utils/sizing.dart';
import 'package:flutterui/app/shared/presentation/widgets/device_section_frame.dart';
import 'package:flutterui/app/shared/presentation/widgets/ui/app_button.dart';
import 'package:flutterui/components/data/logic/component/component_bloc.dart';
import 'package:go_router/go_router.dart';

/// "Browse the library" landing section: category switcher on the left,
/// live previews of the active category on the right.
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
                trailing: const Icon(Icons.arrow_forward_rounded, size: 16),
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
              Wrap(
                runSpacing: AppSpace.xxl,
                runAlignment: WrapAlignment.spaceBetween,
                alignment: WrapAlignment.spaceBetween,
                children: [
                  if (!isMobile)
                    SizedBox(
                      width: AppSizing.kWPercentage(
                          context, AppSizing.isTablet(context) ? 20 : 100),
                      child: Wrap(
                        spacing: AppSizing.kWPercentage(context, 2.5),
                        crossAxisAlignment: WrapCrossAlignment.center,
                        runAlignment: WrapAlignment.spaceBetween,
                        children: [
                          ...blocks.map(
                            (item) => MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: GestureDetector(
                                onTap: () =>
                                    setState(() => activeBlock = item),
                                child: ComponentBlock(
                                    item: item,
                                    isActive: activeBlock == item),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  Builder(
                    builder: (context) {
                      List<AppCategoryModel> allBlockItems =
                          blocks.expand((item) => item.items).toList();
                      List<AppCategoryModel> activeBlockItem =
                          activeBlock.items;
                      final displayWidget =
                          isMobile ? allBlockItems : activeBlockItem;
                      return Container(
                        alignment: Alignment.centerLeft,
                        constraints: BoxConstraints(
                            minHeight: AppSizing.kHPercentage(context, 25)),
                        width: AppSizing.kWPercentage(
                            context, AppSizing.isTablet(context) ? 70 : 100),
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 600),
                          key: ValueKey(activeBlock),
                          child: displayWidget.isEmpty && !isMobile
                              ? _ComingSoonBlock(
                                  height:
                                      AppSizing.kHPercentage(context, 25),
                                  width: AppSizing.kWPercentage(
                                      context,
                                      AppSizing.isTablet(context)
                                          ? 70
                                          : 100),
                                )
                              : Wrap(
                                  runSpacing:
                                      AppSizing.kWPercentage(context, 2.5),
                                  crossAxisAlignment:
                                      WrapCrossAlignment.start,
                                  alignment: AppSizing.isTablet(context)
                                      ? WrapAlignment.end
                                      : WrapAlignment.start,
                                  runAlignment: WrapAlignment.start,
                                  children: List.generate(
                                    displayWidget.length,
                                    (index) {
                                      final item = displayWidget[index];
                                      return Container(
                                        margin: EdgeInsets.only(
                                          left: AppSizing.isTablet(context)
                                              ? AppSizing.kWPercentage(
                                                  context, 2.5)
                                              : 0,
                                          right: AppSizing.isTablet(context)
                                              ? 0
                                              : AppSizing.kWPercentage(
                                                  context, 2.5),
                                        ),
                                        child: _CategoryPreviewCard(
                                          item: item,
                                          parentWidth: generateWidth(),
                                          parentHeight:
                                              AppSizing.kWPercentage(
                                            context,
                                            AppSizing.isXMobile(context)
                                                ? 60
                                                : isMobile
                                                    ? 35
                                                    : 15,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                        ),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: AppSpace.huge),
            ],
          ),
        ),
      ),
    );
  }

  double generateWidth() {
    if (AppSizing.isXMobile(context)) {
      return AppSizing.kWPercentage(context, 90);
    }
    if (AppSizing.isMobile(context)) {
      return AppSizing.kWPercentage(context, 42);
    } else if (AppSizing.isTablet(context)) {
      return AppSizing.kWPercentage(context, 19);
    } else {
      return AppSizing.kWPercentage(context, 20);
    }
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DeviceSectionFrame(
              deviceAlignment: widget.item.alignment,
              parentWidth: widget.parentWidth,
              parentHeight: widget.parentHeight,
              childWidth: AppSizing.kWPercentage(context, 10),
              childHeight: AppSizing.kWPercentage(context, 22),
              child: widget.item.widget,
            ),
            const SizedBox(height: AppSpace.md),
            Text(
              formatted,
              style: AppTypography.sans(
                color:
                    _hovered ? tokens.foreground : tokens.mutedForeground,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: AppSpace.sm),
          ],
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
