// import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutterui/components/data/logic/component/component_bloc.dart';
import 'package:flutterui/core/service_locators.dart';
import 'package:flutterui/screens/home/data/export/sidebar_categories.dart';
import 'package:flutterui/screens/home/model/component_block_model.dart';
import 'package:flutterui/screens/home/widgets/home_footer.dart';
// import 'package:flutterui/screens/routes/app_router.gr.dart';
import 'package:flutterui/screens/routes/route_names.dart';
import 'package:flutterui/shared/logic/theme/theme_bloc.dart';
import 'package:flutterui/shared/ui/utils/icons.dart';
import 'package:flutterui/shared/ui/utils/sizing.dart';
import 'package:flutterui/shared/ui/utils/util.dart';
import 'package:flutterui/shared/ui/widgets/icon.dart';
import 'package:flutterui/shared/ui/widgets/layout/nav_bar.dart';

class AppLayout extends StatefulWidget {
  final bool? hideFooter;
  final List<Widget> children;
  final ScrollController? controller;
  const AppLayout({super.key, required this.children, this.hideFooter, this.controller});

  @override
  State<AppLayout> createState() => _AppLayoutState();
}

class _AppLayoutState extends State<AppLayout> with SingleTickerProviderStateMixin {
  // final ScrollController _controller = ScrollController();
  AnimationController? animationController;
  Animation<double>? navBarAnimation;
  final themeBloc = getIt.get<ThemeBloc>();
  final componentBloc = getIt.get<ComponentBloc>();
  bool isNavBarOpen = false;
  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    navBarAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(animationController!);
    super.initState();
  }

  void animateNavBar() {
    navBarAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(animationController!);
    if (isNavBarOpen) {
      animationController?.reverse();
    } else {
      animationController?.forward();
    }
  }

  List<AppCategoryGroupModel> items = [
    ...sideBarCategories.where((item) => item.category.describe().toLowerCase() != "animations"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AnimatedBuilder(
              animation: animationController!,
              builder: (context, child) {
                final value = navBarAnimation?.value ?? 0.0;
                return Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.01)
                    ..scale(1.0, 1.0, -0.5)
                    ..rotateY(0.2 * value)
                    ..translate(AppSizing.kWPercentage(context, 120.0 * value)),
                  child: SingleChildScrollView(
                    controller: widget.controller,
                    child: Column(
                      children: [
                        NavBar(
                            isHomeScreenLayout: true,
                            onTap: () {
                              setState(() => isNavBarOpen = !isNavBarOpen);
                              animateNavBar();
                            }),
                        ...widget.children,
                        widget.hideFooter == true ? const SizedBox.shrink() : const HomeFooter(),
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
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Logo",
                                    style: Theme.of(context).textTheme.displayMedium,
                                  ),
                                  CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    child: TextButton(
                                      onPressed: () {
                                        setState(() {
                                          isNavBarOpen = false;
                                        });
                                        animateNavBar();
                                      },
                                      child: Icon(Icons.close),
                                    ),
                                  ),
                                ],
                              ),
                              AppSizing.khSpacer(30),
                              ...items.map((item) {
                                return navItem(
                                  onPressed: () {
                                    // componentBloc.add(UpdateActiveCategoryEvent(category: item.items.first));
                                    // context.router.push(ComponentCategoryRoute(category: RouteNames.components));
                                  },
                                  title: item.category.describe(),
                                );
                              }),
                            ],
                          ),
                        ),
                        AppSizing.kh20Spacer(),
                        Column(
                          children: [
                            navbarSection(child: supportSection(context)),
                            navbarSection(child: followUsSection(context)),
                            navbarSection(child: themingSection(context)),
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
                icon: AppIcons.card,
                title: "Donate to support us",
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
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
      decoration: BoxDecoration(
        border: BorderDirectional(top: BorderSide(color: Theme.of(context).dividerColor)),
      ),
      child: child,
    );
  }

  Widget navItem({required String title, String? icon, required VoidCallback onPressed}) {
    return InkWell(
      onTap: () {
        setState(() => isNavBarOpen = false);
        onPressed();
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            if (icon != null) ...[
              AppIcon(icon: icon, size: 20),
              AppSizing.kwSpacer(5),
            ],
            Text(title, style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}
