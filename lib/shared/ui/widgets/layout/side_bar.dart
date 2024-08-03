import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
        SideBarItem(title: "Getting Started"),
        SideBarItem(title: "PlayGround"),
      ],
    ),
    SideBarGroupModel(
      title: "Components",
      items: [
        SideBarItem(title: "Buttons"),
        SideBarItem(title: "Inputs"),
        SideBarItem(title: "Chips"),
      ],
    ),
    SideBarGroupModel(
      title: "Blocks",
      items: [
        SideBarItem(title: "Banners"),
        SideBarItem(title: "Features"),
        SideBarItem(title: "Footers"),
      ],
    ),
    SideBarGroupModel(
      title: "Animations",
      items: [
        SideBarItem(title: "Buttons"),
        SideBarItem(title: "Inputs"),
        SideBarItem(title: "Chips"),
      ],
    ),
    SideBarGroupModel(
      title: "Effects",
      items: [
        SideBarItem(title: "Buttons"),
        SideBarItem(title: "Inputs"),
        SideBarItem(title: "Chips"),
      ],
    ),
    SideBarGroupModel(
      title: "Animations",
      items: [
        SideBarItem(title: "Buttons"),
        SideBarItem(title: "Inputs"),
        SideBarItem(title: "Chips"),
      ],
    ),
    SideBarGroupModel(
      title: "Animations",
      items: [
        SideBarItem(title: "Buttons"),
        SideBarItem(title: "Inputs"),
        SideBarItem(title: "Chips"),
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
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              final sideBarItem = item.items[index];
                              return SideBarItem(
                                title: sideBarItem.title,
                                onPressed: () => setState(() {
                                  activeSideBar = sideBarItem;
                                }),
                              );
                            },
                          ),
                          SizedBox(
                            width: 2.w,
                            child: ListView.builder(
                              itemCount: item.items.length,
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                final sideBarItem = item.items[index];
                                return AnimatedContainer(
                                  duration: Duration(milliseconds: 400),
                                  height: 30.h,
                                  color: activeSideBar == sideBarItem ? Theme.of(context).primaryColor : Theme.of(context).dividerColor,
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
              }).toList(),
            ],
          ),
        ),
      ),
    );
  }
}
