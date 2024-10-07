import 'package:flutter/material.dart';
import 'package:flutterui/app/presentation/home/data/blocks/bottom_nav_bars_bloc_item.dart';
import 'package:flutterui/app/presentation/home/data/blocks/buttons_bloc_item.dart';
import 'package:flutterui/app/presentation/home/data/blocks/carousels_bloc_item.dart';
import 'package:flutterui/app/presentation/home/data/blocks/drawers_bloc_item.dart';
import 'package:flutterui/app/presentation/home/data/blocks/inputs_bloc_item.dart';
import 'package:flutterui/app/presentation/home/data/blocks/loaders_bloc_item.dart';
import 'package:flutterui/app/presentation/home/data/blocks/switchers_bloc_item.dart';
import 'package:flutterui/app/presentation/home/data/blocks/text_bloc_item.dart';
import 'package:flutterui/app/presentation/home/data/effects/gradient_effects_bloc_item.dart';
import 'package:flutterui/app/presentation/home/data/templates/app_clone_bloc_item.dart';
import 'package:flutterui/app/presentation/home/data/templates/auth_bloc_item.dart';
import 'package:flutterui/app/presentation/home/data/templates/bottom_bar.dart';
import 'package:flutterui/app/presentation/home/data/templates/home_screen_bloc_item.dart';
import 'package:flutterui/app/presentation/home/model/component_block_model.dart';
import 'package:flutterui/app/shared/data/enums/component_category_enum.dart';
import 'package:flutterui/app/shared/data/enums/sub_component_category_enum.dart';

final sideBarCategories = [
  AppCategoryGroupModel(
    category: ComponentCategoryEnum.INTRODUCTION,
    description: "A wide range of pre-built UI templates from app clones to demo apps all in one place",
    items: [
      // AppCategoryModel(
      //   widget: const SizedBox.shrink(),
      //   subCategory: SubComponentCategoryEnum.ALL_COMPONENTS,
      //   category: ComponentCategoryEnum.INTRODUCTION,
      // ),
      AppCategoryModel(
        widget: const SizedBox.shrink(),
        subCategory: SubComponentCategoryEnum.REQUEST_A_COMPONENT,
        category: ComponentCategoryEnum.INTRODUCTION,
      ),
    ],
  ),
  AppCategoryGroupModel(
    category: ComponentCategoryEnum.TEMPLATES,
    description: "A wide range of pre-built UI templates from app clones to demo apps all in one place",
    items: [
      AppCategoryModel(
        widget: const AppCloneBlocItem(),
        subCategory: SubComponentCategoryEnum.APPS,
        category: ComponentCategoryEnum.TEMPLATES,
        alignment: Alignment.topCenter,
      ),
      AppCategoryModel(
        widget: const BottomBarBlocItem(),
        subCategory: SubComponentCategoryEnum.ONBOARDING_SCREENS,
        category: ComponentCategoryEnum.TEMPLATES,
      ),
      AppCategoryModel(
        widget: const HomeScreenBlocItem(),
        subCategory: SubComponentCategoryEnum.HOME_SCREENS,
        category: ComponentCategoryEnum.TEMPLATES,
        alignment: Alignment.topCenter,
      ),
      AppCategoryModel(
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
        widget: const SwitchersBlocItem(),
        subCategory: SubComponentCategoryEnum.SWITCHERS,
        category: ComponentCategoryEnum.BLOCKS,
        alignment: Alignment.topCenter,
      ),
      AppCategoryModel(
        widget: const InputsBlocItem(),
        subCategory: SubComponentCategoryEnum.INPUTS,
        category: ComponentCategoryEnum.BLOCKS,
        alignment: Alignment.center,
      ),
      AppCategoryModel(
        widget: const TextBlocItem(),
        subCategory: SubComponentCategoryEnum.TEXTS,
        category: ComponentCategoryEnum.BLOCKS,
      ),
      AppCategoryModel(
        widget: const LoadersBlocItem(),
        subCategory: SubComponentCategoryEnum.LOADERS,
        category: ComponentCategoryEnum.BLOCKS,
        alignment: Alignment.topCenter,
      ),
      AppCategoryModel(
        widget: const ButtonsBlocItem(),
        subCategory: SubComponentCategoryEnum.BUTTONS,
        category: ComponentCategoryEnum.BLOCKS,
        alignment: Alignment.center,
      ),
      AppCategoryModel(
        widget: const BottomNavBarsBlocItem(),
        subCategory: SubComponentCategoryEnum.BOTTOM_NAV_BARS,
        category: ComponentCategoryEnum.BLOCKS,
      ),
      AppCategoryModel(
        widget: const DrawersBlocItem(),
        subCategory: SubComponentCategoryEnum.DRAWERS,
        category: ComponentCategoryEnum.BLOCKS,
        alignment: Alignment.topCenter,
      ),
      AppCategoryModel(
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
