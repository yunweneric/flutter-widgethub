import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutterui/screens/home/data/app_clone_bloc_item.dart';
import 'package:flutterui/screens/home/data/auth_bloc_item.dart';
import 'package:flutterui/screens/home/data/bottom_bar.dart';
import 'package:flutterui/screens/home/data/home_screen_bloc_item.dart';
import 'package:flutterui/screens/home/model/component_block_model.dart';
import 'package:flutterui/screens/routes/route_names.dart';

final blocItems = [
  ComponentBlockModel(
    title: "Templates",
    description: "A wide range of pre-built UI templates from app clones to demo apps all in one place",
    items: [
      BlocItem(
        link: RouteNames.templates,
        widget: const AppCloneBlocItem(),
        title: "App Clones",
        alignment: Alignment.topCenter,
      ),
      BlocItem(
        link: RouteNames.onboarding,
        widget: const BottomBarBlocItem(),
        title: "Onboarding Screens",
      ),
      BlocItem(
        link: RouteNames.homeScreens,
        widget: const HomeScreenBlocItem(),
        title: "Home Screens",
        alignment: Alignment.topCenter,
      ),
      BlocItem(
        link: RouteNames.authScreens,
        widget: const AuthBlocItem(),
        title: "Authentication Screens",
      ),
    ],
  ),
  ComponentBlockModel(
    title: "Blocks",
    description: "A collection of reusable layout blocks to help you create consistent and responsive layouts",
    items: [
      BlocItem(
        link: "clones",
        widget: Text("Hello"),
        title: "Taps",
        alignment: Alignment.topCenter,
      ),
      BlocItem(
        link: "clones",
        widget: Text("Hello"),
        title: "Inputs",
        alignment: Alignment.center,
      ),
      BlocItem(
        link: "clones",
        widget: Text("Hello"),
        title: "Banners",
      ),
      BlocItem(
        link: "clones",
        widget: Text("Hello"),
        title: "Sliders",
        alignment: Alignment.topCenter,
      ),
      BlocItem(
        link: "clones",
        widget: Text("Hello"),
        title: "Buttons",
        alignment: Alignment.center,
      ),
      BlocItem(
        link: "clones",
        widget: Text("Hello"),
        title: "Bottom Bars",
      ),
      BlocItem(
        link: "clones",
        widget: Text("Hello"),
        title: "Drawer Menus",
        alignment: Alignment.topCenter,
      ),
      BlocItem(
        link: "clones",
        widget: Text("Hello"),
        title: "Sliders and Carousels",
      ),
    ],
  ),
  ComponentBlockModel(
    title: "Animations",
    description: "Smooth and captivating animations that can be easily applied to any element.",
    items: [
      BlocItem(link: "clones", widget: Text("Hello"), title: "Inputs"),
      BlocItem(link: "clones", widget: Text("Hello"), title: "Inputs"),
      BlocItem(link: "clones", widget: Text("Hello"), title: "Inputs"),
    ],
  ),
  ComponentBlockModel(
    title: "Effects",
    description: "Visual effects ranging from shadows and gradients to more complex transformations",
    items: [
      BlocItem(link: "clones", widget: Text("Hello"), title: "Inputs"),
      BlocItem(link: "clones", widget: Text("Hello"), title: "Inputs"),
      BlocItem(link: "clones", widget: Text("Hello"), title: "Inputs"),
    ],
  ),
];
