import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterui/screens/routes/app_router.gr.dart';
import 'package:flutterui/screens/routes/route_names.dart';
import 'package:flutterui/shared/ui/models/sidebar_group_model.dart';
import 'package:flutterui/shared/ui/utils/sizing.dart';
import 'package:flutterui/shared/ui/widgets/layout/side_bar_item.dart';

class SideBar extends StatefulWidget {
  const SideBar({super.key});

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  List<SideBarGroupModel> items = [
    SideBarGroupModel(
      title: "Get started",
      items: [
        const SideBarItem(title: "Getting Started", link: "components"),
        const SideBarItem(title: "PlayGround", link: "components/${RouteNames.playground}"),
      ],
    ),
    SideBarGroupModel(
      title: "Components",
      items: [
        const SideBarItem(title: "Buttons", link: RouteNames.buttons),
        const SideBarItem(title: "Inputs", link: RouteNames.inputs),
        const SideBarItem(title: "Chips", link: RouteNames.chips),
      ],
    ),
    SideBarGroupModel(
      title: "Templates",
      items: [
        const SideBarItem(title: "Social", link: "#"),
        const SideBarItem(title: "Authentication", link: "#"),
        const SideBarItem(title: "App Clones", link: "#"),
        const SideBarItem(title: "Onboarding", link: "#"),
      ],
    ),
    SideBarGroupModel(
      title: "Animations",
      items: [
        const SideBarItem(title: "Buttons", link: "#"),
        const SideBarItem(title: "Inputs", link: "#"),
        const SideBarItem(title: "Chips", link: "#"),
      ],
    ),
    SideBarGroupModel(
      title: "Effects",
      items: [
        const SideBarItem(title: "Buttons", link: "#"),
        const SideBarItem(title: "Inputs", link: "#"),
        const SideBarItem(title: "Chips", link: "#"),
      ],
    ),
  ];

  SideBarItem? activeSideBar;

  @override
  void initState() {
    setState(() {
      activeSideBar = items.first.items.first;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: AppSizing.width(context),
        padding: EdgeInsets.only(left: 40.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppSizing.khSpacer(30.h),
              ...items.map((item) {
                return Container(
                  margin: EdgeInsets.only(bottom: 30.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item.title, style: Theme.of(context).textTheme.displayMedium),
                      AppSizing.khSpacer(15.h),
                      Stack(
                        children: [
                          ListView.builder(
                            itemCount: item.items.length,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              final sideBarItem = item.items[index];
                              // final routePath = item.items[index].title.split(" ").join("-").toLowerCase();
                              return SideBarItem(
                                title: sideBarItem.title,
                                onPressed: () {
                                  setState(() {
                                    activeSideBar = sideBarItem;
                                    // context.router.pushNamed("/components/$routePath");
                                  });
                                  // context.router.pushNamed("/buttons")

                                  final activeRoute = context.router.currentPath;
                                  context.router.pushNamed("/components/${sideBarItem.link}");
                                  print(["activeRoute", activeRoute]);

                                  // context.router.push(ComponentDetailsRoute());
                                },
                              );
                            },
                          ),
                          SizedBox(
                            width: 2.w,
                            child: ListView.builder(
                              itemCount: item.items.length,
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                final sideBarItem = item.items[index];
                                final activeRoute = context.router.currentPath;
                                final isActive = activeRoute == "/components/${sideBarItem.link}";

                                // print(['isActive ${sideBarItem.link}', isActive]);
                                // print(['activeRoute', activeRoute]);
                                return AnimatedContainer(
                                  duration: const Duration(milliseconds: 400),
                                  height: 30.h,
                                  color: isActive ? Theme.of(context).primaryColor : Theme.of(context).dividerColor,
                                  width: 2.w,
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
