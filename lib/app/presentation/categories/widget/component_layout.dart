import 'package:flutter/material.dart';
import 'package:flutterui/components/data/logic/component/component_bloc.dart';
import 'package:flutterui/app/core/service_locators.dart';
import 'package:flutterui/app/shared/presentation/utils/sizing.dart';
import 'package:flutterui/app/shared/presentation/widgets/layout/app_layout.dart';
import 'package:flutterui/app/shared/presentation/widgets/layout/side_bar.dart';

class ComponentLayoutScreen extends StatefulWidget {
  final Widget child;
  const ComponentLayoutScreen({super.key, required this.child});

  @override
  State<ComponentLayoutScreen> createState() => _AppLayoutState();
}

class _AppLayoutState extends State<ComponentLayoutScreen> {
  final duration = const Duration(seconds: 1);

  final componentBloc = getIt.get<ComponentBloc>();
  @override
  void initState() {
    componentBloc.add(GetAllComponentsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      hideFooter: true,
      isHomeScreenLayout: false,
      children: [
        SizedBox(
          width: AppSizing.width(context),
          height: AppSizing.height(context),
          child: Row(
            children: [
              AnimatedContainer(
                duration: duration,
                decoration: BoxDecoration(
                  border: Border(
                      right: BorderSide(color: Theme.of(context).dividerColor)),
                ),
                width: AppSizing.isMobile(context)
                    ? 0
                    : AppSizing.width(context) * 0.2,
                child: const SideBar(),
              ),
              Expanded(child: widget.child),
            ],
          ),
        ),
      ],
    );
  }
}
