import 'package:flutter/material.dart';
import 'package:flutterui/components/ui/animations/skew_card/data.dart';
import 'package:flutterui/components/ui/buttons/classic_button/data.dart';
import 'package:flutterui/components/ui/cards/flip_card/data.dart';

class Component {
  final String code;
  final String title;
  final String setup;
  final String description;
  final Widget widget;

  Component({required this.code, required this.title, required this.setup, required this.description, required this.widget});
}

class AllComponents {
  static List<Component> widgets = [
    AppFlipCard.component,
    ClassicButtonData.component,
    SkewCardData.component,
    // ClassicButtonData.component,
    // ClassicButtonData.component,
  ];
}
