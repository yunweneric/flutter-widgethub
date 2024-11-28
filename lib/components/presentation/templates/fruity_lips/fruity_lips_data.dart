import 'package:flutter/material.dart';
import 'package:flutterui/app/shared/data/enums/component_category_enum.dart';
import 'package:flutterui/app/shared/data/enums/sub_component_category_enum.dart';
import 'package:flutterui/app/shared/data/enums/supported_platform.dart';
import 'package:flutterui/app/shared/data/models/code_component.dart';
import 'package:flutterui/app/shared/data/models/component.dart';
import 'package:flutterui/components/presentation/templates/fruity_lips/fruity_lips_code.dart';
import 'package:flutterui/components/presentation/templates/fruity_lips/fruity_lips_setup.dart';
import 'package:flutterui/components/presentation/templates/fruity_lips/fruity_lips_widget.dart';

class FruityLipsTemplateData {
  static Widget widget = const FruityLipsTemplate();
  static String code = fruityLipsCode;
  static String setup = fruityLipsSetup;
  static Component component = Component(
    createdAt: DateTime(2024, 7, 9),
    updatedAt: DateTime(2024, 7, 9),
    // code: code,
    id: "fruity-lips-carousel",
    // widget: widget,
    codeComponents: [CodeComponent(code: code, widget: widget)],
    description: 'An animated bottle carousel from figma community',
    title: 'Fruity Lips Carousel',
    setup: setup,
    category: ComponentCategoryEnum.BLOCKS,
    subcategory: SubComponentCategoryEnum.SLIDERS_AND_CAROUSELS,
    assetLink: "https://github.com/yunweneric/flutter-open-ui/raw/fruity_lips/assets/images.zip",
    gitHubLink: "https://github.com/yunweneric/flutter-open-ui/tree/fruity_lips",
    supportedPlatforms: [
      SupportedPlatform.ANDROID,
      SupportedPlatform.IOS,
    ],
  );
}
