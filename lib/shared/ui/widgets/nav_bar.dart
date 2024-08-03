import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterui/core/service_locators.dart';
import 'package:flutterui/shared/data/enums/theme.dart';
import 'package:flutterui/shared/logic/theme/theme_bloc.dart';
import 'package:flutterui/shared/ui/utils/sizing.dart';
import 'package:flutterui/shared/ui/utils/theme.dart';
import 'package:flutterui/shared/ui/widgets/app_container.dart';
import 'package:icons_flutter/icons_flutter.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  @override
  Widget build(BuildContext context) {
    List<String> links = ["Component", "Templates", 'Pricing'];
    List<String> socials = ["Twitter", "LinkedIn"];
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return AppContainer(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  TextButton(
                    child: Text("Logo"),
                    onPressed: () {},
                  ),
                  AppSizing.kwSpacer(50.w),
                  Container(
                    child: Row(
                      children: [
                        ...links.map(
                          (item) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextButton(onPressed: () {}, child: Text(item)),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: 280.w,
                    child: Transform.scale(
                      scale: 0.8,
                      child: TextField(
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 10.w),
                          hintText: "Search component...",
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Icon(AntDesign.search1, size: 20.w, color: Theme.of(context).highlightColor),
                          ),
                          // suffixIcon: Icon(AntDesign.search1, size: 20.w, color: Theme.of(context).highlightColor),
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      fixedSize: Size(25.w, 25.w),
                    ),
                    child: Icon(AntDesign.linkedin_square, size: 20.w),
                    onPressed: () {},
                  ),
                  AppSizing.kwSpacer(5.w),
                  TextButton(
                    onPressed: () {},
                    child: Icon(FontAwesome5Icon.twitter, size: 20.w),
                  ),
                  AppSizing.kwSpacer(5.w),
                  Builder(
                    builder: (context) {
                      final theme = getIt.get<ThemeBloc>();
                      return TextButton(
                        onPressed: () => theme.add(
                          ChangeTheme(themeMode: state.themeMode == AppThemeMode.SYSTEM || state.themeMode == AppThemeMode.DARK ? AppThemeMode.LIGHT : AppThemeMode.DARK),
                        ),
                        child: Icon(
                          state.themeMode == AppThemeMode.DARK ? FontAwesome.moon_o : FontAwesome5.lightbulb,
                          size: 20.w,
                        ),
                      );
                    },
                  ),
                ],
              )
              // navBar
            ],
          ),
        );
      },
    );
  }
}
