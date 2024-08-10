import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterui/screens/routes/route_names.dart';
import 'package:flutterui/shared/logic/navigation/navigation_bloc.dart';
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
        const SideBarItem(title: "Getting Started", link: ""),
        const SideBarItem(title: "PlayGround", link: RouteNames.playground),
      ],
    ),
    SideBarGroupModel(
      title: "Blocks",
      items: [
        const SideBarItem(title: "Buttons", link: RouteNames.buttons),
        const SideBarItem(title: "Inputs", link: RouteNames.inputs),
        const SideBarItem(title: "Chips", link: RouteNames.chips),
      ],
    ),
    SideBarGroupModel(
      title: "Templates",
      items: [
        const SideBarItem(title: "App Clones", link: RouteNames.templates),
        const SideBarItem(title: "Home Screens", link: RouteNames.homeScreens),
        const SideBarItem(title: "Auth Screens", link: RouteNames.authScreens),
        const SideBarItem(title: "Onboarding Screens", link: RouteNames.onboarding),
      ],
    ),
    SideBarGroupModel(
      title: "Animations",
      items: [
        const SideBarItem(title: "Sliders", link: "sliders"),
      ],
    ),
    SideBarGroupModel(
      title: "Effects",
      items: [],
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

  String currentRoute = '/';
  @override
  Widget build(BuildContext context) {
    // final currentRoute = context.router.currentUrl;
    // final currentRoute = ModalRoute.of(context)?.data?.isActive;

    // print(['currentRoute BuildContext', currentRoute]);
    return BlocBuilder<NavigationBloc, NavigationState>(
      builder: (context, state) {
        if (state is NavigationUpdated) {
          currentRoute = context.router.currentUrl;
        }
        // print(["state", state.currentRoute]);
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
                                  return SideBarItem(
                                    title: sideBarItem.title,
                                    onPressed: () {
                                      setState(() => activeSideBar = sideBarItem);
                                      if (sideBarItem.link != null) context.router.pushNamed("/components/${sideBarItem.link}");
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

                                    // final activeRoute = context.router.currentUrl;
                                    // final isActive = currentRoute == "/components/${sideBarItem.link}" || currentRoute == "/components/${activeSideBar?.link}";
                                    final isActive = currentRoute == "/components/${sideBarItem.link}" || currentRoute == "/components/${activeSideBar?.link}";
                                    // print([
                                    //   'isActive',
                                    //   isActive,
                                    //   'sideBarItem',
                                    //   sideBarItem.link,
                                    //   'currentRoute',
                                    //   currentRoute,
                                    // ]);
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
      },
    );
  }
}
