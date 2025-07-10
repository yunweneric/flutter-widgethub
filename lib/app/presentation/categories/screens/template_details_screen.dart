import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterui/app/core/service_locators.dart';
import 'package:flutterui/app/presentation/categories/widget/component_details_footer.dart';
import 'package:flutterui/app/presentation/categories/widget/resource_section.dart';
import 'package:flutterui/app/presentation/categories/widget/supported_platforms.dart';
import 'package:flutterui/app/shared/presentation/utils/lang_util.dart';
import 'package:flutterui/app/shared/presentation/utils/sizing.dart';
import 'package:flutterui/app/shared/presentation/widgets/code_highlight.dart';
import 'package:flutterui/app/shared/presentation/widgets/code_preview.dart';
import 'package:flutterui/app/shared/presentation/widgets/layout/main_content.dart';
import 'package:flutterui/components/data/logic/component/component_bloc.dart';
import 'package:go_router/go_router.dart';

class TemplateDetailsScreen extends StatefulWidget {
  final String id;
  final int index;
  const TemplateDetailsScreen({super.key, required this.id, required this.index});

  @override
  State<TemplateDetailsScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<TemplateDetailsScreen> {
  final componentBloc = getIt.get<ComponentBloc>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ComponentBloc, ComponentState>(
      listener: (context, state) {
        if (state is UpdateActiveComponentSuccess) {
          final componentDetails = state.activeComponent;
          final link =
              "/components/${componentDetails.category.link()}/${componentDetails.subcategory.link()}/${componentDetails.id}/";
          context.go(link);
        }
      },
      builder: (context, state) {
        final component = state.allComponents.where((item) => item.id == widget.id).firstOrNull;

        final indexItem = (component != null && widget.index >= 0 && widget.index < component.codeComponents.length)
            ? component.codeComponents[widget.index]
            : null;
        if (indexItem == null) {
          return MainContent(
            children: [
              SizedBox(
                height: AppSizing.kHPercentage(context, 50),
                child: Center(
                  child: Text(
                    LangUtil.trans("Template not found"),
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                ),
              ),
            ],
          );
        }
        if (component != null) {
          final activeIndex = state.allComponents.indexOf(component);
          final canPrevious = activeIndex > 0;
          final canNext = activeIndex < state.allComponents.length - 1;
          return MainContent(
            children: [
              Text(LangUtil.trans(component.title), style: Theme.of(context).textTheme.displayLarge),
              AppSizing.kh10Spacer(),
              Text(LangUtil.trans(component.description), style: Theme.of(context).textTheme.bodyMedium),
              AppSizing.kh20Spacer(),
              Text(LangUtil.trans("Setup"), style: Theme.of(context).textTheme.displayMedium),
              AppSizing.kh10Spacer(),
              AppSizing.kh10Spacer(),
              CodeHighlight(code: component.setup, borderRadius: AppSizing.radiusSm()),
              AppSizing.kh20Spacer(),
              AppSizing.kh10Spacer(),
              SupportPlatformSection(component: component),
              ResourceSection(component: component),
              CodePreview(
                component: component.copyWith(
                  codeComponents: [component.codeComponents[widget.index]],
                ),
              ),
              AppSizing.kh20Spacer(),
              ComponentDetailsFooter(
                canPrevious: canPrevious,
                canNext: canNext,
                context: context,
                activeIndex: activeIndex,
              ),
            ],
          );
        }
        return MainContent(
          children: [
            SizedBox(
              height: AppSizing.kHPercentage(context, 60),
              child: Center(
                  child: RichText(
                text: TextSpan(
                  text: "'${widget.id}' ",
                  style: DefaultTextStyle.of(context).style.copyWith(color: Theme.of(context).primaryColor),
                  children: <TextSpan>[
                    TextSpan(
                      text: LangUtil.trans('notFoundInCollections'),
                      style: TextStyle(color: Theme.of(context).primaryColorDark),
                    ),
                  ],
                ),
              )),
            ),
          ],
        );
      },
    );
  }
}
