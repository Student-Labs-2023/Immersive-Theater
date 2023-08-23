import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:payment_service/payment_service.dart';
import 'package:webview_flutter/webview_flutter.dart';

part 'payment_event.dart';
part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  final PaymentService _paymentService;

  final WebViewController controller = WebViewController();
  PaymentBloc({required PaymentService paymentService})
      : _paymentService = paymentService,
        super(const PaymentInitial(paymentLink: '')) {
    on<PaymentGetLink>(_onPaymentGetLink);
    on<PaymentOpenLink>(_onPaymentOpenLink);
  }

  Future<void> _onPaymentGetLink(
    PaymentGetLink event,
    Emitter<PaymentState> emit,
  ) async {
    try {
      final url = await _paymentService.pay(
        userId: event.userId,
        performanceId: event.perfId,
      );

      emit(PaymentLinkLoaded(paymentLink: url));
    } catch (e) {
      emit(const PaymentLinkFailure(paymentLink: ''));
    }
  }

  Future<void> _onPaymentOpenLink(
    PaymentOpenLink event,
    Emitter<PaymentState> emit,
  ) async {
    controller
      ..loadRequest(Uri.parse(state.paymentLink))
      ..setNavigationDelegate(
        NavigationDelegate(
          onUrlChange: (change) {
            log(change.url.toString());
          },
        ),
      );
  }
}
