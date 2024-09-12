import 'package:flutter/material.dart';
import 'package:flutterui/app/shared/data/enums/component_category_enum.dart';
import 'package:flutterui/app/shared/data/enums/sub_component_category_enum.dart';
import 'package:flutterui/app/shared/data/enums/supported_platform.dart';
import 'package:flutterui/app/shared/data/models/component.dart';
import 'package:flutterui/components/presentation/templates/fade_carousel/fade_carousel_code.dart';
import 'package:flutterui/components/presentation/templates/fade_carousel/fade_carousel_setup.dart';
import 'package:flutterui/components/presentation/templates/fade_carousel/fade_carousel_widget.dart';

class FadeCarouselTemplateData {
  static Widget widget = const FadeCarouselTemplate();
  static String code = fadeCarouselCode;
  static String setup = fadeCarouselSetup;
  static Component component = Component(
    code: code,
    id: "fade-carousel",
    widget: widget,
    description: 'An animated carousel with a nice fade in effect!',
    title: 'Fade Carousel',
    setup: setup,
    category: ComponentCategoryEnum.BLOCKS,
    subcategory: SubComponentCategoryEnum.SLIDERS_AND_CAROUSELS,
    assetLink: "https://github.com/yunweneric/flutter-open-ui/raw/fade_caarousel/assets/images.zip",
    gitHubLink: "https://github.com/yunweneric/flutter-open-ui/tree/fade_caarousel",
    supportedPlatforms: [
      SupportedPlatform.ANDROID,
      SupportedPlatform.IOS,
    ],
  );
}
