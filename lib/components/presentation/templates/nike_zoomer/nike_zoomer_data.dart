import 'package:flutter/material.dart';
import 'package:flutterui/app/shared/data/enums/component_category_enum.dart';
import 'package:flutterui/app/shared/data/enums/device_type.dart';
import 'package:flutterui/app/shared/data/enums/sub_component_category_enum.dart';
import 'package:flutterui/app/shared/data/enums/supported_platform.dart';
import 'package:flutterui/app/shared/data/models/code_component.dart';
import 'package:flutterui/app/shared/data/models/component.dart';
import 'package:flutterui/app/shared/presentation/utils/lang_util.dart';
import 'package:flutterui/components/presentation/templates/nike_zoomer/nike_zoomer_code.dart';
import 'package:flutterui/components/presentation/templates/nike_zoomer/nike_zoomer_setup.dart';
import 'package:flutterui/components/presentation/templates/nike_zoomer/nike_zoomer_widget.dart';

class NikeZoomerTemplateData {
  static Widget widget = const NikeZoomerTemplate();
  static String code = nikeZoomerCode;
  static String setup = nikeZoomerSetup;
  static Component component = Component(
    createdAt: DateTime(2024, 5, 19),
    updatedAt: DateTime(2024, 5, 19),
    codeComponents: [CodeComponent(code: code, widget: widget)],
    id: "nike-zoomer",
    description: LangUtil.trans('nikeZoomerDescription'),
    title: LangUtil.trans('nikeZoomerTitle'),
    setup: setup,
    category: ComponentCategoryEnum.BLOCKS,
    subcategory: SubComponentCategoryEnum.SLIDERS_AND_CAROUSELS,
    assetLink: "https://github.com/yunweneric/flutter-open-ui/raw/nike_zoomer/assets.zip",
    gitHubLink: "https://github.com/yunweneric/flutter-open-ui/tree/nike_zoomer",
    supportedPlatforms: [SupportedPlatform.ANDROID, SupportedPlatform.IOS, SupportedPlatform.MACOS, SupportedPlatform.WEB],
    responsiveDevices: [AppDeviceType.MOBILE, AppDeviceType.TABLET, AppDeviceType.DESKTOP],
  );
}
