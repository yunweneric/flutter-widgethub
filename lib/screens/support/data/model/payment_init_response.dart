// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutterui/screens/support/data/model/payment_init_data.dart';

class InitializePaymentResponse {
  final String status;
  final int statusCode;
  final String message;
  final InitializePaymentData data;

  InitializePaymentResponse({
    required this.status,
    required this.statusCode,
    required this.message,
    required this.data,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'status': status,
      'statusCode': statusCode,
      'message': message,
      'data': data.toMap(),
    };
  }

  factory InitializePaymentResponse.fromMap(Map<String, dynamic> map) {
    return InitializePaymentResponse(
      status: map['status'] as String,
      statusCode: map['statusCode'] as int,
      message: map['message'] as String,
      data: InitializePaymentData.fromMap(map['data'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory InitializePaymentResponse.fromJson(String source) => InitializePaymentResponse.fromMap(json.decode(source) as Map<String, dynamic>);
}
