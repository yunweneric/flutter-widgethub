import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterui/core/service_locators.dart';
import 'package:flutterui/shared/data/enums/theme.dart';
import 'package:flutterui/shared/logic/theme/theme_bloc.dart';
import 'package:flutterui/shared/ui/utils/icons.dart';
import 'package:flutterui/shared/ui/utils/sizing.dart';
import 'package:flutterui/shared/ui/widgets/app_search_bar.dart';
import 'package:flutterui/shared/ui/widgets/icon.dart';

class MobileNav extends StatefulWidget {
  final VoidCallback onTap;
  const MobileNav({super.key, required this.onTap});

  @override
  State<MobileNav> createState() => _MobileNavState();
}

class _MobileNavState extends State<MobileNav> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppSizing.kWPercentage(context, 90),
      padding: EdgeInsets.symmetric(vertical: 30.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              GestureDetector(
                child: AppIcon(icon: AppIcons.menu, size: 35.w),
                onTap: widget.onTap,
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
                return CircleAvatar(
                  backgroundColor: Colors.transparent,
                  child: TextButton(
                    child: AppIcon(icon: isDark ? AppIcons.moon : AppIcons.sun),
                    onPressed: () => theme.add(
                      ChangeTheme(themeMode: isDark ? ThemeMode.light : ThemeMode.dark),
                    ),
                  ),
                );
              }),
              CircleAvatar(
                backgroundColor: Colors.transparent,
                child: TextButton(onPressed: () => showSearchModal(context), child: const AppIcon(icon: AppIcons.search)),
              ),
            ],
          )
        ],
      ),
    );
  }
}
