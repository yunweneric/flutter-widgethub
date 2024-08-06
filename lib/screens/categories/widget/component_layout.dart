import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterui/components/data/logic/component/component_bloc.dart';
import 'package:flutterui/core/service_locators.dart';
import 'package:flutterui/screens/categories/routes/category_router.dart';
import 'package:flutterui/shared/ui/utils/icons.dart';
import 'package:flutterui/shared/ui/utils/sizing.dart';
import 'package:flutterui/shared/ui/widgets/component_footer.dart';
import 'package:flutterui/shared/ui/widgets/icon.dart';
import 'package:flutterui/shared/ui/widgets/layout/main_content.dart';
import 'package:flutterui/shared/ui/widgets/layout/mobile_nav.dart';
import 'package:flutterui/shared/ui/widgets/layout/nav_bar.dart';
import 'package:flutterui/shared/ui/widgets/layout/side_bar.dart';

@RoutePage()
class ComponentLayoutScreen extends StatefulWidget {
  final List<Widget>? widgets;
  const ComponentLayoutScreen({super.key, this.widgets});

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
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SizedBox(
            height: AppSizing.height(context),
            width: AppSizing.width(context),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                if (!AppSizing.isMobile(context)) const NavBar(),
                if (AppSizing.isMobile(context)) const MobileNav(),
                Expanded(
                  child: Row(
                    children: [
                      AnimatedContainer(
                        duration: duration,
                        decoration: BoxDecoration(
                          border: Border(right: BorderSide(color: Theme.of(context).dividerColor)),
                        ),
                        width: AppSizing.isMobile(context) ? 0 : AppSizing.width(context) * 0.2,
                        child: const SideBar(),
                      ),
                      Expanded(child: AutoRouter()),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
