part of 'payment_bloc.dart';

class PaymentEvent {}

class InitializePaymentEvent extends PaymentEvent {
  final InitializePaymentParams params;

  InitializePaymentEvent({required this.params});
}
