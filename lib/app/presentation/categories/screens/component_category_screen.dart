/// Screen displaying components filtered by category.
///
/// Shows a grid of component cards filtered by the specified subcategory.
/// Displays component count and handles category-based filtering and sorting.
library;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterui/app/presentation/categories/widget/category_card.dart';
import 'package:flutterui/app/shared/data/models/component.dart';
import 'package:flutterui/app/shared/presentation/theme/app_tokens.dart';
import 'package:flutterui/app/shared/presentation/theme/app_typography.dart';
import 'package:flutterui/app/shared/presentation/utils/lang_util.dart';
import 'package:flutterui/app/shared/presentation/widgets/ui/app_badge.dart';
import 'package:flutterui/app/shared/presentation/utils/sizing.dart';
import 'package:flutterui/app/shared/presentation/utils/util.dart';
import 'package:flutterui/app/shared/presentation/widgets/layout/main_content.dart';
import 'package:flutterui/components/data/logic/component/component_bloc.dart';

/// Screen for displaying components in a specific category.
///
/// Filters and displays components based on the provided subcategory.
/// Shows component count and renders component cards in a grid layout.
class ComponentCategoryScreen extends StatefulWidget {
  /// Optional subcategory ID to filter components by.
  final String? subCategory;

  /// Creates a component category screen.
  const ComponentCategoryScreen({super.key, this.subCategory});

  @override
  State<ComponentCategoryScreen> createState() =>
      _ComponentCategoryScreenState();
}

class _ComponentCategoryScreenState extends State<ComponentCategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ComponentBloc, ComponentState>(
      builder: (context, state) {
        final activeCategory = state.activeCategory;

        List<Component> components = state.allComponents
            .where((item) => item.subcategory.link() == widget.subCategory)
            .toList();
        if (widget.subCategory == null) {
          components = state.allComponents;
        }
        components.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        return MainContent(
          children: [
            AnimatedSwitcher(
              key: ValueKey(activeCategory?.category),
              duration: const Duration(milliseconds: 500),
              child: activeCategory == null
                  ? const SizedBox()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Builder(builder: (context) {
                          final name =
                              LangUtil.trans("${activeCategory.subCategory}");
                          final formatted = name[0].toUpperCase() +
                              name
                                  .split("_")
                                  .join(" ")
                                  .substring(1)
                                  .toLowerCase();
                          final count = components.fold(0, (a, b) {
                            final codeComponentCount = b.codeComponents.length;
                            return a + codeComponentCount;
                          });
                          return Row(
                            children: [
                              Text(formatted, style: context.text.h1),
                              const SizedBox(width: AppSpace.md),
                              AppBadge(
                                label: UtilHelper.formatNumber(count),
                              ),
                            ],
                          );
                        }),
                        const SizedBox(height: AppSpace.xxl),
                      ],
                    ),
            ),
            Builder(
              builder: (context) {
                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  child: components.isEmpty
                      ? SizedBox(
                          height: AppSizing.kHPercentage(context, 50),
                          child: Center(
                            child: Text(
                              LangUtil.trans(
                                "noItemInThis",
                                args: {'subCategory': widget.subCategory ?? ''},
                              ),
                            ),
                          ),
                        )
                      : LayoutBuilder(builder: (context, constraints) {
                          final bool single = AppSizing.isMobile(context);
                          const double gap = AppSpace.xl;
                          final double cardWidth = single
                              ? constraints.maxWidth
                              : (constraints.maxWidth - gap) / 2;
                          return Wrap(
                            spacing: gap,
                            runSpacing: AppSpace.xxl,
                            children: [
                              ...components.map((item) {
                                return CategoryCard(
                                    component: item, width: cardWidth);
                              })
                            ],
                          );
                        }),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
