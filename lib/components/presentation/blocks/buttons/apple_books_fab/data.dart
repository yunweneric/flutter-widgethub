import 'package:flutter/material.dart';
import 'package:flutterui/app/shared/data/enums/device_type.dart';
import 'package:flutterui/app/shared/data/models/code_component.dart';
import 'package:flutterui/components/presentation/blocks/buttons/apple_books_fab/apple_books_fab_code.dart';
import 'package:flutterui/components/presentation/blocks/buttons/apple_books_fab/apple_books_fab_widget.dart';
import 'package:flutterui/app/shared/data/enums/component_category_enum.dart';
import 'package:flutterui/app/shared/data/enums/sub_component_category_enum.dart';
import 'package:flutterui/app/shared/data/enums/supported_platform.dart';
import 'package:flutterui/app/shared/data/models/component.dart';
import 'package:flutterui/components/shared/setup.dart';

class AppleBooksFABData {
  static const Widget widget = AppleBooksFAB();
  static String code = appleBooksFABCode;
  static String setup = basicSetup;
  static Component component = Component(
    createdAt: DateTime(2024, 12, 4),
    updatedAt: DateTime(2024, 12, 4),
    id: "apple-books-fab",
    codeComponents: [CodeComponent(code: code, widget: widget)],
    description: 'app_components.apple_books.description',
    title: 'app_components.apple_books.title',
    setup: setup,
    category: ComponentCategoryEnum.BLOCKS,
    subcategory: SubComponentCategoryEnum.BUTTONS,
    supportedPlatforms: [SupportedPlatform.ANDROID, SupportedPlatform.IOS],
    responsiveDevices: [AppDeviceType.MOBILE, AppDeviceType.TABLET, AppDeviceType.DESKTOP],
  );
}
