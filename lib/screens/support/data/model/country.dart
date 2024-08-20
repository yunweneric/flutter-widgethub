// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Country {
  final String countryName;
  final String countryCode;

  Country({
    required this.countryName,
    required this.countryCode,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'countryName': countryName,
      'countryCode': countryCode,
    };
  }

  factory Country.fromMap(Map<String, dynamic> map) {
    return Country(
      countryName: map['countryName'] as String,
      countryCode: map['countryCode'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Country.fromJson(String source) => Country.fromMap(json.decode(source) as Map<String, dynamic>);
}
