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

final blocItems = [
  AppCategoryGroup(
    title: "Templates",
    description: "A wide range of pre-built UI templates from app clones to demo apps all in one place",
    items: [
      AppCategory(
        link: RouteNames.templates,
        widget: const AppCloneBlocItem(),
        title: "App Clones",
        alignment: Alignment.topCenter,
      ),
      AppCategory(
        link: RouteNames.onboarding,
        widget: const BottomBarBlocItem(),
        title: "Onboarding Screens",
      ),
      AppCategory(
        link: RouteNames.homeScreens,
        widget: const HomeScreenBlocItem(),
        title: "Home Screens",
        alignment: Alignment.topCenter,
      ),
      AppCategory(
        link: RouteNames.authScreens,
        widget: const AuthBlocItem(),
        title: "Authentication Screens",
      ),
    ],
  ),
  AppCategoryGroup(
    title: "Blocks",
    description: "A collection of reusable layout blocks to help you create consistent and responsive layouts",
    items: [
      AppCategory(
        link: RouteNames.switchers,
        widget: const SwitchersBlocItem(),
        title: "Switchers",
        alignment: Alignment.topCenter,
      ),
      AppCategory(
        link: RouteNames.inputs,
        widget: const InputsBlocItem(),
        title: "Inputs",
        alignment: Alignment.center,
      ),
      AppCategory(
        link: RouteNames.banners,
        widget: const TextBlocItem(),
        title: "Text",
      ),
      AppCategory(
        link: RouteNames.sliders,
        widget: const LoadersBlocItem(),
        title: "Loaders",
        alignment: Alignment.topCenter,
      ),
      AppCategory(
        link: RouteNames.buttons,
        widget: const ButtonsBlocItem(),
        title: "Buttons",
        alignment: Alignment.center,
      ),
      AppCategory(
        link: RouteNames.bottomBars,
        widget: const BottomNavBarsBlocItem(),
        title: "Bottom Nav Bars",
      ),
      AppCategory(
        link: RouteNames.drawers,
        widget: const DrawersBlocItem(),
        title: "Drawer Menus",
        alignment: Alignment.topCenter,
      ),
      AppCategory(
        link: RouteNames.carousels,
        widget: const CarouselsBlocItem(),
        title: "Sliders and Carousels",
      ),
    ],
  ),
  AppCategoryGroup(
    title: "Animations",
    description: "Smooth and captivating animations that can be easily applied to any element.",
    items: [
      // AppCategory(
      //   link: RouteNames.hoverAnimations,
      //   widget: Text("Hello"),
      //   title: "Hover Animations",
      // ),
      // AppCategory(
      //   link: RouteNames.skewAnimations,
      //   widget: Text("Hello"),
      //   title: "Skew Animations",
      // ),
      // AppCategory(
      //   link: RouteNames.rotationAnimations,
      //   widget: Text("Hello"),
      //   title: "Rotation Animations",
      // ),
    ],
  ),
  AppCategoryGroup(
    title: "Effects",
    description: "Visual effects ranging from shadows and gradients to more complex transformations",
    items: [
      AppCategory(
        link: RouteNames.gradientEffects,
        widget: const GradientEffectsBlocItem(),
        title: "Linear Gradients",
      ),
      // AppCategory(
      //   link: RouteNames.backgroundEffects,
      //   widget: const ColorsEffectBloc(),
      //   title: "Color Effects",
      //   alignment: Alignment.topCenter,
      // ),
    ],
  ),
];
