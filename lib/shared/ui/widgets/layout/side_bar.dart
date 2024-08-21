// import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterui/components/data/logic/component/component_bloc.dart';
import 'package:flutterui/core/service_locators.dart';
import 'package:flutterui/screens/home/data/export/block_items.dart';
import 'package:flutterui/screens/home/model/component_block_model.dart';
// import 'package:flutterui/screens/routes/app_router.gr.dart';
import 'package:flutterui/screens/routes/route_names.dart';
import 'package:flutterui/shared/data/enums/component_category_enum.dart';
import 'package:flutterui/shared/data/enums/sub_component_category_enum.dart';
import 'package:flutterui/shared/ui/utils/sizing.dart';
import 'package:flutterui/shared/ui/widgets/layout/side_bar_item.dart';
import 'package:go_router/go_router.dart';

class SideBar extends StatefulWidget {
  const SideBar({super.key});

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  List<AppCategoryGroupModel> items = [
    ...blocItems.where((item) {
      final condition = item.category != ComponentCategoryEnum.ANIMATIONS;
      return condition;
    }),
  ];

  AppCategoryModel? activeSideBar;

  @override
  void initState() {
    setState(() {
      activeSideBar = items.first.items.first;
    });
    super.initState();
  }

  String activeCategory = '';
  final componentBloc = getIt.get<ComponentBloc>();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ComponentBloc, ComponentState>(
      builder: (context, state) {
        if (state is UpdateActiveCategorySuccess) {
          activeCategory = state.activeCategory!.link;
        }
        return Scaffold(
          body: Container(
            // width: AppSizing.width(context),
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
                          Text(item.category.describe(), style: Theme.of(context).textTheme.displayMedium),
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
                                    title: sideBarItem.subCategory.describe(),
                                    onPressed: () {
                                      componentBloc.add(UpdateActiveCategoryEvent(category: sideBarItem));
                                      setState(() => activeSideBar = sideBarItem);
                                      context.go(sideBarItem.link);
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
                                    final activePath = getIt.get<GoRouter>().routeInformationProvider.value.uri.path;
                                    // final isActive = activeCategory == sideBarItem.link;

                                    print(["activePath", activePath, "sideBarItem", sideBarItem.link]);
                                    final isActive = sideBarItem.link.contains(activePath);
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
