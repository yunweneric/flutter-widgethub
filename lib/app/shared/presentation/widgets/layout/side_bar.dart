// import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterui/app/shared/data/enums/sub_component_category_enum.dart';
import 'package:flutterui/app/shared/presentation/utils/util.dart';
import 'package:flutterui/components/data/logic/component/component_bloc.dart';
import 'package:flutterui/app/core/service_locators.dart';
import 'package:flutterui/app/presentation/home/data/export/sidebar_categories.dart';
import 'package:flutterui/app/presentation/home/model/component_block_model.dart';
import 'package:flutterui/app/shared/data/enums/component_category_enum.dart';
import 'package:flutterui/app/shared/logic/sidebar/sidebar_bloc.dart';
import 'package:flutterui/app/shared/presentation/utils/sizing.dart';
import 'package:flutterui/app/shared/presentation/widgets/layout/side_bar_item.dart';
import 'package:go_router/go_router.dart';

class SideBar extends StatefulWidget {
  const SideBar({super.key});

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  List<AppCategoryGroupModel> items = [
    ...sideBarCategories.where((item) {
      final condition = item.category != ComponentCategoryEnum.ANIMATIONS;
      return condition;
    }),
  ];

  AppCategoryModel? activeSideBar;
  final sidebarBloc = getIt.get<SidebarBloc>();
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
          activeCategory = state.activeCategory!.category.link() + state.activeCategory!.subCategory.link();
        }
        final activePath = getIt.get<GoRouter>().routeInformationProvider.value.uri.pathSegments;
        return Scaffold(
          body: Container(
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
                                    isActive: activePath.contains(sideBarItem.subCategory.link()),
                                    title: sideBarItem.subCategory.describe(),
                                    onPressed: () {
                                      if (AppSizing.isMobile(context)) sidebarBloc.add(UpdateSideBarEvent(newStatus: false));
                                      componentBloc.add(UpdateActiveCategoryEvent(category: sideBarItem));
                                      setState(() => activeSideBar = sideBarItem);
                                      if (sideBarItem.subCategory == SubComponentCategoryEnum.REQUEST_A_COMPONENT) {
                                        UtilHelper.openUrl("https://github.com/yunweneric");
                                      } else {
                                        context.go("/components/${sideBarItem.category.link()}/${sideBarItem.subCategory.link()}");
                                      }
                                    },
                                  );
                                },
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
