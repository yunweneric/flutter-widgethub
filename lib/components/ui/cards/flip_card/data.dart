import 'package:flutter/material.dart';
import 'package:flutterui/components/ui/cards/flip_card/flip_card_code.dart';
import 'package:flutterui/components/ui/cards/flip_card/flip_card_setup.dart';
import 'package:flutterui/components/ui/cards/flip_card/flip_card_widget.dart';
import 'package:flutterui/components/ui/export/component_store.dart';
import 'package:flutterui/shared/data/enums/component_category_enum.dart';
import 'package:flutterui/shared/data/enums/sub_component_category_enum.dart';
import 'package:flutterui/shared/data/enums/supported_platform.dart';

class AppFlipCard {
  static Widget widget = const ComponentFlipCard(title: "Hello Wold");
  static String code = flipCardButtonCode;
  static String setup = flipCardButtonSetup;
  static Component component = Component(
    code: code,
    id: "3d-flip-card",
    widget: widget,
    description: 'A card perspective effect, hover over the card to elevate card elements.',
    title: '3D Flip Card',
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
  );
}
