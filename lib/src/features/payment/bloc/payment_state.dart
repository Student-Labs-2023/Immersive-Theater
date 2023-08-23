part of 'payment_bloc.dart';

abstract class PaymentState extends Equatable {
  const PaymentState({required this.paymentLink});
  final String paymentLink;

  @override
  List<Object> get props => [];
}

class PaymentInitial extends PaymentState {
  const PaymentInitial({required super.paymentLink});
}

class PaymentLinkLoaded extends PaymentState {
  const PaymentLinkLoaded({required super.paymentLink});
}

class PaymentLinkFailure extends PaymentState {
  const PaymentLinkFailure({required super.paymentLink});
}
