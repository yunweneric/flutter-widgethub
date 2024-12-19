import 'package:flutter/material.dart';
import 'package:flutterui/app/shared/data/models/code_component.dart';
import 'package:flutterui/app/shared/presentation/utils/lang_util.dart';
import 'package:flutterui/components/presentation/blocks/bottom_nav_bars/docking_bar/docking_bar_code.dart';
import 'package:flutterui/components/presentation/blocks/bottom_nav_bars/docking_bar/docking_bar_setup.dart';
import 'package:flutterui/components/presentation/blocks/bottom_nav_bars/docking_bar/docking_bar_widget.dart';
import 'package:flutterui/app/shared/data/enums/component_category_enum.dart';
import 'package:flutterui/app/shared/data/enums/sub_component_category_enum.dart';
import 'package:flutterui/app/shared/data/enums/supported_platform.dart';
import 'package:flutterui/app/shared/data/models/component.dart';

class DockingBarData {
  static const Widget widget = DockingBarWidget();
  static String code = dockingBarCode;
  static String setup = dockingBarSetup;

  static Component component = Component(
    createdAt: DateTime(2024, 11, 15),
    updatedAt: DateTime(2024, 11, 15),
    id: "docking-bottom-bar",
    codeComponents: [CodeComponent(code: code, widget: widget)],
    description: LangUtil.trans('dockingBarDescription'),
    title: LangUtil.trans('dockingBarTitle'),
    setup: setup,
    category: ComponentCategoryEnum.BLOCKS,
    subcategory: SubComponentCategoryEnum.BOTTOM_NAV_BARS,
    supportedPlatforms: [SupportedPlatform.ANDROID, SupportedPlatform.IOS],
  );
}
