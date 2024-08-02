import 'package:flutter/material.dart';
import 'package:flutterui/shared/utils/colors.dart';
import 'package:flutterui/shared/utils/sizing.dart';

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
      padding: EdgeInsets.symmetric(horizontal: AppSizing.width(context) * 0.05, vertical: 20),
      width: AppSizing.width(context),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Theme.of(context).highlightColor),
        ),
      ),
      child: widget.child,
    );
  }
}
