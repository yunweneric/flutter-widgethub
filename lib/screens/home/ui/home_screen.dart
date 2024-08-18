import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutterui/core/service_locators.dart';
import 'package:flutterui/screens/home/widgets/assets_section.dart';
import 'package:flutterui/screens/home/widgets/integration_section.dart';
import 'package:flutterui/screens/home/widgets/hero_section.dart';
import 'package:flutterui/screens/home/widgets/home_footer.dart';
import 'package:flutterui/shared/data/enums/theme.dart';
import 'package:flutterui/shared/logic/theme/theme_bloc.dart';
import 'package:flutterui/shared/ui/utils/sizing.dart';
import 'package:flutterui/shared/ui/utils/util.dart';
import 'package:flutterui/shared/ui/widgets/icon.dart';
import 'package:flutterui/shared/ui/widgets/layout/nav_bar.dart';

import '../../../shared/ui/utils/icons.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _controller = ScrollController();

  final themeBloc = getIt.get<ThemeBloc>();
  @override
  void initState() {
    _controller.addListener(listenToScroll);
    super.initState();
  }

  void listenToScroll() {}

  @override
  void dispose() {
    _controller.removeListener(listenToScroll);

    _controller.dispose();
    super.dispose();
  }

  bool isNavBarOpen = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          TweenAnimationBuilder(
              duration: const Duration(milliseconds: 500),
              tween: !isNavBarOpen ? Tween<double>(begin: 1.0, end: 0.0) : Tween<double>(begin: 0.0, end: 1.0),
              builder: (context, value, child) {
                return Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.01)
                    ..scale(1.0, 1.0, -0.5)
                    ..rotateY(0.2 * value)
                    ..translate(AppSizing.kWPercentage(context, 120.0 * value)),
                  child: SingleChildScrollView(
                    controller: _controller,
                    child: Column(
                      children: [
                        NavBar(
                          isHomeScreenLayout: true,
                          onTap: () => setState(() {
                            isNavBarOpen = !isNavBarOpen;
                          }),
                        ),
                        HeroSection(
                          onBrowserAll: () {
                            _controller.animateTo(
                              AppSizing.height(context) * 1.8,
                              duration: const Duration(seconds: 1),
                              curve: Curves.fastOutSlowIn,
                            );
                          },
                        ),
                        const IntegrationSection(),
                        const AssetsSection(),
                        const HomeFooter(),
                      ],
                    ),
                  ),
                );
              }),
          AnimatedPositioned(
            top: 0,
            left: isNavBarOpen ? 0 : -AppSizing.width(context),
            duration: const Duration(milliseconds: 500),
            child: SizedBox(
              height: AppSizing.height(context),
              width: AppSizing.kWPercentage(context, 100),
              child: SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: AppSizing.kHPercentage(context, 2), horizontal: 0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Logo"),
                                  CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    child: TextButton(
                                      onPressed: () => setState(() {
                                        isNavBarOpen = false;
                                      }),
                                      child: Icon(Icons.close),
                                    ),
                                  ),
                                ],
                              ),
                              AppSizing.khSpacer(30),
                              navItem(onPressed: () {}, title: "Components"),
                              navItem(onPressed: () {}, title: "Templates"),
                              navItem(onPressed: () {}, title: "Animations"),
                              navItem(onPressed: () {}, title: "Blocs"),
                              navItem(onPressed: () {}, title: "Effects"),
                            ],
                          ),
                        ),
                        AppSizing.kh20Spacer(),
                        Column(
                          children: [
                            navbarSection(child: supportSection(context)),
                            navbarSection(child: followUsSection(context)),
                            navbarSection(
                              child: themingSection(context),
                            ),
                            AppSizing.kh20Spacer(),
                            Text(
                              "Made with 💙 by Yunwen",
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            AppSizing.kh20Spacer(),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Column themingSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Choose Theming",
          style: Theme.of(context).textTheme.displayMedium,
        ),
        AppSizing.kh10Spacer(),
        Padding(
          padding: const EdgeInsets.only(left: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              navItem(
                onPressed: () => themeBloc.add(ChangeTheme(themeMode: ThemeMode.light)),
                icon: AppIcons.sun,
                title: "Light",
              ),
              navItem(
                onPressed: () => themeBloc.add(ChangeTheme(themeMode: ThemeMode.dark)),
                icon: AppIcons.moon,
                title: "Dark",
              ),
              navItem(
                onPressed: () => themeBloc.add(ChangeTheme(themeMode: ThemeMode.system)),
                icon: AppIcons.desktop,
                title: "System",
              ),
            ],
          ),
        ),
      ],
    );
  }

  Column followUsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Follow us",
          style: Theme.of(context).textTheme.displayMedium,
        ),
        AppSizing.kh10Spacer(),
        Padding(
          padding: const EdgeInsets.only(left: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              navItem(
                onPressed: () => UtilHelper.openUrl("https://github.com/yunweneric/"),
                icon: AppIcons.github,
                title: "GitHub",
              ),
              navItem(
                onPressed: () => UtilHelper.openUrl("https://github.com/yunweneric/"),
                icon: AppIcons.linkedIn,
                title: "LinkedIn",
              ),
              navItem(
                onPressed: () => UtilHelper.openUrl("https://github.com/yunweneric/"),
                icon: AppIcons.x,
                title: "X",
              ),
            ],
          ),
        )
      ],
    );
  }

  Column supportSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Support us",
          style: Theme.of(context).textTheme.displayMedium,
        ),
        AppSizing.kh10Spacer(),
        Padding(
          padding: const EdgeInsets.only(left: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              navItem(
                onPressed: () => UtilHelper.openUrl("https://github.com/yunweneric/"),
                icon: AppIcons.github,
                title: "Donate to suppor us",
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget navbarSection({required Widget child}) {
    return Container(
      width: AppSizing.width(context),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      decoration: BoxDecoration(
        border: BorderDirectional(top: BorderSide(color: Theme.of(context).dividerColor)),
      ),
      child: child,
    );
  }

  Widget navItem({required String title, String? icon, required VoidCallback onPressed}) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            if (icon != null) ...[
              AppIcon(icon: icon, size: 15),
              AppSizing.kwSpacer(5),
            ],
            Text(title, style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
      ),
    );
  }
}
