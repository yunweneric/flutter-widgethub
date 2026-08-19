import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterui/app/core/routes/route_names.dart';
import 'package:flutterui/app/core/service_locators.dart';
import 'package:flutterui/app/presentation/home/data/export/sidebar_categories.dart';
import 'package:flutterui/app/presentation/home/widgets/home_footer.dart';
import 'package:flutterui/app/shared/shared.dart';
import 'package:flutterui/components/data/logic/component/component_bloc.dart';
import 'package:go_router/go_router.dart';

/// Root page layout: sticky top nav, scrollable content column and an
/// optional footer. On mobile the navigation lives in a slide-over drawer
/// with a scrim (shadcn docs style).
class AppLayout extends StatefulWidget {
  final bool? hideFooter;
  final bool? isHomeScreenLayout;
  final List<Widget> children;
  final ScrollController? controller;
  const AppLayout({
    super.key,
    required this.children,
    this.hideFooter,
    this.controller,
    this.isHomeScreenLayout,
  });

  @override
  State<AppLayout> createState() => _AppLayoutState();
}

class _AppLayoutState extends State<AppLayout> {
  final sidebarBloc = getIt.get<SidebarBloc>();

  static const Duration _drawerDuration = Duration(milliseconds: 250);

  void _closeDrawer() {
    sidebarBloc.add(UpdateSideBarEvent(newStatus: false));
  }

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    return BlocBuilder<SidebarBloc, SidebarState>(
      builder: (context, state) {
        final bool isMobile = AppSizing.isMobile(context);
        final bool drawerOpen = isMobile && state.isOpen;
        final double drawerWidth =
            AppSizing.width(context) < 360 ? AppSizing.width(context) * 0.9 : 320;

        return Scaffold(
          body: Stack(
            children: [
              // Page: nav + scrollable content.
              Column(
                children: [
                  HomeNavBar(
                    isHomeScreenLayout: widget.isHomeScreenLayout ?? true,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      controller: widget.controller,
                      child: Column(
                        children: [
                          ConstrainedBox(
                            constraints: BoxConstraints(
                              minHeight: AppSizing.kHPercentage(context, 80),
                            ),
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
                  ),
                ],
              ),

              // Scrim.
              IgnorePointer(
                ignoring: !drawerOpen,
                child: AnimatedOpacity(
                  duration: _drawerDuration,
                  opacity: drawerOpen ? 1 : 0,
                  child: GestureDetector(
                    onTap: _closeDrawer,
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      color: Colors.black.withValues(alpha: 0.5),
                    ),
                  ),
                ),
              ),

              // Slide-over drawer.
              AnimatedPositioned(
                duration: _drawerDuration,
                curve: Curves.easeOutCubic,
                top: 0,
                bottom: 0,
                left: drawerOpen ? 0 : -(drawerWidth + 16),
                child: Container(
                  width: drawerWidth,
                  decoration: BoxDecoration(
                    color: tokens.background,
                    border: Border(
                      right: BorderSide(color: tokens.border),
                    ),
                  ),
                  child: SafeArea(
                    child: _DrawerContent(
                      isHomeScreenLayout: widget.isHomeScreenLayout,
                      onClose: _closeDrawer,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

/// Content of the mobile slide-over drawer.
class _DrawerContent extends StatelessWidget {
  final bool? isHomeScreenLayout;
  final VoidCallback onClose;

  const _DrawerContent({
    required this.isHomeScreenLayout,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final componentBloc = getIt.get<ComponentBloc>();
    final themeBloc = getIt.get<ThemeBloc>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final activePath =
        getIt.get<GoRouter>().routeInformationProvider.value.uri.pathSegments;

    final categoriesGroup = [
      ...sideBarCategories.where(
        (item) => item.category != ComponentCategoryEnum.ANIMATIONS,
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header: logo + close.
        Padding(
          padding: const EdgeInsets.fromLTRB(
              AppSpace.lg, AppSpace.md, AppSpace.sm, AppSpace.md),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  onClose();
                  context.go(RouteNames.home);
                },
                child: Image.asset(
                  isDark ? AppImages.logoLight : AppImages.logoDark,
                  width: 90,
                ),
              ),
              AppIconButton(
                onPressed: onClose,
                child: Icon(Icons.close, size: 18, color: tokens.mutedForeground),
              ),
            ],
          ),
        ),
        Container(height: 1, color: tokens.border),

        // Navigation groups.
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
                horizontal: AppSpace.md, vertical: AppSpace.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...categoriesGroup.map((group) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: AppSpace.xl),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: AppSpace.md, bottom: AppSpace.sm),
                          child: Text(
                            group.category.describe().toUpperCase(),
                            style: context.text.overline,
                          ),
                        ),
                        ...group.items.map((category) {
                          return SideBarItem(
                            isActive: activePath
                                .contains(category.subCategory.link()),
                            title: category.subCategory.describe(),
                            onPressed: () {
                              onClose();
                              componentBloc.add(UpdateActiveCategoryEvent(
                                  category: category));
                              context.go(
                                  "/components/${category.category.link()}/${category.subCategory.link()}");
                            },
                          );
                        }),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
        ),

        // Footer: theme switcher.
        Container(height: 1, color: tokens.border),
        Padding(
          padding: const EdgeInsets.all(AppSpace.lg),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                LangUtil.trans("homeFooter", args: {
                  "year": DateTime.now().year.toString(),
                  "community": "Flutter Community",
                }),
                style: context.text.muted.copyWith(fontSize: 11),
              ),
              Row(
                children: [
                  _ThemeModeButton(
                    icon: AppIcons.sun,
                    isActive: !isDark,
                    onTap: () => themeBloc
                        .add(ChangeTheme(themeMode: ThemeMode.light)),
                  ),
                  const SizedBox(width: AppSpace.xs),
                  _ThemeModeButton(
                    icon: AppIcons.moon,
                    isActive: isDark,
                    onTap: () =>
                        themeBloc.add(ChangeTheme(themeMode: ThemeMode.dark)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ThemeModeButton extends StatelessWidget {
  final String icon;
  final bool isActive;
  final VoidCallback onTap;

  const _ThemeModeButton({
    required this.icon,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 32,
        height: 32,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isActive ? tokens.secondary : Colors.transparent,
          borderRadius: AppRadii.smAll,
          border: Border.all(
            color: isActive ? tokens.border : Colors.transparent,
          ),
        ),
        child: AppIcon(
          icon: icon,
          size: 14,
          color:
              isActive ? tokens.foreground : tokens.mutedForeground,
        ),
      ),
    );
  }
}
