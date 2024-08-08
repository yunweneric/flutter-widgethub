import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterui/core/service_locators.dart';
import 'package:flutterui/shared/data/enums/theme.dart';
import 'package:flutterui/shared/logic/theme/theme_bloc.dart';
import 'package:flutterui/shared/ui/utils/icons.dart';
import 'package:flutterui/shared/ui/utils/sizing.dart';
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
              crossAxisAlignment: WrapCrossAlignment.start,
              alignment: WrapAlignment.spaceBetween,
              // runAlignment: WrapAlignment.start,
              children: [
                Text(
                  "2024 © Build with 💙 by Yunwen",
                  style: Theme.of(context).textTheme.bodySmall,
                ),

                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(
                        fixedSize: Size(25.w, 25.w),
                      ),
                      child: AppIcon(
                        icon: AppIcons.linkedIn,
                        color: Theme.of(context).primaryColorDark,
                      ),
                      onPressed: () {},
                    ),
                    AppSizing.kwSpacer(5.w),
                    TextButton(
                      onPressed: () {},
                      child: AppIcon(
                        icon: AppIcons.x,
                        color: Theme.of(context).primaryColorDark,
                      ),
                    ),
                    AppSizing.kwSpacer(5.w),
                    TextButton(
                      onPressed: () {},
                      child: AppIcon(icon: AppIcons.github),
                    ),
                    AppSizing.kwSpacer(5.w),
                    Builder(
                      builder: (context) {
                        final theme = getIt.get<ThemeBloc>();
                        final isDark = Theme.of(context).brightness == Brightness.dark;
                        return TextButton(
                          onPressed: () => theme.add(
                            ChangeTheme(themeMode: isDark ? AppThemeMode.LIGHT : AppThemeMode.DARK),
                          ),
                          child: AppIcon(
                            icon: isDark ? AppIcons.moon : AppIcons.sun,
                            color: Theme.of(context).primaryColorDark,
                          ),
                        );
                      },
                    ),
                  ],
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
