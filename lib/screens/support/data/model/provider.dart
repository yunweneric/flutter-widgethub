// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutterui/screens/support/data/model/country.dart';

class Provider {
  final String shortcode;
  final String name;
  final String logo;
  final String status;
  final Country country;

  Provider({
    required this.shortcode,
    required this.name,
    required this.logo,
    required this.status,
    required this.country,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'shortcode': shortcode,
      'name': name,
      'logo': logo,
      'status': status,
      'country': country.toMap(),
    };
  }

  factory Provider.fromMap(Map<String, dynamic> map) {
    return Provider(
      shortcode: map['shortcode'] as String,
      name: map['name'] as String,
      logo: map['logo'] as String,
      status: map['status'] as String,
      country: Country.fromMap(map['country'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory Provider.fromJson(String source) => Provider.fromMap(json.decode(source) as Map<String, dynamic>);
}
