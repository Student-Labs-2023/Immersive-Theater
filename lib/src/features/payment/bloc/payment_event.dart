part of 'payment_bloc.dart';

abstract class PaymentEvent extends Equatable {
  const PaymentEvent();

  @override
  List<Object> get props => [];
}

class PaymentGetLink extends PaymentEvent {
  final String userId;
  final int perfId;

  const PaymentGetLink({required this.userId, required this.perfId});
}

class PaymentOpenLink extends PaymentEvent {}
