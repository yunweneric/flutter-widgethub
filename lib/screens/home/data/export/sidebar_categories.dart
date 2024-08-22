import 'package:flutter/material.dart';
import 'package:flutterui/screens/home/data/blocks/bottom_nav_bars_bloc_item.dart';
import 'package:flutterui/screens/home/data/blocks/buttons_bloc_item.dart';
import 'package:flutterui/screens/home/data/blocks/carousels_bloc_item.dart';
import 'package:flutterui/screens/home/data/blocks/drawers_bloc_item.dart';
import 'package:flutterui/screens/home/data/blocks/inputs_bloc_item.dart';
import 'package:flutterui/screens/home/data/blocks/loaders_bloc_item.dart';
import 'package:flutterui/screens/home/data/blocks/switchers_bloc_item.dart';
import 'package:flutterui/screens/home/data/blocks/text_bloc_item.dart';
import 'package:flutterui/screens/home/data/effects/gradient_effects_bloc_item.dart';
import 'package:flutterui/screens/home/data/templates/app_clone_bloc_item.dart';
import 'package:flutterui/screens/home/data/templates/auth_bloc_item.dart';
import 'package:flutterui/screens/home/data/templates/bottom_bar.dart';
import 'package:flutterui/screens/home/data/templates/home_screen_bloc_item.dart';
import 'package:flutterui/screens/home/model/component_block_model.dart';
import 'package:flutterui/screens/routes/route_names.dart';
import 'package:flutterui/shared/data/enums/component_category_enum.dart';
import 'package:flutterui/shared/data/enums/sub_component_category_enum.dart';

final sideBarCategories = [
  AppCategoryGroupModel(
    category: ComponentCategoryEnum.GETTING_STARTED,
    description: "A wide range of pre-built UI templates from app clones to demo apps all in one place",
    items: [
      AppCategoryModel(
        link: RouteNames.gettingStarted,
        widget: const Text(""),
        subCategory: SubComponentCategoryEnum.GETTING_STARTED,
        category: ComponentCategoryEnum.GETTING_STARTED,
      ),
      AppCategoryModel(
        link: RouteNames.requestComponent,
        widget: const Text(""),
        subCategory: SubComponentCategoryEnum.REQUEST_A_COMPONENT,
        category: ComponentCategoryEnum.GETTING_STARTED,
      ),
    ],
  ),
  AppCategoryGroupModel(
    category: ComponentCategoryEnum.TEMPLATES,
    description: "A wide range of pre-built UI templates from app clones to demo apps all in one place",
    items: [
      AppCategoryModel(
        link: RouteNames.clones,
        widget: const AppCloneBlocItem(),
        subCategory: SubComponentCategoryEnum.APP_CLONES,
        category: ComponentCategoryEnum.TEMPLATES,
        alignment: Alignment.topCenter,
      ),
      AppCategoryModel(
        link: RouteNames.onboarding,
        widget: const BottomBarBlocItem(),
        subCategory: SubComponentCategoryEnum.ONBOARDINGS_SCREENS,
        category: ComponentCategoryEnum.TEMPLATES,
      ),
      AppCategoryModel(
        link: RouteNames.homeScreens,
        widget: const HomeScreenBlocItem(),
        subCategory: SubComponentCategoryEnum.HOME_SCREENS,
        category: ComponentCategoryEnum.TEMPLATES,
        alignment: Alignment.topCenter,
      ),
      AppCategoryModel(
        link: RouteNames.authScreens,
        widget: const AuthBlocItem(),
        subCategory: SubComponentCategoryEnum.AUTHENTICATION_SCREENS,
        category: ComponentCategoryEnum.TEMPLATES,
      ),
    ],
  ),
  AppCategoryGroupModel(
    category: ComponentCategoryEnum.BLOCKS,
    description: "A collection of reusable layout blocks to help you create consistent and responsive layouts",
    items: [
      AppCategoryModel(
        link: RouteNames.switchers,
        widget: const SwitchersBlocItem(),
        subCategory: SubComponentCategoryEnum.SWITCHERS,
        category: ComponentCategoryEnum.BLOCKS,
        alignment: Alignment.topCenter,
      ),
      AppCategoryModel(
        link: RouteNames.inputs,
        widget: const InputsBlocItem(),
        subCategory: SubComponentCategoryEnum.INPUT,
        category: ComponentCategoryEnum.BLOCKS,
        alignment: Alignment.center,
      ),
      AppCategoryModel(
        link: RouteNames.text,
        widget: const TextBlocItem(),
        subCategory: SubComponentCategoryEnum.TEXT,
        category: ComponentCategoryEnum.BLOCKS,
      ),
      AppCategoryModel(
        link: RouteNames.sliders,
        widget: const LoadersBlocItem(),
        subCategory: SubComponentCategoryEnum.SWITCHERS,
        category: ComponentCategoryEnum.BLOCKS,
        alignment: Alignment.topCenter,
      ),
      AppCategoryModel(
        link: RouteNames.buttons,
        widget: const ButtonsBlocItem(),
        subCategory: SubComponentCategoryEnum.BUTTONS,
        category: ComponentCategoryEnum.BLOCKS,
        alignment: Alignment.center,
      ),
      AppCategoryModel(
        link: RouteNames.bottomBars,
        widget: const BottomNavBarsBlocItem(),
        subCategory: SubComponentCategoryEnum.BOTTOM_NAV_BARS,
        category: ComponentCategoryEnum.BLOCKS,
      ),
      AppCategoryModel(
        link: RouteNames.drawers,
        widget: const DrawersBlocItem(),
        subCategory: SubComponentCategoryEnum.DRAWERS,
        category: ComponentCategoryEnum.BLOCKS,
        alignment: Alignment.topCenter,
      ),
      AppCategoryModel(
        link: RouteNames.carousels,
        widget: const CarouselsBlocItem(),
        subCategory: SubComponentCategoryEnum.SLIDERS_AND_CAROUSELS,
        category: ComponentCategoryEnum.BLOCKS,
      ),
    ],
  ),
  AppCategoryGroupModel(
    category: ComponentCategoryEnum.ANIMATIONS,
    description: "Smooth and captivating animations that can be easily applied to any element.",
    items: [
      // AppCategoryModel(
      //   link: RouteNames.hoverAnimations,
      //   widget: Text("Hello"),
      //   category: "Hover Animations",
      // ),
      // AppCategoryModel(
      //   link: RouteNames.skewAnimations,
      //   widget: Text("Hello"),
      //   category: "Skew Animations",
      // ),
      // AppCategoryModel(
      //   link: RouteNames.rotationAnimations,
      //   widget: Text("Hello"),
      //   category: "Rotation Animations",
      // ),
    ],
  ),
  AppCategoryGroupModel(
    category: ComponentCategoryEnum.EFFECTS,
    description: "Visual effects ranging from shadows and gradients to more complex transformations",
    items: [
      AppCategoryModel(
        link: RouteNames.gradientEffects,
        widget: const GradientEffectsBlocItem(),
        subCategory: SubComponentCategoryEnum.LINEAR_GRADIENTS,
        category: ComponentCategoryEnum.EFFECTS,
      ),
      // AppCategoryModel(
      //   link: RouteNames.backgroundEffects,
      //   widget: const ColorsEffectBloc(),
      //   category: "Color Effects",
      //   alignment: Alignment.topCenter,
      // ),
    ],
  ),
];
