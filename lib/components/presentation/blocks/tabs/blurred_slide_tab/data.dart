import 'package:flutter/material.dart';
import 'package:flutterui/app/shared/data/models/code_component.dart';
import 'package:flutterui/components/presentation/blocks/bottom_nav_bars/docking_bar/docking_bar_setup.dart';
import 'package:flutterui/app/shared/data/enums/component_category_enum.dart';
import 'package:flutterui/app/shared/data/enums/sub_component_category_enum.dart';
import 'package:flutterui/app/shared/data/enums/supported_platform.dart';
import 'package:flutterui/app/shared/data/models/component.dart';
import 'package:flutterui/components/presentation/blocks/tabs/blurred_slide_tab/blurred_slide_tab_code.dart';
import 'package:flutterui/components/presentation/blocks/tabs/blurred_slide_tab/blurred_slide_tab_widget.dart';

class BlurredSlideTabData {
  static const Widget widget = BlurredSlideTabWidget();
  static String code = blurredSlideTabCode;
  static String setup = dockingBarSetup;

  static Component component = Component(
    createdAt: DateTime(2024, 11, 27),
    updatedAt: DateTime(2024, 11, 27),
    id: "blurred-slide-tab-bar",
    codeComponents: [CodeComponent(code: code, widget: widget)],
    description: 'A tab bar with blurred effect when active item is sliding between the items in the tab list',
    title: 'Animated Blurred Slide Tab Bar',
    setup: setup,
    category: ComponentCategoryEnum.BLOCKS,
    subcategory: SubComponentCategoryEnum.TABS,
    supportedPlatforms: [SupportedPlatform.ANDROID, SupportedPlatform.IOS],
  );
}
