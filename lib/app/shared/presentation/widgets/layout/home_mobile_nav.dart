import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterui/app/core/service_locators.dart';
import 'package:flutterui/app/shared/logic/theme/theme_bloc.dart';
import 'package:flutterui/app/shared/presentation/utils/icons.dart';
import 'package:flutterui/app/shared/presentation/utils/sizing.dart';
import 'package:flutterui/app/shared/presentation/widgets/app_search_bar.dart';
import 'package:flutterui/app/shared/presentation/widgets/icon.dart';
import 'package:flutterui/app/shared/presentation/widgets/language_button.dart';

class HomeMobileNav extends StatefulWidget {
  final VoidCallback onTap;
  final bool isHomeScreenLayout;
  const HomeMobileNav(
      {super.key, required this.onTap, required this.isHomeScreenLayout});

  @override
  State<HomeMobileNav> createState() => _HomeMobileNavState();
}

class _HomeMobileNavState extends State<HomeMobileNav> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
          EdgeInsets.symmetric(horizontal: AppSizing.kWPercentage(context, 5)),
      width: AppSizing.kWPercentage(context, 90),
      padding: EdgeInsets.symmetric(vertical: 30.h),
      color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.95),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: widget.onTap,
                child: const AppIcon(icon: AppIcons.menu, size: 35),
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
                    ChangeTheme(
                        themeMode: isDark ? ThemeMode.light : ThemeMode.dark),
                  ),
                );
              }),
                                       const LanguageButton(),
              TextButton(
                  onPressed: () => showSearchModal(context),
                  child: const AppIcon(icon: AppIcons.search)),
            ],
          )
        ],
      ),
    );
  }
}
