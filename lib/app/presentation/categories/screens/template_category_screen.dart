/// Screen displaying template components filtered by category.
///
/// Shows template cards for a specific template category with navigation
/// between templates and category information.
library;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterui/app/presentation/categories/widget/component_details_footer.dart';
import 'package:flutterui/app/presentation/categories/widget/template_card.dart';
import 'package:flutterui/app/shared/presentation/theme/app_tokens.dart';
import 'package:flutterui/app/shared/presentation/theme/app_typography.dart';
import 'package:flutterui/app/shared/presentation/utils/lang_util.dart';
import 'package:flutterui/app/shared/presentation/utils/sizing.dart';
import 'package:flutterui/app/shared/presentation/widgets/layout/main_content.dart';
import 'package:flutterui/components/data/logic/component/component_bloc.dart';

/// Screen for displaying templates in a specific category.
///
/// Filters templates by the provided category ID and displays them
/// with navigation controls for moving between templates.
class TemplateCategoryScreen extends StatefulWidget {
  /// Optional template category ID to filter by.
  final String? id;

  /// Creates a template category screen.
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
        final component = state.allComponents
            .where((component) => component.id == widget.id)
            .firstOrNull;
        if (component != null) {
          final activeIndex = state.allComponents.indexOf(component);
          final canPrevious = activeIndex > 0;
          final canNext = activeIndex < state.allComponents.length - 1;
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
                          Text(
                            LangUtil.trans(component.title),
                            style: context.text.h1,
                          ),
                          const SizedBox(height: AppSpace.md),
                          Text(
                            LangUtil.trans(component.description),
                            style: context.text.lead,
                          ),
                          const SizedBox(height: AppSpace.xxl),
                        ],
                      ),
              ),
              Builder(
                builder: (context) {
                  final components = state.allComponents
                      .where((item) => item.id == widget.id)
                      .toList();
                  components.sort((a, b) => b.createdAt.compareTo(a.createdAt));
                  return AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    child: components.isEmpty
                        ? SizedBox(
                            height: AppSizing.kHPercentage(context, 50),
                            child: Center(
                              child:
                                  Text(LangUtil.trans('noItemInThisCategory')),
                            ))
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
                                ...component.codeComponents.map((item) {
                                  return TemplateCard(
                                    component: component,
                                    index:
                                        component.codeComponents.indexOf(item),
                                    width: cardWidth,
                                  );
                                })
                              ],
                            );
                          }),
                  );
                },
              ),
              const Kh20Spacer(),
              const Kh20Spacer(),
              ComponentDetailsFooter(
                canPrevious: canPrevious,
                canNext: canNext,
                context: context,
                activeIndex: activeIndex,
              ),
            ],
          );
        } else {
          return MainContent(
            children: [
              SizedBox(
                height: AppSizing.kHPercentage(context, 60),
                child: Center(
                    child: RichText(
                  text: TextSpan(
                    text: "'${widget.id}' ",
                    style: DefaultTextStyle.of(context)
                        .style
                        .copyWith(color: Theme.of(context).primaryColor),
                    children: <TextSpan>[
                      TextSpan(
                        text: LangUtil.trans('notFoundInCollections'),
                        style: TextStyle(
                            color: Theme.of(context).primaryColorDark),
                      ),
                    ],
                  ),
                )),
              ),
            ],
          );
        }
      },
    );
  }
}
