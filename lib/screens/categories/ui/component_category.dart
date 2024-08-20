// import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterui/components/data/logic/component/component_bloc.dart';
import 'package:flutterui/screens/categories/widget/category_card.dart';
import 'package:flutterui/screens/routes/route_names.dart';
import 'package:flutterui/shared/ui/utils/sizing.dart';
import 'package:flutterui/shared/ui/widgets/layout/main_content.dart';

// @RoutePage()
class ComponentCategoryScreen extends StatefulWidget {
  final String category;
  const ComponentCategoryScreen({super.key, required this.category});

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
              key: ValueKey(activeCategory?.title),
              duration: const Duration(milliseconds: 500),
              child: activeCategory == null
                  ? const SizedBox()
                  : Column(
                      children: [
                        Text(activeCategory.title, style: Theme.of(context).textTheme.displayLarge),
                        AppSizing.kh20Spacer(),
                        // Text(activeCategory),
                      ],
                    ),
            ),
            Builder(
              builder: (context) {
                final components = activeCategory == null || activeCategory.link == RouteNames.home
                    ? state.allComponents
                    : state.allComponents.where((item) {
                        return item.title == activeCategory.title;
                      });
                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  child: components.isEmpty
                      ? SizedBox(
                          height: AppSizing.kHPercentage(context, 50),
                          child: Center(child: Text("No Item in this ${activeCategory?.title}!")),
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
