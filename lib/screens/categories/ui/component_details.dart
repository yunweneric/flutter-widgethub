import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterui/components/data/logic/component/component_bloc.dart';
import 'package:flutterui/components/ui/export/data.dart';
import 'package:flutterui/core/service_locators.dart';
import 'package:flutterui/shared/ui/utils/icons.dart';
import 'package:flutterui/shared/ui/utils/sizing.dart';
import 'package:flutterui/shared/ui/widgets/code_highlight.dart';
import 'package:flutterui/shared/ui/widgets/code_preview.dart';
import 'package:flutterui/shared/ui/widgets/icon.dart';
import 'package:flutterui/shared/ui/widgets/layout/main_content.dart';

@RoutePage()
class ComponentDetailsScreen extends StatefulWidget {
  final Component component;
  const ComponentDetailsScreen({super.key, required this.component});

  @override
  State<ComponentDetailsScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<ComponentDetailsScreen> {
  final componentBloc = getIt.get<ComponentBloc>();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ComponentBloc, ComponentState>(
      builder: (context, state) {
        final activeIndex = state.allComponents.indexOf(state.activeComponent);
        final canPrevious = activeIndex > 0;
        final canNext = activeIndex < state.allComponents.length - 1;
        final component = state.activeComponent;

        return MainContent(
          children: [
            Text(
              component.title,
              style: Theme.of(context).textTheme.displayLarge,
            ),
            AppSizing.kh10Spacer(),
            Text(
              component.description,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            AppSizing.kh20Spacer(),
            Text(
              "Setup",
              style: Theme.of(context).textTheme.displayMedium,
            ),
            AppSizing.kh10Spacer(),
            CodeHighlight(code: component.setup),
            AppSizing.kh20Spacer(),
            CodePreview(component: component),
            AppSizing.kh20Spacer(),
            Row(
              mainAxisAlignment: canPrevious && canNext
                  ? MainAxisAlignment.spaceBetween
                  : canNext
                      ? MainAxisAlignment.end
                      : MainAxisAlignment.start,
              children: [
                if (canPrevious)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          componentBloc.add(FindNextComponentBloc(isNext: false));
                        },
                        label: Text("Previous"),
                        icon: AppIcon(icon: AppIcons.back),
                      ),
                      AppSizing.kh10Spacer(),
                      Text(state.allComponents[activeIndex - 1].title, style: Theme.of(context).textTheme.displayMedium),
                    ],
                  ),
                if (canNext)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      ElevatedButton.icon(
                        iconAlignment: IconAlignment.end,
                        onPressed: () {
                          componentBloc.add(FindNextComponentBloc(isNext: true));
                        },
                        label: Text("Next"),
                        icon: AppIcon(icon: AppIcons.next),
                      ),
                      AppSizing.kh10Spacer(),
                      Text(state.allComponents[activeIndex + 1].title, style: Theme.of(context).textTheme.displayMedium),
                    ],
                  )
              ],
            )
          ],
        );
      },
    );
  }
}
