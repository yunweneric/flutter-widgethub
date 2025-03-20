import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterui/app/core/service_locators.dart';
import 'package:flutterui/app/shared/presentation/utils/icons.dart';
import 'package:flutterui/app/shared/presentation/utils/lang_util.dart';
import 'package:flutterui/app/shared/presentation/utils/sizing.dart';
import 'package:flutterui/app/shared/presentation/widgets/icon.dart';
import 'package:flutterui/src/data/logic/component/component_bloc.dart';

class ComponentDetailsFooter extends StatelessWidget {
  final bool canPrevious;
  final bool canNext;
  final BuildContext context;
  final int activeIndex;
  const ComponentDetailsFooter({
    super.key,
    required this.canPrevious,
    required this.canNext,
    required this.context,
    required this.activeIndex,
  });

  @override
  Widget build(BuildContext context) {
    final componentBloc = getIt.get<ComponentBloc>();

    return BlocBuilder<ComponentBloc, ComponentState>(
      builder: (context, state) {
        return Row(
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
                      componentBloc.add(FindNextComponentBlocEvent(isNext: false));
                    },
                    label: Text(
                      LangUtil.trans("previous"),
                      style: TextStyle(color: Theme.of(context).highlightColor),
                    ),
                    icon: const AppIcon(icon: AppIcons.back),
                  ),
                  AppSizing.kh10Spacer(),
                  Text(
                    LangUtil.trans(state.allComponents[activeIndex - 1].title),
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                ],
              ),
            if (canNext)
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  ElevatedButton.icon(
                    iconAlignment: IconAlignment.end,
                    onPressed: () {
                      componentBloc.add(FindNextComponentBlocEvent(isNext: true));
                    },
                    label: Text(
                      LangUtil.trans("next"),
                      style: TextStyle(color: Theme.of(context).highlightColor),
                    ),
                    icon: const AppIcon(
                      icon: AppIcons.next,
                    ),
                  ),
                  AppSizing.kh10Spacer(),
                  Text(
                    LangUtil.trans(state.allComponents[activeIndex + 1].title),
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                ],
              )
          ],
        );
      },
    );
  }
}
