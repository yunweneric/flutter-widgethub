/// Home screen of the Flutter WidgetHub application.
///
/// Displays the main landing page with hero section, integration information,
/// and assets section. Manages scroll behavior and component data loading.
library;

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutterui/app/shared/shared.dart';
import 'package:flutterui/components/data/logic/component/component_bloc.dart';
import 'package:flutterui/app/core/service_locators.dart';
import 'package:flutterui/app/presentation/home/data/export/sidebar_categories.dart';
import 'package:flutterui/app/presentation/home/model/component_block_model.dart';
import 'package:flutterui/app/presentation/home/widgets/assets_section.dart';
import 'package:flutterui/app/presentation/home/widgets/integration_section.dart';
import 'package:flutterui/app/presentation/home/widgets/hero_section.dart';

/// Main home screen widget.
///
/// Manages the scroll controller and component data loading.
/// Displays hero section, integration section, and assets section.
class HomeScreen extends StatefulWidget {
  /// Creates the home screen.
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  /// Scroll controller for managing scroll position and animations.
  final ScrollController _controller = ScrollController();

  /// Theme bloc instance for theme management.
  final themeBloc = getIt.get<ThemeBloc>();

  /// Component bloc instance for component data management.
  final componentBloc = getIt.get<ComponentBloc>();

  @override
  void initState() {
    _controller.addListener(listenToScroll);
    componentBloc.add(GetAllComponentsEvent());
    super.initState();
  }

  /// Scroll listener callback (currently empty, reserved for future use).
  void listenToScroll() {}

  @override
  void dispose() {
    _controller.removeListener(listenToScroll);

    _controller.dispose();
    super.dispose();
  }

  /// Whether the navigation bar is currently open.
  bool isNavBarOpen = false;

  /// List of category groups to display in the sidebar.
  List<AppCategoryGroupModel> items = [
    AppCategoryGroupModel(
      category: ComponentCategoryEnum.GETTING_STARTED,
      description: LangUtil.trans('homeDescription'),
      items: [
        AppCategoryModel(
          widget: Text(LangUtil.trans(("gettingStarted"))),
          category: ComponentCategoryEnum.GETTING_STARTED,
          subCategory: SubComponentCategoryEnum.GETTING_STARTED,
        ),
        AppCategoryModel(
          widget: Text(LangUtil.trans("gettingStarted")),
          category: ComponentCategoryEnum.GETTING_STARTED,
          subCategory: SubComponentCategoryEnum.REQUEST_A_COMPONENT,
        ),
      ],
    ),
    ...sideBarCategories.where(
      (item) =>
          item.category.describe().toLowerCase() != "animations" ||
          item.category.describe().toLowerCase() != "tabs",
    ),
  ];

  /// Generates a scroll factor based on device type.
  ///
  /// [context] The build context.
  /// Returns a scroll factor multiplier for smooth scrolling animations.
  double generateScrollFactor(BuildContext context) {
    double factor = 1.0;

    if (AppSizing.isMobile(context)) factor = 2.0;
    if (AppSizing.isTablet(context)) factor = 2.0;
    if (AppSizing.isDesktop(context)) factor = 1.8;

    return factor;
  }

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      controller: _controller,
      children: [
        HeroSection(
          onBrowserAll: () {
            _controller.animateTo(
              AppSizing.height(context) * generateScrollFactor(context),
              duration: const Duration(seconds: 1),
              curve: Curves.fastOutSlowIn,
            );
          },
        ),
        const IntegrationSection(),
        const AssetsSection(),
      ],
    );
  }
}
