import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterui/app/presentation/categories/widget/template_card.dart';
import 'package:flutterui/components/data/logic/component/component_bloc.dart';
import 'package:flutterui/app/shared/presentation/utils/sizing.dart';
import 'package:flutterui/app/shared/presentation/widgets/layout/main_content.dart';

class TemplateCategoryScreen extends StatefulWidget {
  final String? id;
  const TemplateCategoryScreen({super.key, this.id});

  @override
  State<TemplateCategoryScreen> createState() => _TemplateCategoryScreenState();
}

class _TemplateCategoryScreenState extends State<TemplateCategoryScreen> {
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
                        Text(activeCategory.subCategory.describe(), style: Theme.of(context).textTheme.displayLarge),
                        AppSizing.kh20Spacer(),
                      ],
                    ),
            ),
            Builder(
              builder: (context) {
                final components = state.allComponents.where((item) => item.id == widget.id).toList();
                print(["widget.id", widget.id]);
                print(["component", components.length]);
                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  child: components.isEmpty
                      ? SizedBox(
                          height: AppSizing.kHPercentage(context, 50),
                          child: const Center(child: Text("No Item in this category!")),
                        )
                      : Wrap(
                          alignment: WrapAlignment.spaceBetween,
                          runAlignment: WrapAlignment.spaceBetween,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          spacing: AppSizing.isTablet(context) ? AppSizing.kWPercentage(context, 2) : AppSizing.kWPercentage(context, 5),
                          runSpacing: AppSizing.kWPercentage(context, 5),
                          children: [
                            ...components.first.codeComponents.map((item) {
                              return TemplateCard(component: item);
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
