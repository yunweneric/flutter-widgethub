import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutterui/components/ui/export/data.dart';
import 'package:flutterui/core/service_locators.dart';
import 'package:flutterui/screens/home/ui/apps/leave_review/home.dart';
import 'package:flutterui/screens/home/ui/apps/theme_toggle/theme_toggle.dart';
import 'package:flutterui/screens/routes/route_names.dart';
import 'package:flutterui/shared/data/enums/theme.dart';
import 'package:flutterui/shared/logic/theme/theme_bloc.dart';
import 'package:flutterui/shared/ui/utils/colors.dart';
import 'package:flutterui/shared/ui/utils/icons.dart';
import 'package:flutterui/shared/ui/utils/images.dart';
import 'package:flutterui/shared/ui/utils/sizing.dart';
import 'package:flutterui/shared/ui/widgets/device_section_frame.dart';
import 'package:flutterui/shared/ui/widgets/icon.dart';

class HeroSection extends StatefulWidget {
  const HeroSection({super.key});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: AppSizing.isMobile(context) ? null : AppSizing.kHPercentage(context, 90),
      width: AppSizing.kWPercentage(context, 100),
      alignment: Alignment.topLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppSizing.kh20Spacer(),
          Row(
            children: [
              Container(
                width: AppSizing.kWPercentage(context, AppSizing.isMobile(context) ? 80 : 40),
                margin: EdgeInsets.only(left: AppSizing.kWPercentage(context, 5)),
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
                    Row(
                      children: [
                        Image.asset(
                          AppImages.flutterColored,
                          width: 90.w,
                          color: Theme.of(context).brightness == Brightness.dark ? Theme.of(context).primaryColorDark : null,
                        ),
                        AppSizing.kwSpacer(20.w),
                        Image.asset(
                          AppImages.dartColored,
                          width: 90.w,
                          color: Theme.of(context).brightness == Brightness.dark ? Theme.of(context).primaryColorDark : null,
                        ),
                      ],
                    ),
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
                            context.router.pushNamed("/${RouteNames.components}");
                          },
                          child: Text(
                            "Get started",
                            style: TextStyle(color: Theme.of(context).primaryColorLight),
                          ),
                        ),
                        AppSizing.kwSpacer(20.w),
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                            side: BorderSide(color: Theme.of(context).dividerColor),
                          ),
                          iconAlignment: IconAlignment.end,
                          onPressed: () {},
                          icon: Icon(Icons.arrow_forward_rounded),
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
                Container(
                  // height: AppSizing.kHPercentage(context, 100),
                  width: AppSizing.kWPercentage(context, 55),
                  // color: Colors.teal,
                  child: StaggeredGrid.count(
                    crossAxisCount: 4,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    children: [
                      StaggeredGridTile.count(
                        crossAxisCellCount: 2,
                        mainAxisCellCount: 1.8,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: AppSizing.radiusMd(),
                          ),
                          child: DeviceSectionFrame(
                            child: Center(child: Text("Hello1")),
                          ),
                        ),
                      ),

                      // StaggeredGridTile.count(
                      //   crossAxisCellCount: 2,
                      //   mainAxisCellCount: 1.8,
                      //   child: Container(
                      //     decoration: BoxDecoration(
                      //       borderRadius: AppSizing.radiusMd(),
                      //       // color: Theme.of(context).primaryColor.withOpacity(0.0),
                      //     ),
                      //     child: DeviceSectionFrame(
                      //       child: Text("Hello"),
                      //       deviceAlignment: Alignment.topCenter,
                      //     ),
                      //   ),
                      // ),
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
                        mainAxisCellCount: 1.8,
                        child: Builder(builder: (context) {
                          return Container(
                            decoration: BoxDecoration(borderRadius: AppSizing.radiusMd()),
                            child: DeviceSectionFrame(
                              child: ThemeToggle(),
                              deviceAlignment: Alignment.topCenter,
                            ),
                          );
                        }),
                      ),
                    ],
                  ),
                ),
            ],
          )
        ],
      ),
    );
  }
}
