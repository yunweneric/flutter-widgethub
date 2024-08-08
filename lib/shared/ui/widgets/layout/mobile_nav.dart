import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterui/core/service_locators.dart';
import 'package:flutterui/shared/data/enums/theme.dart';
import 'package:flutterui/shared/logic/theme/theme_bloc.dart';
import 'package:flutterui/shared/ui/utils/icons.dart';
import 'package:flutterui/shared/ui/utils/sizing.dart';
import 'package:flutterui/shared/ui/widgets/icon.dart';

class MobileNav extends StatefulWidget {
  const MobileNav({super.key});

  @override
  State<MobileNav> createState() => _MobileNavState();
}

class _MobileNavState extends State<MobileNav> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 20.h,
      width: AppSizing.kWPercentage(context, 80),
      padding: EdgeInsets.symmetric(vertical: 30.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              GestureDetector(
                child: AppIcon(icon: AppIcons.menu, size: 40.w),
                onTap: () {},
              ),
              TextButton(
                child: Text("Logo", style: Theme.of(context).textTheme.displayMedium),
                onPressed: () {},
              ),
            ],
          ),
          Row(
            children: [
              Builder(builder: (context) {
                final theme = getIt.get<ThemeBloc>();
                final isDark = Theme.of(context).brightness == Brightness.dark;
                return TextButton(
                  child: AppIcon(icon: isDark ? AppIcons.moon : AppIcons.sun),
                  onPressed: () => theme.add(
                    ChangeTheme(themeMode: isDark ? AppThemeMode.LIGHT : AppThemeMode.DARK),
                  ),
                );
              }),
              TextButton(onPressed: () {}, child: AppIcon(icon: AppIcons.search)),
            ],
          )
        ],
      ),
    );
  }
}
