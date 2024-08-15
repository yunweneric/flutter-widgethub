import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterui/core/service_locators.dart';
import 'package:flutterui/shared/data/enums/theme.dart';
import 'package:flutterui/shared/logic/theme/theme_bloc.dart';
import 'package:flutterui/shared/ui/utils/icons.dart';
import 'package:flutterui/shared/ui/utils/sizing.dart';
import 'package:flutterui/shared/ui/utils/util.dart';
import 'package:flutterui/shared/ui/widgets/icon.dart';

class HomeFooter extends StatefulWidget {
  const HomeFooter({super.key});

  @override
  State<HomeFooter> createState() => _HomeFooterState();
}

class _HomeFooterState extends State<HomeFooter> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Divider(color: Theme.of(context).dividerColor),
          Container(
            padding: EdgeInsets.symmetric(vertical: 20.h),
            width: AppSizing.kWPercentage(context, 90),
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              alignment: WrapAlignment.spaceBetween,
              children: [
                Container(
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
                      CircleAvatar(
                        backgroundColor: Colors.transparent,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            fixedSize: Size(25.w, 25.w),
                          ),
                          child: const AppIcon(
                            icon: AppIcons.linkedIn,
                          ),
                          onPressed: () => UtilHelper.openUrl("https://www.linkedin.com/in/yunweneric"),
                        ),
                      ),
                      AppSizing.kwSpacer(5.w),
                      CircleAvatar(
                        backgroundColor: Colors.transparent,
                        child: TextButton(
                          onPressed: () => UtilHelper.openUrl("https://twitter.com/yunweneric"),
                          child: const AppIcon(
                            icon: AppIcons.x,
                          ),
                        ),
                      ),
                      AppSizing.kwSpacer(5.w),
                      CircleAvatar(
                        backgroundColor: Colors.transparent,
                        child: TextButton(
                          onPressed: () => UtilHelper.openUrl("https://github.com/yunweneric/"),
                          child: const AppIcon(icon: AppIcons.github),
                        ),
                      ),
                      AppSizing.kwSpacer(5.w),
                      Builder(
                        builder: (context) {
                          final theme = getIt.get<ThemeBloc>();
                          final isDark = Theme.of(context).brightness == Brightness.dark;
                          return CircleAvatar(
                            backgroundColor: Colors.transparent,
                            child: TextButton(
                              onPressed: () => theme.add(
                                ChangeTheme(themeMode: isDark ? AppThemeMode.LIGHT : AppThemeMode.DARK),
                              ),
                              child: AppIcon(
                                icon: isDark ? AppIcons.moon : AppIcons.sun,
                              ),
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
