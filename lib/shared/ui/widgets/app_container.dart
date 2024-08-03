import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterui/shared/ui/utils/sizing.dart';

class AppContainer extends StatefulWidget {
  final Widget child;
  const AppContainer({super.key, required this.child});

  @override
  State<AppContainer> createState() => _AppContainerState();
}

class _AppContainerState extends State<AppContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: AppSizing.height(context) * 0.1,
      padding: EdgeInsets.symmetric(horizontal: AppSizing.width(context) * 0.02, vertical: 15.h),
      width: AppSizing.width(context),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Theme.of(context).dividerColor),
        ),
      ),
      child: widget.child,
    );
  }
}
