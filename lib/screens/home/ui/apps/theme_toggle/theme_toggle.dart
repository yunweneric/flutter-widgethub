import 'package:flutter/material.dart';
import 'package:flutterui/core/service_locators.dart';
import 'package:flutterui/shared/data/enums/theme.dart';
import 'package:flutterui/shared/logic/theme/theme_bloc.dart';
import 'package:flutterui/shared/ui/utils/icons.dart';
import 'package:flutterui/shared/ui/utils/sizing.dart';
import 'package:flutterui/shared/ui/widgets/icon.dart';

class ThemeToggle extends StatefulWidget {
  const ThemeToggle({super.key});

  @override
  State<ThemeToggle> createState() => _ThemeToggleState();
}

class _ThemeToggleState extends State<ThemeToggle> {
  final theme = getIt.get<ThemeBloc>();
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final width = AppSizing.kWPercentage(context, 35);
    return Scaffold(
      body: Container(
        height: AppSizing.kHPercentage(context, 50),
        width: AppSizing.width(context),
        alignment: Alignment.topLeft,
        child: Center(
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              AnimatedPositioned(
                top: 0,
                bottom: 0,
                left: !isDark ? 0 : width * 0.55,
                duration: Duration(milliseconds: 500),
                child: CircleAvatar(
                  radius: 30,
                  backgroundColor: Theme.of(context).dividerColor,
                  child: CircleAvatar(
                    radius: 28,
                    backgroundColor: Theme.of(context).cardColor,
                  ),
                ),
              ),
              Container(
                width: width,
                height: 60,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                decoration: BoxDecoration(
                  border: Border.all(color: Theme.of(context).disabledColor),
                  borderRadius: BorderRadius.circular(80),
                ),
                child: Row(
                  // mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () => theme.add(ChangeTheme(themeMode: AppThemeMode.LIGHT)),
                      child: Transform.scale(scale: 1.5, child: AppIcon(icon: AppIcons.sun)),
                    ),
                    InkWell(
                      onTap: () => theme.add(ChangeTheme(themeMode: AppThemeMode.DARK)),
                      child: Transform.scale(scale: 1.5, child: AppIcon(icon: AppIcons.moon)),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 100,
                left: 0,
                right: 0,
                child: Text(
                  "Try to toggle!",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
