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
      width: AppSizing.kWPercentage(context, 100),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Theme.of(context).dividerColor),
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 15.h),
            width: AppSizing.kWPercentage(context, 90),
            child: widget.child,
          ),
        ],
      ),
    );
  }
}
