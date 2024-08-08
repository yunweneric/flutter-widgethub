import 'package:device_frame/device_frame.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutterui/screens/home/model/component_block_model.dart';
import 'package:flutterui/screens/home/widgets/component_block.dart';
import 'package:flutterui/screens/home/widgets/device_interactive.dart';
import 'package:flutterui/shared/ui/utils/icons.dart';
import 'package:flutterui/shared/ui/utils/images.dart';
import 'package:flutterui/shared/ui/utils/sizing.dart';
import 'package:flutterui/shared/ui/widgets/device_frame.dart';
import 'package:flutterui/shared/ui/widgets/device_section_frame.dart';

class ComponentCTA extends StatefulWidget {
  const ComponentCTA({super.key});

  @override
  State<ComponentCTA> createState() => _ComponentCTAState();
}

class _ComponentCTAState extends State<ComponentCTA> {
  late ComponentBlockModel activeBlock;
  List<ComponentBlockModel> blocks = [
    ComponentBlockModel(
      title: "Components",
      description: "A wide range of pre-built UI components from buttons and sliders to complex forms.",
      widgets: [
        TextField(),
        Text("Hello"),
        Text("Hello"),
        Text("Hello"),
        Text("Hello"),
        Text("Hello"),
        Text("Hello"),
      ],
    ),
    ComponentBlockModel(
      title: "Blocks",
      description: "A collection of reusable layout blocks to help you create consistent and responsive layouts",
      widgets: [],
    ),
    ComponentBlockModel(
      title: "Animations",
      description: "Smooth and captivating animations that can be easily applied to any element.",
      widgets: [],
    ),
    ComponentBlockModel(
      title: "Effects",
      description: "Visual effects ranging from shadows and gradients to more complex transformations",
      widgets: [],
    ),
  ];

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
          AppSizing.isMobile(context) ? AppSizing.khSpacer(100.h) : AppSizing.kh20Spacer(),
          Row(
            children: [
              SvgPicture.asset(AppIcons.diamond),
              AppSizing.kwSpacer(5.w),
              Text(
                "INTEGRATION",
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
            width: AppSizing.kHPercentage(context, 70),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Easy to use UI components",
                  style: Theme.of(context).textTheme.displayLarge!.copyWith(fontSize: 40.sp),
                ),
                AppSizing.kh20Spacer(),
                Text(
                  "Seamlessly integrate a wide range of customizable pre-built UI components to accelerate your development process.",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                AppSizing.kh20Spacer(),
              ],
            ),
          ),
          const DeviceInteractive(),
          AppSizing.khSpacer(100.h),
          Row(
            children: [
              SvgPicture.asset(AppIcons.diamond),
              AppSizing.kwSpacer(5.w),
              Text(
                "ASSETS",
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
                  "Beautifully crafted UI Assets, ready for your next project.",
                  style: Theme.of(context).textTheme.displayLarge!.copyWith(fontSize: 40.sp),
                ),
                AppSizing.kh20Spacer(),
                Text(
                  "Discover the versatile features YuwenUI designed to enhance your app development experience. With a variety of components, blocks, animations, and effects, you can create stunning and functional interfaces effortlessly.",
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
            onPressed: () {},
            icon: Icon(Icons.arrow_forward_rounded),
            label: Text("Browse all assets"),
          ),
          AppSizing.kh20Spacer(),
          Wrap(
            runSpacing: 40.h,
            runAlignment: WrapAlignment.spaceBetween,
            alignment: WrapAlignment.spaceBetween,
            children: [
              if (!AppSizing.isMobile(context))
                Container(
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
                          onTap: () {
                            setState(() => activeBlock = item);
                          },
                          onHover: (status) {
                            // setState(() => activeBlock = item);
                          },
                          child: ComponentBlock(
                            item: item,
                            isActive: activeBlock == item,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              Container(
                // color: Colors.teal,
                width: AppSizing.kWPercentage(context, AppSizing.isTablet(context) ? 70 : 100),
                child: Builder(builder: (context) {
                  List<Widget> allWidgets = blocks.expand((item) => item.widgets).toList();
                  List<Widget> activeWidgets = activeBlock.widgets;
                  final displayWidget = AppSizing.isMobile(context) ? allWidgets : activeWidgets;
                  return Wrap(
                    spacing: AppSizing.kWPercentage(context, 2.5),
                    runSpacing: AppSizing.kWPercentage(context, 2.5),
                    crossAxisAlignment: WrapCrossAlignment.center,
                    alignment: AppSizing.isTablet(context) ? WrapAlignment.end : WrapAlignment.start,
                    runAlignment: WrapAlignment.spaceBetween,
                    children: [
                      ...displayWidget.map(
                        (item) => InkWell(
                          enableFeedback: false,
                          hoverColor: Theme.of(context).scaffoldBackgroundColor,
                          highlightColor: Theme.of(context).scaffoldBackgroundColor,
                          focusColor: Theme.of(context).scaffoldBackgroundColor,
                          splashColor: Theme.of(context).scaffoldBackgroundColor,
                          onTap: () {},
                          child: DeviceSectionFrame(
                            deviceAlignment: Alignment.topCenter,
                            parentWidth: AppSizing.kWPercentage(context, AppSizing.isMobile(context) ? 43 : 20),
                            parentHeight: AppSizing.kWPercentage(context, AppSizing.isMobile(context) ? 35 : 15),
                            childWidth: AppSizing.kWPercentage(context, 10),
                            childHeight: AppSizing.kWPercentage(context, 22),
                            child: Scaffold(
                              body: Center(
                                child: TextFormField(),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  );
                }),
              ),
            ],
          ),
          AppSizing.khSpacer(60),
        ],
      ),
    );
  }
}
