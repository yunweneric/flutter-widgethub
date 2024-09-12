import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterui/app/core/service_locators.dart';
import 'package:flutterui/app/shared/logic/theme/theme_bloc.dart';
import 'package:flutterui/app/shared/presentation/utils/icons.dart';
import 'package:flutterui/app/shared/presentation/utils/sizing.dart';
import 'package:flutterui/app/shared/presentation/utils/util.dart';
import 'package:flutterui/app/shared/presentation/widgets/icon.dart';

class HomeFooter extends StatefulWidget {
  const HomeFooter({super.key});

  @override
  State<HomeFooter> createState() => _HomeFooterState();
}

class _HomeFooterState extends State<HomeFooter> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppSizing.width(context),
      decoration: BoxDecoration(
        border: BorderDirectional(top: BorderSide(color: Theme.of(context).dividerColor)),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 20.h),
            width: AppSizing.kWPercentage(context, 90),
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              alignment: WrapAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: AppSizing.kWPercentage(context, AppSizing.isMobile(context) ? 100 : 40),
                  child: Text(
                    "2024 © Build with 💙 by Yunwen",
                    style: Theme.of(context).textTheme.bodySmall,
                    textAlign: AppSizing.isMobile(context) ? TextAlign.center : TextAlign.left,
                  ),
                ),

                Container(
                  margin: EdgeInsets.only(top: AppSizing.isMobile(context) ? 20 : 0),
                  width: AppSizing.kWPercentage(context, AppSizing.isMobile(context) ? 100 : 40),
                  child: Row(
                    mainAxisAlignment: AppSizing.isMobile(context) ? MainAxisAlignment.center : MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AppSizing.kwSpacer(5.w),
                      TextButton(
                        onPressed: () => UtilHelper.openUrl("https://github.com/yunweneric/"),
                        child: const AppIcon(icon: AppIcons.github),
                      ),
                      AppSizing.kwSpacer(5.w),
                      Builder(
                        builder: (context) {
                          final theme = getIt.get<ThemeBloc>();
                          final isDark = Theme.of(context).brightness == Brightness.dark;
                          return TextButton(
                            onPressed: () => theme.add(
                              ChangeTheme(themeMode: isDark ? ThemeMode.light : ThemeMode.dark),
                            ),
                            child: AppIcon(
                              icon: isDark ? AppIcons.moon : AppIcons.sun,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                )
                // navBar
              ],
            ),
          ),
        ],
      ),
    );
  }
}
