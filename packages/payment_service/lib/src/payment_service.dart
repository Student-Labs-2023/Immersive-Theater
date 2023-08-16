abstract class PaymentService {
  Future<String> pay({required String userId, required int performanceId});
}
