// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutterui/app/shared/data/enums/component_category_enum.dart';
import 'package:flutterui/app/shared/data/enums/sub_component_category_enum.dart';
import 'package:flutterui/app/shared/data/enums/supported_platform.dart';

class Component {
  final String id;
  final String code;
  final String title;
  final String setup;
  final String description;
  final Widget widget;
  final ComponentCategoryEnum category;
  final SubComponentCategoryEnum subcategory;
  final String? assetLink;
  final String? gitHubLink;
  final List<SupportedPlatform> supportedPlatforms;

  Component({
    required this.id,
    required this.code,
    required this.title,
    required this.setup,
    required this.description,
    required this.widget,
    required this.subcategory,
    required this.category,
    this.assetLink,
    this.gitHubLink,
    required this.supportedPlatforms,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'code': code,
      'title': title,
      'setup': setup,
      'description': description,
      'category': category.describe(),
      'subcategory': subcategory.describe(),
      'assetLink': assetLink,
      'gitHubLink': gitHubLink,
      'supportedPlatforms':
          supportedPlatforms.map((x) => x.describe()).toList(),
    };
  }

  factory Component.fromMap(Map<String, dynamic> map) {
    return Component(
      widget: Container(),
      id: map['id'] as String,
      code: map['code'] as String,
      title: map['title'] as String,
      setup: map['setup'] as String,
      description: map['description'] as String,
      category: ComponentCategoryEnum.values
          .firstWhere((item) => item.describe() == map['category']),
      subcategory: SubComponentCategoryEnum.values
          .firstWhere((item) => item.describe() == map['subcategory']),
      assetLink: map['assetLink'] != null ? map['assetLink'] as String : null,
      gitHubLink:
          map['gitHubLink'] != null ? map['gitHubLink'] as String : null,
      supportedPlatforms: List<SupportedPlatform>.from(
        (map['supportedPlatforms'] as List<String>).map<SupportedPlatform>(
          (x) => SupportedPlatform.values.firstWhere(
            (item) => item.describe() == x,
          ),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Component.fromJson(String source) =>
      Component.fromMap(json.decode(source) as Map<String, dynamic>);
}
