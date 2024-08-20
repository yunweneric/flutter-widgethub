// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutterui/screens/support/data/model/provider.dart';

class InitializePaymentData {
  final String tId;
  final String tSum;
  final String tUrl;
  final String transactionId;
  final String transactionUrl;
  // final List<Provider> providers;

  InitializePaymentData({
    required this.tId,
    required this.tSum,
    required this.tUrl,
    required this.transactionId,
    required this.transactionUrl,
    // required this.providers,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      't_id': tId,
      't_sum': tSum,
      't_url': tUrl,
      'transaction_id': transactionId,
      'transaction_url': transactionUrl,
      // 'providers': providers.map((x) => x.toMap()).toList(),
    };
  }

  factory InitializePaymentData.fromMap(Map<String, dynamic> map) {
    return InitializePaymentData(
      tId: map['t_id'] as String,
      tSum: map['t_sum'] as String,
      tUrl: map['t_url'] as String,
      transactionId: map['transaction_id'] as String,
      transactionUrl: map['transaction_url'] as String,
      // providers: List<Provider>.from(
      //   (map['providers'] as List<int>).map<Provider>(
      //     (x) => Provider.fromMap(x as Map<String, dynamic>),
      //   ),
      // ),
    );
  }

  String toJson() => json.encode(toMap());

  factory InitializePaymentData.fromJson(String source) => InitializePaymentData.fromMap(json.decode(source) as Map<String, dynamic>);
}
