import 'package:flutter/material.dart';
import 'package:flutterui/components/cards/flip_card/flip_card_code.dart';
import 'package:flutterui/components/cards/flip_card/flip_card_setup.dart';
import 'package:flutterui/components/cards/flip_card/flip_card_widget.dart';
import 'package:flutterui/components/export/data.dart';

class AppFlipCard {
  static Widget widget = ComponentFlipCard(title: "Hello Wold");
  static String code = flipCardButtonCode;
  static String setup = flipCardButtonSetup;
  static Component component = Component(
    code: code,
    widget: widget,
    description: 'A card perspective effect, hover over the card to elevate card elements.',
    title: '3D Card Effect',
    setup: setup,
  );
}
