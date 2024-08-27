import 'package:flutter/material.dart';
import 'package:flutterui/components/ui/animations/skew_card/skew_card_code.dart';
import 'package:flutterui/components/ui/animations/skew_card/skew_card_widget.dart';
import 'package:flutterui/components/shared/setup.dart';
import 'package:flutterui/shared/data/enums/component_category_enum.dart';
import 'package:flutterui/shared/data/enums/sub_component_category_enum.dart';
import 'package:flutterui/shared/data/enums/supported_platform.dart';
import 'package:flutterui/shared/data/models/component.dart';

class SkewCardData {
  static const Widget widget = SkewCard();
  static String code = skewCardCode;
  static String setup = basicSetup;
  static Component component = Component(
    code: code,
    id: "3d-skew-card",
    widget: widget,
    description: 'A card perspective effect, hover over the card to elevate card elements.',
    title: '3D Skew Card',
    setup: setup,
    category: ComponentCategoryEnum.TEMPLATES,
    subcategory: SubComponentCategoryEnum.APP_CLONES,
    supportedPlatforms: [SupportedPlatform.ANDROID, SupportedPlatform.IOS],
  );
}
