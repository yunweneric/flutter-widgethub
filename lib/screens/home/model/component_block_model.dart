import 'package:flutter/material.dart';

class AppCategoryGroup {
  final String title;
  final bool? isActive;
  final String description;
  final List<AppCategory> items;

  AppCategoryGroup({required this.title, this.isActive, required this.description, required this.items});
}

class AppCategory {
  final Widget widget;
  final String title;
  final String link;
  final AlignmentGeometry? alignment;

  AppCategory({required this.widget, required this.title, this.alignment, required this.link});
}
