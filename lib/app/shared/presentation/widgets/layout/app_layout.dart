import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterui/app/core/app.dart';
import 'package:flutterui/components/data/logic/component/component_bloc.dart';
import 'package:flutterui/app/core/service_locators.dart';
import 'package:flutterui/app/presentation/home/data/export/sidebar_categories.dart';
import 'package:flutterui/app/presentation/home/model/component_block_model.dart';
import 'package:flutterui/app/presentation/home/widgets/home_footer.dart';
// import 'package:flutterui/screens/routes/app_router.gr.dart';
import 'package:flutterui/app/core/routes/route_names.dart';
import 'package:flutterui/app/shared/data/enums/component_category_enum.dart';
import 'package:flutterui/app/shared/logic/sidebar/sidebar_bloc.dart';
import 'package:flutterui/app/shared/logic/theme/theme_bloc.dart';
import 'package:flutterui/app/shared/presentation/utils/icons.dart';
import 'package:flutterui/app/shared/presentation/utils/images.dart';
import 'package:flutterui/app/shared/presentation/utils/sizing.dart';
import 'package:flutterui/app/shared/presentation/utils/util.dart';
import 'package:flutterui/app/shared/presentation/widgets/icon.dart';
import 'package:flutterui/app/shared/presentation/widgets/layout/home_nav_bar.dart';
import 'package:flutterui/app/shared/presentation/widgets/layout/side_bar_item.dart';
import 'package:go_router/go_router.dart';

class AppLayout extends StatefulWidget {
  final bool? hideFooter;
  final bool? isHomeScreenLayout;
  final List<Widget> children;
  final ScrollController? controller;
  const AppLayout(
      {super.key,
      required this.children,
      this.hideFooter,
      this.controller,
      this.isHomeScreenLayout});

  @override
  State<AppLayout> createState() => _AppLayoutState();
}

class _AppLayoutState extends State<AppLayout>
    with SingleTickerProviderStateMixin {
  AnimationController? animationController;
  Animation<double>? navBarAnimation;
  final themeBloc = getIt.get<ThemeBloc>();
  final componentBloc = getIt.get<ComponentBloc>();
  final sidebarBloc = getIt.get<SidebarBloc>();
  bool isNavBarOpen = false;
  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    navBarAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(animationController!);
    super.initState();
  }

  void animateNavBar() {
    navBarAnimation =
        Tween<double>(begin: 1.0, end: 0.0).animate(animationController!);
    if (isNavBarOpen) {
      animationController?.reverse();
    } else {
      animationController?.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SidebarBloc, SidebarState>(
      listener: (context, state) {
        if (state is SidebarUpdateStatus) {
          isNavBarOpen = state.isOpen;
          animateNavBar();
          // print(['state', state.isOpen]);
          // print(['isNavBarOpen', isNavBarOpen]);
        }
      },
      child: Scaffold(
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
                      ..translate(
                          AppSizing.kWPercentage(context, 120.0 * value)),
                    child: SingleChildScrollView(
                      controller: widget.controller,
                      child: Column(
                        children: [
                          AppSizing.khSpacer(80),
                          ConstrainedBox(
                            constraints: BoxConstraints(
                                minHeight: AppSizing.kHPercentage(context, 80)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: widget.children,
                            ),
                          ),
                          widget.hideFooter == true
                              ? const SizedBox.shrink()
                              : const HomeFooter(),
                        ],
                      ),
                    ),
                  );
                }),
            AnimatedPositioned(
              top: 20,
              left: isNavBarOpen ? 0 : -AppSizing.width(context),
              duration: const Duration(milliseconds: 500),
              child: SizedBox(
                height: AppSizing.height(context),
                width: AppSizing.kWPercentage(context, 100),
                child: SafeArea(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: AppSizing.kHPercentage(context, 2),
                        horizontal: 0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          sideBarComponents(context),
                          AppSizing.kh20Spacer(),
                          Column(
                            children: [
                              navbarSection(child: themingSection(context)),
                              AppSizing.kh20Spacer(),
                              Text(
                                context.tr("homeFooter", args:["Yunwen"] ),
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
            ),
            AnimatedPositioned(
              top: 0,
              left: !isNavBarOpen ? 0 : AppSizing.width(context),
              duration: const Duration(milliseconds: 500),
              child: HomeNavBar(
                isHomeScreenLayout: widget.isHomeScreenLayout ?? true,
                onTap: () {
                  sidebarBloc.add(UpdateSideBarEvent(newStatus: true));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container sideBarComponents(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  child: Theme.of(context).brightness == Brightness.dark
                      ? Image.asset(
                          AppImages.logoLight,
                          width: 100,
                        )
                      : Image.asset(
                          AppImages.logoDark,
                          width: 100,
                        ),
                ),
                onPressed: () {
                  context.go(RouteNames.home);
                },
              ),
              CircleAvatar(
                backgroundColor: Colors.transparent,
                child: TextButton(
                  onPressed: () {
                    sidebarBloc.add(UpdateSideBarEvent(newStatus: false));
                  },
                  child: const Icon(Icons.close),
                ),
              ),
            ],
          ),
          AppSizing.khSpacer(30),
          BlocConsumer<ComponentBloc, ComponentState>(
            listener: (context, state) {},
            builder: (context, state) {
              final activePath = getIt
                  .get<GoRouter>()
                  .routeInformationProvider
                  .value
                  .uri
                  .pathSegments;

              return Builder(builder: (context) {
                List<AppCategoryGroupModel> categoriesGroup = [
                  ...sideBarCategories.where((item) {
                    final condition =
                        item.category != ComponentCategoryEnum.ANIMATIONS;
                    return condition;
                  }),
                ];
                return widget.isHomeScreenLayout == true ||
                        widget.isHomeScreenLayout == null
                    ? Column(
                        children: [
                          ...categoriesGroup.map((categoryGroup) {
                            return navItem(
                              onPressed: () {
                                // animateNavBar();
                                sidebarBloc
                                    .add(UpdateSideBarEvent(newStatus: false));
                                context.go(
                                    "/components/${categoryGroup.category.link()}/${categoryGroup.items.first.subCategory.link()}");
                              },
                              title: categoryGroup.category.describe(),
                            );
                          }),
                        ],
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppSizing.khSpacer(30.h),
                          ...categoriesGroup.map((item) {
                            return Container(
                              margin: EdgeInsets.only(bottom: 30.h),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(item.category.describe(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayMedium),
                                  AppSizing.khSpacer(15.h),
                                  Stack(
                                    children: [
                                      ListView.builder(
                                        itemCount: item.items.length,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemBuilder: (context, index) {
                                          final category = item.items[index];
                                          return SideBarItem(
                                            isActive: activePath.contains(
                                                category.subCategory.link()),
                                            title:
                                                category.subCategory.describe(),
                                            onPressed: () {
                                              sidebarBloc.add(
                                                  UpdateSideBarEvent(
                                                      newStatus: false));
                                              componentBloc.add(
                                                  UpdateActiveCategoryEvent(
                                                      category: category));
                                              context.go(
                                                  "/components/${category.category.link()}/${category.subCategory.link()}");
                                            },
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          }),
                        ],
                      );
              });
            },
          ),
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
                onPressed: () =>
                    themeBloc.add(ChangeTheme(themeMode: ThemeMode.light)),
                icon: AppIcons.sun,
                title: context.tr("light"),
              ),
              navItem(
                onPressed: () =>
                    themeBloc.add(ChangeTheme(themeMode: ThemeMode.dark)),
                icon: AppIcons.moon,
                title: context.tr("dark"),
              ),
              navItem(
                onPressed: () =>
                    themeBloc.add(ChangeTheme(themeMode: ThemeMode.system)),
                icon: AppIcons.desktop,
                title: context.tr("system"),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget navbarSection({required Widget child}) {
    return Container(
      width: AppSizing.width(context),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
      decoration: BoxDecoration(
        border: BorderDirectional(
            top: BorderSide(color: Theme.of(context).dividerColor)),
      ),
      child: child,
    );
  }

  Widget navItem(
      {required String title, String? icon, required VoidCallback onPressed}) {
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
