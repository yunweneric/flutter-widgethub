import 'package:flutter/material.dart';
import 'package:flutterui/components/buttons/classic_button/data.dart';

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
    ClassicButtonData.component,
    ClassicButtonData.component,
  ];
}
