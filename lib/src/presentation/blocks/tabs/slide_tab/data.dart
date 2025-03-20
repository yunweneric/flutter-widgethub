// import 'package:flutter/material.dart';
// import 'package:flutterui/app/shared/data/enums/device_type.dart';
// import 'package:flutterui/app/shared/data/models/code_component.dart';
// import 'package:flutterui/app/shared/presentation/utils/lang_util.dart';
// import 'package:flutterui/app/shared/data/enums/component_category_enum.dart';
// import 'package:flutterui/app/shared/data/enums/sub_component_category_enum.dart';
// import 'package:flutterui/app/shared/data/enums/supported_platform.dart';
// import 'package:flutterui/app/shared/data/models/component.dart';
// import 'package:flutterui/src/presentation/blocks/tabs/slide_tab/slide_tab_code.dart';
// import 'package:flutterui/src/presentation/blocks/tabs/slide_tab/slide_tab_widget.dart';
part of "../../blocks.dart";

class SlideTabData {
  static const Widget widget = SlideTabWidget();
  static String code = slideTabCode;
  static String setup = dockingBarSetup;

  static Component component = Component(
    createdAt: DateTime(2024, 11, 24),
    updatedAt: DateTime(2024, 11, 24),
    id: "slide-tab-bar",
    codeComponents: [CodeComponent(code: code, widget: widget)],
    description: LangUtil.trans('slideTabDescription'),
    title: LangUtil.trans('slideTabTitle'),
    setup: setup,
    category: ComponentCategoryEnum.BLOCKS,
    subcategory: SubComponentCategoryEnum.TABS,
    supportedPlatforms: [SupportedPlatform.ANDROID, SupportedPlatform.IOS],
    responsiveDevices: [AppDeviceType.MOBILE, AppDeviceType.TABLET],
  );
}
