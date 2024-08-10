import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutterui/screens/home/data/block_items.dart';
import 'package:flutterui/screens/home/model/component_block_model.dart';
import 'package:flutterui/screens/home/widgets/component_block.dart';
import 'package:flutterui/screens/routes/app_router.gr.dart';
import 'package:flutterui/shared/ui/utils/icons.dart';
import 'package:flutterui/shared/ui/utils/sizing.dart';
import 'package:flutterui/shared/ui/widgets/device_section_frame.dart';

class AssetsSection extends StatefulWidget {
  const AssetsSection({super.key});

  @override
  State<AssetsSection> createState() => _AssetsSectionState();
}

class _AssetsSectionState extends State<AssetsSection> {
  late ComponentBlockModel activeBlock;
  List<ComponentBlockModel> blocks = blocItems;

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
            icon: const Icon(Icons.arrow_forward_rounded),
            label: const Text("Browse all assets"),
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
              Builder(
                builder: (context) {
                  List<BlocItem> allBlockItems = blocks.expand((item) => item.items).toList();
                  List<BlocItem> activeBlockItem = activeBlock.items;
                  final displayWidget = AppSizing.isMobile(context) ? allBlockItems : activeBlockItem;
                  return Container(
                    alignment: Alignment.topLeft,
                    constraints: BoxConstraints(minHeight: AppSizing.kHPercentage(context, 25)),
                    width: AppSizing.kWPercentage(context, AppSizing.isTablet(context) ? 70 : 100),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 1500),
                      key: ValueKey(activeBlock),
                      child: Wrap(
                        spacing: AppSizing.kWPercentage(context, 2.5),
                        runSpacing: AppSizing.kWPercentage(context, 2.5),
                        crossAxisAlignment: WrapCrossAlignment.center,
                        alignment: AppSizing.isTablet(context) ? WrapAlignment.end : WrapAlignment.start,
                        runAlignment: WrapAlignment.start,
                        children: List.generate(
                          displayWidget.length,
                          (index) {
                            return Builder(builder: (context) {
                              List<String> icons = [
                                "assets/icons/linkedin.svg",
                                "assets/icons/tiktok.svg",
                                "assets/icons/linkedin.svg",
                                "assets/icons/youtube.svg",
                                "assets/icons/spotify.svg",
                              ];
                              final item = displayWidget[index];
                              return InkWell(
                                enableFeedback: false,
                                hoverColor: Theme.of(context).scaffoldBackgroundColor,
                                highlightColor: Theme.of(context).scaffoldBackgroundColor,
                                focusColor: Theme.of(context).scaffoldBackgroundColor,
                                splashColor: Theme.of(context).scaffoldBackgroundColor,
                                onTap: () {
                                  context.router.pushNamed("/components/${item.link}");
                                  // context.router.push(ComponentLayoutRoute());
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    DeviceSectionFrame(
                                      deviceAlignment: item.alignment,
                                      parentWidth: AppSizing.kWPercentage(context, AppSizing.isMobile(context) ? 43 : 20),
                                      parentHeight: AppSizing.kWPercentage(context, AppSizing.isMobile(context) ? 35 : 15),
                                      childWidth: AppSizing.kWPercentage(context, 10),
                                      childHeight: AppSizing.kWPercentage(context, 22),
                                      child: item.widget,
                                    ),
                                    AppSizing.kh20Spacer(),
                                    Text(item.title)
                                  ],
                                ),
                              );
                            });
                          },
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
}
