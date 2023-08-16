import 'package:api_client/api_client.dart';
import 'package:dio/dio.dart';
import 'package:payment_service/src/payment_service.dart';

enum _PaymentEndpoint {
  payment('payment');

  const _PaymentEndpoint(this.endpoint);
  final String endpoint;
}

class PaymentServiceImpl implements PaymentService {
  final ApiClient _apiClient;

  PaymentServiceImpl({required ApiClient apiClient}) : _apiClient = apiClient;
  @override
  Future<String> pay(
      {required String userId, required int performanceId}) async {
    final paymentLink = await _apiClient.dio.get(
        _PaymentEndpoint.payment.endpoint,
        options: Options(responseType: ResponseType.json),
        queryParameters: {'user_id': userId, 'performance_id': performanceId});

    return paymentLink.data;
  }
}
