import 'package:flutter/material.dart';

class ComponentBlockModel {
  final String title;
  final bool? isActive;
  final String description;
  final List<BlocItem> items;

  ComponentBlockModel({required this.title, this.isActive, required this.description, required this.items});
}

class BlocItem {
  final Widget widget;
  final String title;
  final String link;
  final AlignmentGeometry? alignment;

  BlocItem({required this.widget, required this.title, this.alignment, required this.link});
}
