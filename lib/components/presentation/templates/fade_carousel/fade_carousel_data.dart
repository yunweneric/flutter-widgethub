import 'package:flutter/material.dart';
import 'package:flutterui/app/shared/data/enums/component_category_enum.dart';
import 'package:flutterui/app/shared/data/enums/sub_component_category_enum.dart';
import 'package:flutterui/app/shared/data/enums/supported_platform.dart';
import 'package:flutterui/app/shared/data/models/code_component.dart';
import 'package:flutterui/app/shared/data/models/component.dart';
import 'package:flutterui/app/shared/presentation/utils/lang_util.dart';
import 'package:flutterui/components/presentation/templates/fade_carousel/fade_carousel_code.dart';
import 'package:flutterui/components/presentation/templates/fade_carousel/fade_carousel_setup.dart';
import 'package:flutterui/components/presentation/templates/fade_carousel/fade_carousel_widget.dart';

class FadeCarouselTemplateData {
  static Widget widget = const FadeCarouselTemplate();
  static String code = fadeCarouselCode;
  static String setup = fadeCarouselSetup;
  static Component component = Component(
    createdAt: DateTime(2024, 8, 22),
    updatedAt: DateTime(2024, 8, 22),
    id: "fade-carousel",
    codeComponents: [CodeComponent(code: code, widget: widget)],
    description: LangUtil.trans('fadeCarouselDescription'),
    title: LangUtil.trans('fadeCarouselTitle'),
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
