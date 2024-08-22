import 'package:flutter/material.dart';
import 'package:flutterui/components/ui/animations/skew_card/data.dart';
import 'package:flutterui/components/ui/buttons/classic_button/data.dart';
import 'package:flutterui/components/ui/cards/flip_card/data.dart';
import 'package:flutterui/shared/data/enums/component_category_enum.dart';
import 'package:flutterui/shared/data/enums/sub_component_category_enum.dart';
import 'package:flutterui/shared/data/enums/supported_platform.dart';

class Component {
  final String id;
  final String code;
  final String title;
  final String setup;
  final String description;
  final Widget widget;
  final ComponentCategoryEnum category;
  final SubComponentCategoryEnum subcategory;
  final String? assetLink;
  final String? gitHubLink;
  final List<SupportedPlatform> supportedPlatforms;

  Component({
    required this.id,
    required this.code,
    required this.title,
    required this.setup,
    required this.description,
    required this.widget,
    required this.subcategory,
    required this.category,
    this.assetLink,
    this.gitHubLink,
    required this.supportedPlatforms,
  });
}

class AllComponents {
  static List<Component> widgets = [
    AppFlipCard.component,
    ClassicButtonData.component,
    SkewCardData.component,
    // ClassicButtonData.component,
    // ClassicButtonData.component,
  ];
}
