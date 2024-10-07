import 'dart:convert';

import 'package:flutter/material.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class CodeComponent {
  final String code;
  final Widget widget;

  CodeComponent({required this.code, required this.widget});

  CodeComponent copyWith({
    String? code,
    Widget? widget,
  }) {
    return CodeComponent(
      code: code ?? this.code,
      widget: widget ?? this.widget,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'code': code,
      'widget': widget,
    };
  }

  factory CodeComponent.fromMap(Map<String, dynamic> map) {
    return CodeComponent(
      code: map['code'] as String,
      widget: map['widget'] as Widget,
    );
  }

  String toJson() => json.encode(toMap());

  factory CodeComponent.fromJson(String source) => CodeComponent.fromMap(json.decode(source) as Map<String, dynamic>);
}
