import 'package:bloc/bloc.dart';
import 'package:flutterui/screens/support/data/model/payment_init_params.dart';
import 'package:flutterui/screens/support/data/model/payment_init_response.dart';
import 'package:flutterui/screens/support/data/repository/payment_repository.dart';

part 'payment_event.dart';
part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  final PaymentRepository _paymentRepository;
  PaymentBloc(this._paymentRepository) : super(PaymentInitial()) {
    on<InitializePaymentEvent>((event, emit) async {
      emit(InitializePaymentLoading());
      try {
        final response = await _paymentRepository.initializePayment(event.params);
        emit(InitializePaymentSuccess(response: response));
      } catch (e) {
        emit(InitializePaymentFailed(message: ""));
      }
    });
  }
}
