import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterui/app/shared/data/enums/sub_component_category_enum.dart';
import 'package:flutterui/app/shared/presentation/theme/app_tokens.dart';
import 'package:flutterui/app/shared/presentation/theme/app_typography.dart';
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

/// Docs sidebar (desktop) — grouped navigation with uppercase overline
/// section labels, shadcn docs style.
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

  final sidebarBloc = getIt.get<SidebarBloc>();
  final componentBloc = getIt.get<ComponentBloc>();

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    return BlocBuilder<ComponentBloc, ComponentState>(
      builder: (context, state) {
        final activePath = getIt
            .get<GoRouter>()
            .routeInformationProvider
            .value
            .uri
            .pathSegments;

        return Container(
          color: tokens.sidebar,
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(
                AppSpace.lg, AppSpace.xl, AppSpace.md, AppSpace.huge),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...items.map(
                  (item) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: AppSpace.xl),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: AppSpace.md, bottom: AppSpace.sm),
                            child: Text(
                              item.category.describe().toUpperCase(),
                              style: context.text.overline,
                            ),
                          ),
                          ...item.items.map((sideBarItem) {
                            return SideBarItem(
                              isActive: activePath
                                  .contains(sideBarItem.subCategory.link()),
                              title: sideBarItem.subCategory.describe(),
                              onPressed: () {
                                if (AppSizing.isMobile(context)) {
                                  sidebarBloc.add(
                                      UpdateSideBarEvent(newStatus: false));
                                }
                                componentBloc.add(UpdateActiveCategoryEvent(
                                    category: sideBarItem));
                                if (sideBarItem.subCategory ==
                                    SubComponentCategoryEnum
                                        .REQUEST_A_COMPONENT) {
                                  UtilHelper.openUrl(
                                      "https://github.com/yunweneric/flutter-widgethub/issues/new");
                                } else {
                                  context.go(
                                      "/components/${sideBarItem.category.link()}/${sideBarItem.subCategory.link()}");
                                }
                              },
                            );
                          }),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
