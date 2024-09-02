// import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutterui/components/data/logic/component/component_bloc.dart';
import 'package:flutterui/components/ui/templates/nike_zoomer/nike_zoomer.dart';
import 'package:flutterui/core/service_locators.dart';
import 'package:flutterui/screens/home/model/component_block_model.dart';
import 'package:flutterui/screens/home/ui/apps/leave_review/home.dart';
import 'package:flutterui/screens/home/ui/apps/theme_toggle/theme_toggle.dart';
// import 'package:flutterui/screens/routes/app_router.gr.dart';
import 'package:flutterui/screens/routes/route_names.dart';
import 'package:flutterui/shared/data/enums/component_category_enum.dart';
import 'package:flutterui/shared/data/enums/sub_component_category_enum.dart';
import 'package:flutterui/shared/ui/utils/colors.dart';
import 'package:flutterui/shared/ui/utils/sizing.dart';
import 'package:flutterui/shared/ui/widgets/device_section_frame.dart';
import 'package:go_router/go_router.dart';

class HeroSection extends StatefulWidget {
  final VoidCallback onBrowserAll;
  const HeroSection({super.key, required this.onBrowserAll});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection> {
  final componentBloc = getIt.get<ComponentBloc>();
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: AppSizing.isMobile(context) ? null : AppSizing.kHPercentage(context, 90),
      margin: EdgeInsets.symmetric(horizontal: AppSizing.kWPercentage(context, 5)),
      width: AppSizing.kWPercentage(context, 100),
      alignment: Alignment.topLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppSizing.kh20Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: AppSizing.kWPercentage(context, AppSizing.isMobile(context) ? 80 : 35),
                // margin: EdgeInsets.only(left: AppSizing.kWPercentage(context, 5)),
                // margin: EdgeInsets.symmetric(horizontal: AppSizing.kWPercentage(context, 5)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Build Stunning Flutter Apps with Ease",
                      style: Theme.of(context).textTheme.displayLarge!.copyWith(fontSize: AppSizing.isMobile(context) ? 40.sp : 50.sp),
                    ),
                    AppSizing.kh20Spacer(),
                    Text(
                      "From ready-to-use components and flexible layout blocks to smooth animations and striking effects, our tools help you create beautiful, functional apps quickly and efficiently.",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    AppSizing.kh20Spacer(),
                    Builder(builder: (context) {
                      final theme = Theme.of(context).brightness == Brightness.dark ? 'dark' : 'light';
                      return Row(
                        children: [
                          Image.asset("assets/images/flutter_$theme.png", width: 100.w),
                          AppSizing.kwSpacer(20.w),
                          Image.asset("assets/images/dart_$theme.png", width: 100.w),
                        ],
                      );
                    }),
                    AppSizing.kh20Spacer(),
                    AppSizing.kh20Spacer(),
                    Wrap(
                      runSpacing: 20,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).primaryColor,
                          ),
                          onPressed: () {
                            componentBloc.add(
                              UpdateActiveCategoryEvent(
                                category: AppCategoryModel(
                                  widget: widget,
                                  category: ComponentCategoryEnum.GETTING_STARTED,
                                  subCategory: SubComponentCategoryEnum.GETTING_STARTED,
                                ),
                              ),
                            );
                            context.go(RouteNames.getStarted);
                          },
                          child: const Text(
                            "Get started",
                            style: TextStyle(color: AppColors.BG),
                          ),
                        ),
                        AppSizing.kwSpacer(20.w),
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                            side: BorderSide(color: Theme.of(context).dividerColor),
                          ),
                          iconAlignment: IconAlignment.end,
                          onPressed: widget.onBrowserAll,
                          icon: const Icon(Icons.arrow_forward_rounded),
                          label: Text(
                            "Browse all assets",
                            style: TextStyle(color: Theme.of(context).primaryColorDark),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              if (!AppSizing.isMobile(context))
                SizedBox(
                  // height: AppSizing.kHPercentage(context, 100),
                  // width: AppSizing.kWPercentage(context, 52),
                  width: AppSizing.kWPercentage(context, 52),
                  // color: Colors.teal,
                  child: StaggeredGrid.count(
                    crossAxisCount: 4,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    children: [
                      StaggeredGridTile.count(
                        crossAxisCellCount: 2,
                        mainAxisCellCount: 2.6,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: AppSizing.radiusMd(),
                          ),
                          child: const DeviceSectionFrame(
                            child: NikeZoomerTemplate(),
                          ),
                        ),
                      ),
                      StaggeredGridTile.count(
                        crossAxisCellCount: 2,
                        mainAxisCellCount: 3.6,
                        child: Container(
                          decoration: BoxDecoration(borderRadius: AppSizing.radiusMd()),
                          child: const DeviceSectionFrame(
                            deviceAlignment: Alignment.center,
                            child: LeaveReviewHomeScreen(),
                          ),
                        ),
                      ),
                      StaggeredGridTile.count(
                        crossAxisCellCount: 2,
                        mainAxisCellCount: 1.0,
                        child: Builder(builder: (context) {
                          return Container(
                            decoration: BoxDecoration(borderRadius: AppSizing.radiusMd()),
                            child: const DeviceSectionFrame(
                              deviceAlignment: Alignment.topCenter,
                              child: ThemeToggle(),
                            ),
                          );
                        }),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class Demo1 extends StatefulWidget {
  const Demo1({super.key});

  @override
  State<Demo1> createState() => _Demo1State();
}

class _Demo1State extends State<Demo1> {
  final isRed = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 300,
            width: 200,
            color: Colors.red,
          ),
        ],
      ),
    );
  }
}
