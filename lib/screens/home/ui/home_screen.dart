// import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutterui/components/data/logic/component/component_bloc.dart';
import 'package:flutterui/core/service_locators.dart';
import 'package:flutterui/screens/home/data/export/block_items.dart';
import 'package:flutterui/screens/home/model/component_block_model.dart';
import 'package:flutterui/screens/home/widgets/assets_section.dart';
import 'package:flutterui/screens/home/widgets/integration_section.dart';
import 'package:flutterui/screens/home/widgets/hero_section.dart';
import 'package:flutterui/screens/routes/route_names.dart';
import 'package:flutterui/shared/data/enums/component_category_enum.dart';
import 'package:flutterui/shared/data/enums/sub_component_category_enum.dart';
import 'package:flutterui/shared/logic/theme/theme_bloc.dart';
import 'package:flutterui/shared/ui/utils/sizing.dart';
import 'package:flutterui/shared/ui/widgets/layout/app_layout.dart';

// @RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _controller = ScrollController();

  final themeBloc = getIt.get<ThemeBloc>();
  final componentBloc = getIt.get<ComponentBloc>();
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

  List<AppCategoryGroupModel> items = [
    AppCategoryGroupModel(
      category: ComponentCategoryEnum.GETTING_STARTED,
      description: "A wide range of pre-built UI templates from app clones to demo apps all in one place",
      items: [
        AppCategoryModel(
          link: RouteNames.home,
          widget: const Text(""),
          category: ComponentCategoryEnum.GETTING_STARTED,
          subCategory: SubComponentCategoryEnum.GETTING_STARTED,
        ),
        AppCategoryModel(
          link: RouteNames.requestComponent,
          widget: const Text(""),
          category: ComponentCategoryEnum.GETTING_STARTED,
          subCategory: SubComponentCategoryEnum.REQUEST_A_COMPONENT,
        ),
      ],
    ),
    ...blocItems.where((item) => item.category.describe().toLowerCase() != "animations"),
  ];
  @override
  Widget build(BuildContext context) {
    return AppLayout(
      controller: _controller,
      children: [
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
      ],
    );
  }
}
