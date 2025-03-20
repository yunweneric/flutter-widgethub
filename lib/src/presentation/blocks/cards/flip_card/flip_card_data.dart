// import 'package:flutter/material.dart';
// import 'package:flutterui/app/shared/data/enums/device_type.dart';
// import 'package:flutterui/app/shared/data/models/code_component.dart';
// import 'package:flutterui/app/shared/presentation/utils/lang_util.dart';
// import 'package:flutterui/src/presentation/blocks/cards/flip_card/flip_card_code.dart';
// import 'package:flutterui/src/presentation/blocks/cards/flip_card/flip_card_setup.dart';
// import 'package:flutterui/src/presentation/blocks/cards/flip_card/flip_card_widget.dart';
// import 'package:flutterui/app/shared/data/enums/component_category_enum.dart';
// import 'package:flutterui/app/shared/data/enums/sub_component_category_enum.dart';
// import 'package:flutterui/app/shared/data/enums/supported_platform.dart';
// import 'package:flutterui/app/shared/data/models/component.dart';
part of "package:flutterui/src/presentation/blocks/blocks.dart";

class AppFlipCard {
  static Widget widget = const ComponentFlipCard(title: "Hello Wold");
  static String code = flipCardButtonCode;
  static String setup = flipCardButtonSetup;
  static Component component = Component(
    createdAt: DateTime(2024, 10, 5),
    updatedAt: DateTime(2024, 10, 5),
    id: "3d-flip-card",
    codeComponents: [
      CodeComponent(code: code, widget: widget),
    ],
    description: LangUtil.trans('flipCardDescription'),
    title: LangUtil.trans('flipCardTitle'),
    setup: setup,
    category: ComponentCategoryEnum.BLOCKS,
    subcategory: SubComponentCategoryEnum.SLIDERS_AND_CAROUSELS,
    assetLink: "https://www.figma.com/design/NIgvpP0UaRQoHT7VJg4DGg/Uicons-by-Flaticon-%7C-Free-interface-icons-(Community)?node-id=7-223&t=gXWvwkFdg6JhDyp9-0",
    gitHubLink: "https://www.figma.com/design/NIgvpP0UaRQoHT7VJg4DGg/Uicons-by-Flaticon-%7C-Free-interface-icons-(Community)?node-id=7-223&t=gXWvwkFdg6JhDyp9-0",
    supportedPlatforms: [
      SupportedPlatform.ANDROID,
      SupportedPlatform.IOS,
      SupportedPlatform.LINUX,
      SupportedPlatform.MACOS,
      SupportedPlatform.WEB,
    ],
    responsiveDevices: [AppDeviceType.MOBILE, AppDeviceType.TABLET, AppDeviceType.DESKTOP],
  );
}
