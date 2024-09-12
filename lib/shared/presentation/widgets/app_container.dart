import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterui/components/data/logic/component/component_bloc.dart';
import 'package:flutterui/shared/presentation/utils/sizing.dart';

class AppContainer extends StatefulWidget {
  final Widget child;
  final bool isHomeScreenLayout;
  const AppContainer({super.key, required this.child, required this.isHomeScreenLayout});

  @override
  State<AppContainer> createState() => _AppContainerState();
}

class _AppContainerState extends State<AppContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppSizing.kWPercentage(context, widget.isHomeScreenLayout ? 90 : 95),
      margin: EdgeInsets.symmetric(horizontal: AppSizing.kWPercentage(context, widget.isHomeScreenLayout ? 5 : 2.5)),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.95),
        border: Border(
          bottom: BorderSide(color: Theme.of(context).dividerColor),
        ),
      ),
      child: BlocBuilder<ComponentBloc, ComponentState>(
        builder: (context, state) {
          return Builder(builder: (context) {
            return Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 15.h),
                  width: AppSizing.kWPercentage(context, 95),
                  child: widget.child,
                ),
              ],
            );
          });
        },
      ),
    );
  }
}
