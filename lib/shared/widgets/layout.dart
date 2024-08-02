import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterui/shared/utils/sizing.dart';
import 'package:flutterui/shared/widgets/nav_bar.dart';

class AppLayout extends StatefulWidget {
  final List<Widget> children;
  const AppLayout({super.key, required this.children});

  @override
  State<AppLayout> createState() => _AppLayoutState();
}

class _AppLayoutState extends State<AppLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: AppSizing.height(context),
        width: AppSizing.width(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const NavBar(),
            Row(
              children: [
                Container(
                  height: AppSizing.height(context) * 0.9,
                  decoration: BoxDecoration(
                    border: Border(right: BorderSide(color: Theme.of(context).dividerColor)),
                  ),
                  width: AppSizing.width(context) * 0.2,
                ),
                Container(
                  height: AppSizing.height(context) * 0.9,
                  padding: AppSizing.kMainPadding(),
                  width: AppSizing.width(context) * 0.8,
                  child: mainContent(),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget mainContent() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [AppSizing.khSpacer(30.h), ...widget.children],
      ),
    );
  }
}
