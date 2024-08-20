part of 'payment_bloc.dart';

class PaymentState {}

class PaymentInitial extends PaymentState {}

class InitializePaymentLoading extends PaymentState {}

class InitializePaymentFailed extends PaymentState {
  final String message;

  InitializePaymentFailed({required this.message});
}

class InitializePaymentSuccess extends PaymentState {
  final InitializePaymentResponse response;

  InitializePaymentSuccess({required this.response});
}
