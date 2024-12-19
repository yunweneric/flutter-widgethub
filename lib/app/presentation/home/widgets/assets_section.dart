import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutterui/app/core/routes/route_names.dart';
import 'package:flutterui/app/core/service_locators.dart';
import 'package:flutterui/app/presentation/home/data/export/sidebar_categories.dart';
import 'package:flutterui/app/presentation/home/model/component_block_model.dart';
import 'package:flutterui/app/presentation/home/widgets/component_block.dart';
import 'package:flutterui/app/shared/data/enums/component_category_enum.dart';
import 'package:flutterui/app/shared/data/enums/sub_component_category_enum.dart';
import 'package:flutterui/app/shared/presentation/utils/icons.dart';
import 'package:flutterui/app/shared/presentation/utils/lang_util.dart';
import 'package:flutterui/app/shared/presentation/utils/sizing.dart';
import 'package:flutterui/app/shared/presentation/widgets/device_section_frame.dart';
import 'package:flutterui/components/data/logic/component/component_bloc.dart';
import 'package:go_router/go_router.dart';

class AssetsSection extends StatefulWidget {
  const AssetsSection({super.key});

  @override
  State<AssetsSection> createState() => _AssetsSectionState();
}

class _AssetsSectionState extends State<AssetsSection> {
  late AppCategoryGroupModel activeBlock;
  List<AppCategoryGroupModel> blocks = sideBarCategories.where((item) {
    final condition = item.category != ComponentCategoryEnum.GETTING_STARTED && item.category != ComponentCategoryEnum.INTRODUCTION;
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
    return Container(
      width: AppSizing.kWPercentage(context, 90),
      alignment: Alignment.topLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SvgPicture.asset(AppIcons.diamond),
              AppSizing.kwSpacer(5.w),
              Text(
                LangUtil.trans("assets"),
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 18.sp,
                      color: Theme.of(context).primaryColor,
                    ),
              ),
            ],
          ),
          AppSizing.kh20Spacer(),
          SizedBox(
            width: AppSizing.kHPercentage(context, 90),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  LangUtil.trans("assetsTitle"),
                  style: Theme.of(context).textTheme.displayLarge!.copyWith(fontSize: 40.sp),
                ),
                AppSizing.kh20Spacer(),
                Text(
                  LangUtil.trans("assetsDescription"),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                AppSizing.kh20Spacer(),
              ],
            ),
          ),
          AppSizing.kh20Spacer(),
          TextButton.icon(
            style: TextButton.styleFrom(backgroundColor: Theme.of(context).scaffoldBackgroundColor),
            iconAlignment: IconAlignment.end,
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
            icon: const Icon(Icons.arrow_forward_rounded),
            label:  Text(LangUtil.trans("browseAllAssets"))

          ),
          AppSizing.kh20Spacer(),
          Wrap(
            runSpacing: 40.h,
            runAlignment: WrapAlignment.spaceBetween,
            alignment: WrapAlignment.spaceBetween,
            children: [
              if (!AppSizing.isMobile(context))
                SizedBox(
                  width: AppSizing.kWPercentage(context, AppSizing.isTablet(context) ? 20 : 100),
                  child: Wrap(
                    spacing: AppSizing.kWPercentage(context, 2.5),
                    crossAxisAlignment: WrapCrossAlignment.center,
                    runAlignment: WrapAlignment.spaceBetween,
                    children: [
                      ...blocks.map(
                        (item) => InkWell(
                          enableFeedback: false,
                          hoverColor: Theme.of(context).scaffoldBackgroundColor,
                          highlightColor: Theme.of(context).scaffoldBackgroundColor,
                          focusColor: Theme.of(context).scaffoldBackgroundColor,
                          splashColor: Theme.of(context).scaffoldBackgroundColor,
                          onTap: () => setState(() => activeBlock = item),
                          onHover: (status) {},
                          child: ComponentBlock(item: item, isActive: activeBlock == item),
                        ),
                      )
                    ],
                  ),
                ),
              Builder(
                builder: (context) {
                  List<AppCategoryModel> allBlockItems = blocks.expand((item) => item.items).toList();
                  List<AppCategoryModel> activeBlockItem = activeBlock.items;
                  final displayWidget = AppSizing.isMobile(context) ? allBlockItems : activeBlockItem;
                  return Container(
                    alignment: Alignment.centerLeft,
                    constraints: BoxConstraints(minHeight: AppSizing.kHPercentage(context, 25)),
                    width: AppSizing.kWPercentage(context, AppSizing.isTablet(context) ? 70 : 100),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 1500),
                      key: ValueKey(activeBlock),
                      child: displayWidget.isEmpty && !AppSizing.isMobile(context)
                          ? SizedBox(
                              height: AppSizing.kHPercentage(context, 25),
                              width: AppSizing.kWPercentage(context, AppSizing.isTablet(context) ? 70 : 100),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    LangUtil.trans("comingSoon"),
                                    style: Theme.of(context).textTheme.displayLarge,
                                  )
,
                                  AppSizing.kh10Spacer(),
                                   Text(LangUtil.trans("comingSoonDescription"))

                                ],
                              ),
                            )
                          : Container(
                              // color: Colors.teal,
                              child: Wrap(
                                // spacing: AppSizing.kWPercentage(context, 2.5),
                                runSpacing: AppSizing.kWPercentage(context, 2.5),
                                crossAxisAlignment: WrapCrossAlignment.start,
                                alignment: AppSizing.isTablet(context) ? WrapAlignment.end : WrapAlignment.start,
                                runAlignment: WrapAlignment.start,
                                children: List.generate(
                                  displayWidget.length,
                                  (index) {
                                    return Container(
                                      margin: EdgeInsets.only(
                                        left: AppSizing.isTablet(context) ? AppSizing.kWPercentage(context, 2.5) : 0,
                                        right: AppSizing.isTablet(context) ? 0 : AppSizing.kWPercentage(context, 2.5),
                                      ),
                                      child: Builder(
                                        builder: (context) {
                                          final item = displayWidget[index];
                                          return InkWell(
                                            enableFeedback: false,
                                            hoverColor: Theme.of(context).scaffoldBackgroundColor,
                                            highlightColor: Theme.of(context).scaffoldBackgroundColor,
                                            focusColor: Theme.of(context).scaffoldBackgroundColor,
                                            splashColor: Theme.of(context).scaffoldBackgroundColor,
                                            onTap: () {
                                              context.go("/components/${item.category.link()}/${item.subCategory.link()}");
                                            },
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                DeviceSectionFrame(
                                                  deviceAlignment: item.alignment,
                                                  parentWidth: generateWidth(),
                                                  parentHeight: AppSizing.kWPercentage(
                                                    context,
                                                    AppSizing.isXMobile(context)
                                                        ? 60
                                                        : AppSizing.isMobile(context)
                                                            ? 35
                                                            : 15,
                                                  ),
                                                  childWidth: AppSizing.kWPercentage(context, 10),
                                                  childHeight: AppSizing.kWPercentage(context, 22),
                                                  child: item.widget,
                                                ),
                                                AppSizing.kh20Spacer(),
                                                Text(item.subCategory.describe())
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                    ),
                  );
                },
              ),
            ],
          ),
          AppSizing.khSpacer(60),
        ],
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
