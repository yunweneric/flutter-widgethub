import 'package:flutter/material.dart';
import 'package:flutterui/components/buttons/classic_button.dart';
import 'package:flutterui/shared/data/literals/nav_bar.dart';

class Component {
  final String code;
  final Widget widget;

  Component({required this.code, required this.widget});
}

class AllComponents {
  static List<Component> widgets = [
    Component(code: navBarLiteral, widget: const ClassicButton()),
    Component(code: navBarLiteral, widget: const ClassicButton()),
  ];

  // List<Component> get getWidgets => widgets;
}
