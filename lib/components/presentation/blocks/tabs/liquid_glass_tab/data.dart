import 'package:flutter/material.dart';
import 'package:flutterui/app/shared/data/enums/device_type.dart';
import 'package:flutterui/app/shared/data/models/code_component.dart';
import 'package:flutterui/app/shared/presentation/utils/lang_util.dart';
import 'package:flutterui/components/presentation/blocks/bottom_nav_bars/docking_bar/docking_bar_setup.dart';
import 'package:flutterui/app/shared/data/enums/component_category_enum.dart';
import 'package:flutterui/app/shared/data/enums/sub_component_category_enum.dart';
import 'package:flutterui/app/shared/data/enums/supported_platform.dart';
import 'package:flutterui/app/shared/data/models/component.dart';
import 'package:flutterui/components/presentation/blocks/tabs/liquid_glass_tab/liquid_glass_tab_code.dart';

import 'liquid_glass_tab_widget.dart';

class LiquidGlassTabData {
  static const Widget widget = LiquidGlassTab();
  static String code = liquidGlassTabCode;
  static String setup = dockingBarSetup;

  static Component component = Component(
    createdAt: DateTime(2025, 6, 20),
    updatedAt: DateTime(2025, 6, 20),
    id: "liquid-glass-tab-bar",
    codeComponents: [CodeComponent(code: code, widget: widget)],
    description: LangUtil.trans('liquidGlassTabDataDescription'),
    title: LangUtil.trans('liquidGlassTabDataTitle'),
    setup: setup,
    category: ComponentCategoryEnum.BLOCKS,
    subcategory: SubComponentCategoryEnum.TABS,
    supportedPlatforms: [SupportedPlatform.ANDROID, SupportedPlatform.IOS],
    responsiveDevices: [AppDeviceType.MOBILE, AppDeviceType.TABLET],
  );
}
