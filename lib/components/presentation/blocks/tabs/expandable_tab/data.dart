import 'package:flutter/material.dart';
import 'package:flutterui/app/shared/data/models/code_component.dart';
import 'package:flutterui/app/shared/presentation/utils/lang_util.dart';
import 'package:flutterui/components/presentation/blocks/bottom_nav_bars/docking_bar/docking_bar_setup.dart';
import 'package:flutterui/app/shared/data/enums/component_category_enum.dart';
import 'package:flutterui/app/shared/data/enums/sub_component_category_enum.dart';
import 'package:flutterui/app/shared/data/enums/supported_platform.dart';
import 'package:flutterui/app/shared/data/models/component.dart';
import 'package:flutterui/components/presentation/blocks/tabs/expandable_tab/expandable_tab_code.dart';
import 'package:flutterui/components/presentation/blocks/tabs/expandable_tab/expandable_tab_widget.dart';

class ExpandableTabData {
  static const Widget widget = ExpandableTab();
  static String code = expandableTabCode;
  static String setup = dockingBarSetup;

  static Component component = Component(
    createdAt: DateTime(2024, 11, 20),
    updatedAt: DateTime(2024, 11, 20),
    id: "expandable-tab-bar",
    codeComponents: [CodeComponent(code: code, widget: widget)],
    description: LangUtil.trans('expandableTabDescription'),
    title: LangUtil.trans('expandableTabTitle'),
    setup: setup,
    category: ComponentCategoryEnum.BLOCKS,
    subcategory: SubComponentCategoryEnum.TABS,
    supportedPlatforms: [SupportedPlatform.ANDROID, SupportedPlatform.IOS],
  );
}
