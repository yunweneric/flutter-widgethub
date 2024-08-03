import 'package:flutter/material.dart';
import 'package:flutterui/shared/ui/utils/sizing.dart';
import 'package:flutterui/shared/ui/widgets/layout/main_content.dart';
import 'package:flutterui/shared/ui/widgets/layout/mobile_nav.dart';
import 'package:flutterui/shared/ui/widgets/layout/nav_bar.dart';
import 'package:flutterui/shared/ui/widgets/layout/side_bar.dart';

class AppLayout extends StatefulWidget {
  final List<Widget> children;
  const AppLayout({super.key, required this.children});

  @override
  State<AppLayout> createState() => _AppLayoutState();
}

class _AppLayoutState extends State<AppLayout> {
  final duration = const Duration(seconds: 1);
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
                      AnimatedContainer(
                        duration: duration,
                        width: AppSizing.isMobile(context) ? AppSizing.width(context) : AppSizing.width(context) * 0.8,
                        child: MainContent(children: widget.children),
                      )
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
