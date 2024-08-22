// import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterui/components/data/logic/component/component_bloc.dart';
import 'package:flutterui/components/ui/export/component_store.dart';
import 'package:flutterui/screens/categories/widget/category_card.dart';
import 'package:flutterui/shared/ui/utils/sizing.dart';
import 'package:flutterui/shared/ui/widgets/layout/main_content.dart';

// @RoutePage()
class ComponentCategoryScreen extends StatefulWidget {
  final String? category;
  const ComponentCategoryScreen({super.key, this.category});

  @override
  State<ComponentCategoryScreen> createState() => _ComponentCategoryScreenState();
}

class _ComponentCategoryScreenState extends State<ComponentCategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ComponentBloc, ComponentState>(
      builder: (context, state) {
        final activeCategory = state.activeCategory;
        return MainContent(
          children: [
            AnimatedSwitcher(
              key: ValueKey(activeCategory?.category),
              duration: const Duration(milliseconds: 500),
              child: activeCategory == null
                  ? const SizedBox()
                  : Column(
                      children: [
                        Text(activeCategory.category.describe(), style: Theme.of(context).textTheme.displayLarge),
                        AppSizing.kh20Spacer(),
                      ],
                    ),
            ),
            Builder(
              builder: (context) {
                // final components = activeCategory == null || activeCategory.link == RouteNames.home
                //     ? state.allComponents
                //     : state.allComponents.where((item) {
                //         return item.title == activeCategory.title;
                //       });

                List<Component> components = state.allComponents.where((item) => item.category.describe() == widget.category).toList();
                if (widget.category == null) {
                  components = state.allComponents;
                }
                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  child: components.isEmpty
                      ? SizedBox(
                          height: AppSizing.kHPercentage(context, 50),
                          child: Center(child: Text("No Item in this ${widget.category}!")),
                        )
                      : Wrap(
                          alignment: WrapAlignment.spaceBetween,
                          runAlignment: WrapAlignment.spaceBetween,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          spacing: AppSizing.isTablet(context) ? AppSizing.kWPercentage(context, 2) : AppSizing.kWPercentage(context, 5),
                          runSpacing: AppSizing.kWPercentage(context, 5),
                          children: [
                            ...components.map((item) {
                              return CategoryCard(component: item);
                            })
                          ],
                        ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
