import 'package:flutter/material.dart';
import 'package:fwh/app/shared/data/enums/component_category_enum.dart';
import 'package:fwh/app/shared/data/enums/sub_component_category_enum.dart';

class AppCategoryGroupModel {
  final ComponentCategoryEnum category;
  final bool? isActive;
  final String description;
  final List<AppCategoryModel> items;

  AppCategoryGroupModel({
    required this.category,
    required this.description,
    required this.items,
    this.isActive,
  });
}

class AppCategoryModel {
  final Widget widget;
  final ComponentCategoryEnum category;
  final SubComponentCategoryEnum subCategory;
  final AlignmentGeometry? alignment;

  AppCategoryModel({
    required this.widget,
    required this.category,
    required this.subCategory,
    this.alignment,
  });
}
