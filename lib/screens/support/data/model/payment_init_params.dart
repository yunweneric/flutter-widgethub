// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class InitializePaymentParams {
  final double totalAmount;
  final String currency;
  final String transactionId;
  final String returnUrl;
  final String notifyUrl;
  final String paymentCountry;

  InitializePaymentParams({
    required this.totalAmount,
    required this.currency,
    required this.transactionId,
    required this.returnUrl,
    required this.notifyUrl,
    required this.paymentCountry,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'totalAmount': totalAmount,
      'currency': currency,
      'transactionId': transactionId,
      'returnUrl': returnUrl,
      'notifyUrl': notifyUrl,
      'paymentCountry': paymentCountry,
    };
  }

  factory InitializePaymentParams.fromMap(Map<String, dynamic> map) {
    return InitializePaymentParams(
      totalAmount: map['totalAmount'] as double,
      currency: map['currency'] as String,
      transactionId: map['transactionId'] as String,
      returnUrl: map['returnUrl'] as String,
      notifyUrl: map['notifyUrl'] as String,
      paymentCountry: map['paymentCountry'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory InitializePaymentParams.fromJson(String source) => InitializePaymentParams.fromMap(json.decode(source) as Map<String, dynamic>);
}
