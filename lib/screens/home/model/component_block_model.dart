import 'package:flutter/material.dart';

class ComponentBlockModel {
  final String title;
  final bool? isActive;
  final String description;
  final List<Widget> widgets;

  ComponentBlockModel({required this.title, this.isActive, required this.description, required this.widgets});
}
