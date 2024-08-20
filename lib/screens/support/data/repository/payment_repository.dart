import 'package:flutterui/screens/support/data/model/payment_init_params.dart';
import 'package:flutterui/screens/support/data/model/payment_init_response.dart';
import 'package:flutterui/screens/support/data/services/payment_service.dart';

class PaymentRepository {
  final PaymentService _paymentService;

  PaymentRepository({required PaymentService paymentService}) : _paymentService = paymentService;

  Future<InitializePaymentResponse> initializePayment(InitializePaymentParams params) async {
    final data = await _paymentService.initializePayment(params);
    return InitializePaymentResponse.fromMap(data);
  }
}
