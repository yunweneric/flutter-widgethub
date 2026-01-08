/// Data models for component category organization.
///
/// Defines models for grouping and organizing components into categories
/// and subcategories for display in the sidebar and navigation.
import 'package:flutter/material.dart';
import 'package:flutterui/app/shared/data/enums/component_category_enum.dart';
import 'package:flutterui/app/shared/data/enums/sub_component_category_enum.dart';

/// Model representing a group of component categories.
///
/// Used to organize components into logical groups (e.g., Templates, Blocks, Animations)
/// for display in the sidebar navigation.
class AppCategoryGroupModel {
  /// The main category this group belongs to.
  final ComponentCategoryEnum category;
  
  /// Whether this category group is currently active/selected.
  final bool? isActive;
  
  /// Description text for this category group.
  final String description;
  
  /// List of subcategories within this group.
  final List<AppCategoryModel> items;

  /// Creates a category group model.
  AppCategoryGroupModel({
    required this.category,
    required this.description,
    required this.items,
    this.isActive,
  });
}

/// Model representing an individual component category.
///
/// Contains information about a specific category including its preview widget,
/// category type, subcategory, and alignment preferences.
class AppCategoryModel {
  /// Preview widget to display for this category.
  final Widget widget;
  
  /// The component category this item belongs to.
  final ComponentCategoryEnum category;
  
  /// The subcategory classification.
  final SubComponentCategoryEnum subCategory;
  
  /// Preferred alignment for displaying the preview widget.
  final AlignmentGeometry? alignment;

  /// Creates a category model.
  AppCategoryModel({
    required this.widget,
    required this.category,
    required this.subCategory,
    this.alignment,
  });
}
