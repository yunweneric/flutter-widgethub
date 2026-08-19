import 'package:flutter/material.dart';
import 'package:flutterui/components/data/logic/component/component_bloc.dart';
import 'package:flutterui/app/core/service_locators.dart';
import 'package:flutterui/app/shared/presentation/theme/app_tokens.dart';
import 'package:flutterui/app/shared/presentation/utils/sizing.dart';
import 'package:flutterui/app/shared/presentation/widgets/layout/app_layout.dart';
import 'package:flutterui/app/shared/presentation/widgets/layout/side_bar.dart';

/// Docs shell: fixed-width sidebar on the left, content on the right.
class ComponentLayoutScreen extends StatefulWidget {
  final Widget child;
  const ComponentLayoutScreen({super.key, required this.child});

  @override
  State<ComponentLayoutScreen> createState() => _AppLayoutState();
}

class _AppLayoutState extends State<ComponentLayoutScreen> {
  static const double _sidebarWidth = 260;

  final componentBloc = getIt.get<ComponentBloc>();

  @override
  void initState() {
    componentBloc.add(GetAllComponentsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final bool isMobile = AppSizing.isMobile(context);

    return AppLayout(
      hideFooter: true,
      isHomeScreenLayout: false,
      children: [
        SizedBox(
          width: AppSizing.width(context),
          // Fill the viewport under the 64px nav.
          height: AppSizing.height(context) - (isMobile ? 56 : 64),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!isMobile)
                Container(
                  width: _sidebarWidth,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    border: Border(
                      right: BorderSide(color: tokens.border),
                    ),
                  ),
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
