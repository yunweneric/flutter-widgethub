import 'package:flutter/material.dart';
import 'package:flutterui/app/shared/data/models/code_component.dart';
import 'package:flutterui/components/presentation/blocks/buttons/classic_button/classic_button_code.dart';
import 'package:flutterui/components/presentation/blocks/buttons/classic_button/classic_button_setup.dart';
import 'package:flutterui/components/presentation/blocks/buttons/classic_button/classic_button_widget.dart';
import 'package:flutterui/app/shared/data/enums/component_category_enum.dart';
import 'package:flutterui/app/shared/data/enums/sub_component_category_enum.dart';
import 'package:flutterui/app/shared/data/enums/supported_platform.dart';
import 'package:flutterui/app/shared/data/models/component.dart';

class ClassicButtonData {
  static const Widget widget = ClassicButton();
  static String code = classicButtonCode;
  static String setup = classicButtonSetup;
  static Component component = Component(
    createdAt: DateTime(2024, 8, 12),
    updatedAt: DateTime(2024, 8, 12),
    id: "classic-btn",
    codeComponents: [CodeComponent(code: code, widget: widget)],
    description: 'A card perspective effect, hover over the card to elevate card elements.',
    title: 'Classic Button',
    setup: setup,
    category: ComponentCategoryEnum.BLOCKS,
    subcategory: SubComponentCategoryEnum.BUTTONS,
    supportedPlatforms: [SupportedPlatform.ANDROID, SupportedPlatform.IOS],
  );
}
