import 'package:flutter/material.dart';
import 'package:flutterui/app/shared/data/models/code_component.dart';
import 'package:flutterui/app/shared/presentation/utils/lang_util.dart';
import 'package:flutterui/components/presentation/animations/skew_card/skew_card_code.dart';
import 'package:flutterui/components/presentation/animations/skew_card/skew_card_widget.dart';
import 'package:flutterui/components/shared/setup.dart';
import 'package:flutterui/app/shared/data/enums/component_category_enum.dart';
import 'package:flutterui/app/shared/data/enums/sub_component_category_enum.dart';
import 'package:flutterui/app/shared/data/enums/supported_platform.dart';
import 'package:flutterui/app/shared/data/models/component.dart';

class SkewCardData {
  static const Widget widget = SkewCard();
  static String code = skewCardCode;
  static String setup = basicSetup;
  static Component component = Component(
    createdAt: DateTime(2024, 9, 2),
    updatedAt: DateTime(2024, 9, 2),
    id: "3d-skew-card",
    codeComponents: [CodeComponent(code: code, widget: widget)],
    description: LangUtil.trans('skewCardDescription'),
    title: LangUtil.trans('skewCardTitle'),
    setup: setup,
    category: ComponentCategoryEnum.BLOCKS,
    subcategory: SubComponentCategoryEnum.SLIDERS_AND_CAROUSELS,
    supportedPlatforms: [SupportedPlatform.ANDROID, SupportedPlatform.IOS],
  );
}
