import 'package:flutter/material.dart';
import 'package:flutterui/app/shared/shared.dart';

import 'code.dart';
import 'widget.dart';

class Switch01Data {
  static const Widget widget = Switch01();
  static String code = switch01Code;
  static String setup = setup;

  static Component component = Component(
    createdAt: DateTime(2025, 9, 15),
    updatedAt: DateTime(2025, 9, 15),
    id: "switch-01",
    codeComponents: [CodeComponent(code: code, widget: widget)],
    description: "A switch with a disclosure icon and a checkbox",
    title: "Disclose switcher",
    setup: setup,
    category: ComponentCategoryEnum.BLOCKS,
    subcategory: SubComponentCategoryEnum.SWITCHERS,
    supportedPlatforms: [SupportedPlatform.ANDROID, SupportedPlatform.IOS],
    responsiveDevices: [AppDeviceType.MOBILE, AppDeviceType.TABLET],
  );
}
