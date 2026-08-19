import 'package:flutter/material.dart';
import 'package:flutterui/app/shared/data/enums/component_category_enum.dart';
import 'package:flutterui/app/shared/data/enums/device_type.dart';
import 'package:flutterui/app/shared/data/enums/sub_component_category_enum.dart';
import 'package:flutterui/app/shared/data/enums/supported_platform.dart';
import 'package:flutterui/app/shared/data/models/code_component.dart';
import 'package:flutterui/app/shared/data/models/component.dart';
import 'package:flutterui/app/shared/presentation/utils/lang_util.dart';
import 'package:flutterui/components/presentation/templates/animated_fruit_carousel/animated_fruit_carousel_code.dart';
import 'package:flutterui/components/presentation/templates/animated_fruit_carousel/animated_fruit_carousel_setup.dart';
import 'package:flutterui/components/presentation/templates/animated_fruit_carousel/animated_fruit_carousel_widget.dart';

class AnimatedFruitCarouselTemplateData {
  static Widget widget = const AnimatedFruitCarouselTemplate();
  static String code = animatedFruitCarouselCode;
  static String setup = animatedFruitCarouselSetup;
  static Component component = Component(
    isFeatured: true,
    createdAt: DateTime(2026, 8, 19),
    updatedAt: DateTime(2026, 8, 19),
    id: "animated-fruit-carousel",
    codeComponents: [CodeComponent(code: code, widget: widget)],
    description: LangUtil.trans('animatedFruitCarouselDescription'),
    title: LangUtil.trans('animatedFruitCarouselTitle'),
    setup: setup,
    category: ComponentCategoryEnum.BLOCKS,
    subcategory: SubComponentCategoryEnum.SLIDERS_AND_CAROUSELS,
    // The source branch ships loose PNGs under assets/images/, not a zip.
    assetLink: null,
    gitHubLink:
        "https://github.com/yunweneric/flutter-open-ui/tree/animated_fruit_carousel",
    supportedPlatforms: [SupportedPlatform.ANDROID, SupportedPlatform.IOS],
    responsiveDevices: [AppDeviceType.MOBILE, AppDeviceType.TABLET],
  );
}
