import 'package:flutter/material.dart';
import 'package:flutterui/app/shared/data/enums/component_category_enum.dart';
import 'package:flutterui/app/shared/data/enums/device_type.dart';
import 'package:flutterui/app/shared/data/enums/sub_component_category_enum.dart';
import 'package:flutterui/app/shared/data/enums/supported_platform.dart';
import 'package:flutterui/app/shared/data/models/code_component.dart';
import 'package:flutterui/app/shared/data/models/component.dart';

import 'package:flutterui/components/presentation/blocks/switches/switch_01/code.dart';
import 'package:flutterui/components/presentation/blocks/switches/switch_01/widget.dart';

/// Component data definition for [DiscloseSwitcher].
///
/// Provides the component metadata including:
/// - Title and description
/// - Category and subcategory
/// - Supported platforms
/// - Setup instructions
class DiscloseSwitcherData {
  static const Widget widget = DiscloseSwitcher();
  static String code = switch01Code;
  static String setup = '''
    flutter pub get
    flutter pub add flutter_svg
    ''';

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
