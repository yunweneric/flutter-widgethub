import 'dart:convert';
import 'package:flutterui/core/config.dart';
import 'package:flutterui/screens/support/data/model/payment_init_params.dart';
import 'package:http/http.dart' as http;

class PaymentService {
  // Function to encode the Basic Auth credentials
  String _encodeBasicAuth(String user, String password) {
    final credentials = '$user:$password';
    final encodedCredentials = base64Encode(utf8.encode(credentials));
    return 'Basic $encodedCredentials';
  }

  // Function to initialize the payment
  Future<dynamic> initializePayment(InitializePaymentParams params) async {
    String? user = AppConfig.payUnitUser;
    String? password = AppConfig.payUnitPassword;
    String? baseUrl = AppConfig.payUnitBaseUrl;
    String? apiKey = AppConfig.payUnitApiKey;

    final url = '$baseUrl/api/gateway/initialize';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'mode': 'test',
          'x-api-key': apiKey!,
          'Content-Type': 'application/json',
          'Authorization': _encodeBasicAuth(user!, password!),
        },
        body: jsonEncode({
          'total_amount': params.totalAmount,
          'currency': params.currency,
          'transaction_id': params.transactionId,
          'return_url': params.returnUrl,
          'notify_url': params.notifyUrl,
          'payment_country': params.paymentCountry,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data;
      } else {
        throw Exception('Failed to initialize payment: ${response.body}');
      }
    } catch (error) {
      throw Exception('Error during payment initialization: $error');
    }
  }
}
