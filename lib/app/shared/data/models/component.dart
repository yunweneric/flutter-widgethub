// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutterui/app/shared/data/enums/component_category_enum.dart';
import 'package:flutterui/app/shared/data/enums/device_type.dart';
import 'package:flutterui/app/shared/data/enums/sub_component_category_enum.dart';
import 'package:flutterui/app/shared/data/enums/supported_platform.dart';
import 'package:flutterui/app/shared/data/models/code_component.dart';

class Component {
  final String id;
  // final String code;
  final String title;
  final String setup;
  final String description;
  final DateTime createdAt;
  final DateTime updatedAt;
  // final Widget widget;
  final ComponentCategoryEnum category;
  final SubComponentCategoryEnum subcategory;
  final String? assetLink;
  final String? gitHubLink;
  final List<CodeComponent> codeComponents;
  final List<SupportedPlatform> supportedPlatforms;
  final List<AppDeviceType> responsiveDevices;

  Component({
    required this.id,
    required this.codeComponents,
    required this.title,
    required this.setup,
    required this.createdAt,
    required this.updatedAt,
    required this.description,
    // required this.widget,
    // required this.code,
    required this.subcategory,
    required this.category,
    this.assetLink,
    this.gitHubLink,
    required this.responsiveDevices,
    required this.supportedPlatforms,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'setup': setup,
      'description': description,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'category': category.describe(),
      'subcategory': subcategory.describe(),
      'assetLink': assetLink,
      'gitHubLink': gitHubLink,
      'codeComponents': codeComponents.map((x) => x.toMap()).toList(),
      'supportedPlatforms': supportedPlatforms.map((x) => x.describe()).toList(),
      'responsiveDevices': responsiveDevices.map((x) => x.describe()).toList(),
    };
  }

  Component copyWith({
    String? id,
    String? title,
    String? setup,
    String? description,
    ComponentCategoryEnum? category,
    SubComponentCategoryEnum? subcategory,
    String? assetLink,
    String? gitHubLink,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<CodeComponent>? codeComponents,
    List<SupportedPlatform>? supportedPlatforms,
  }) {
    return Component(
      id: id ?? this.id,
      title: title ?? this.title,
      setup: setup ?? this.setup,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      category: category ?? this.category,
      subcategory: subcategory ?? this.subcategory,
      assetLink: assetLink ?? this.assetLink,
      gitHubLink: gitHubLink ?? this.gitHubLink,
      codeComponents: codeComponents ?? this.codeComponents,
      supportedPlatforms: supportedPlatforms ?? this.supportedPlatforms,
      responsiveDevices: responsiveDevices ?? this.responsiveDevices,
    );
  }

  factory Component.fromMap(Map<String, dynamic> map) {
    return Component(
      id: map['id'] as String,
      title: map['title'] as String,
      setup: map['setup'] as String,
      createdAt: DateTime.parse(map['createdAt'] as String),
      updatedAt: DateTime.parse(map['updatedAt'] as String),
      description: map['description'] as String,
      category: ComponentCategoryEnum.values.firstWhere((item) => item.describe() == map['category']),
      subcategory: SubComponentCategoryEnum.values.firstWhere((item) => item.describe() == map['subcategory']),
      assetLink: map['assetLink'] != null ? map['assetLink'] as String : null,
      gitHubLink: map['gitHubLink'] != null ? map['gitHubLink'] as String : null,
      codeComponents: List<CodeComponent>.from(
        (map['codeComponents'] as List<int>).map<CodeComponent>(
          (x) => CodeComponent.fromMap(x as Map<String, dynamic>),
        ),
      ),
      supportedPlatforms: List<SupportedPlatform>.from(
        (map['supportedPlatforms'] as List<String>).map<SupportedPlatform>(
          (x) => SupportedPlatform.values.firstWhere((item) => item.describe() == x),
        ),
      ),
      responsiveDevices: List<AppDeviceType>.from(
        (map['responsiveDevices'] as List<String>).map<AppDeviceType>(
          (x) => AppDeviceType.values.firstWhere((item) => item.describe() == x),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Component.fromJson(String source) => Component.fromMap(json.decode(source) as Map<String, dynamic>);
}
