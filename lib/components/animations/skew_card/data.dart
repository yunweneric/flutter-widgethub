import 'package:flutter/material.dart';
import 'package:flutterui/components/animations/skew_card/skew_card_code.dart';
import 'package:flutterui/components/animations/skew_card/skew_card_widget.dart';
import 'package:flutterui/components/export/data.dart';
import 'package:flutterui/components/shared/setup.dart';

class SkewCardData {
  static const Widget widget = SkewCard();
  static String code = skewCardCode;
  static String setup = basicSetup;
  static Component component = Component(
    code: code,
    widget: widget,
    description: 'A card perspective effect, hover over the card to elevate card elements.',
    title: '3D Skew Card',
    setup: setup,
  );
}
