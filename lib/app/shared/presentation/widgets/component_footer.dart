import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterui/app/shared/presentation/utils/icons.dart';
import 'package:flutterui/app/shared/presentation/utils/sizing.dart';
import 'package:flutterui/app/shared/presentation/utils/util.dart';
import 'package:flutterui/app/shared/presentation/widgets/icon.dart';

class ComponentFooter extends StatefulWidget {
  const ComponentFooter({super.key});

  @override
  State<ComponentFooter> createState() => _DetailedFooterState();
}

class _DetailedFooterState extends State<ComponentFooter> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppSizing.kpadding(0, 30.h),
      width: AppSizing.width(context),
      child: Wrap(
        runSpacing: 20,
        crossAxisAlignment: WrapCrossAlignment.center,
        runAlignment: WrapAlignment.spaceBetween,
        alignment: WrapAlignment.spaceBetween,
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: AppSizing.kWPercentage(context, AppSizing.isMobile(context) ? 100 : 35),
            child: Text(
              "Build with 💙 by yunwen",
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: AppSizing.isMobile(context) ? TextAlign.center : TextAlign.left,
            ),
          ),
          SizedBox(
            width: AppSizing.kWPercentage(context, AppSizing.isMobile(context) ? 100 : 35),
            child: Row(
              mainAxisAlignment: AppSizing.isMobile(context) ? MainAxisAlignment.center : MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.transparent,
                  child: TextButton(
                    onPressed: () => UtilHelper.openUrl("https://github.com/yunweneric/"),
                    child: const AppIcon(icon: AppIcons.github),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
