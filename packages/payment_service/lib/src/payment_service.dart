abstract class PaymentService {
  Future<String> pay({required String userId, required int performanceId});
  Future<void> activate({required String userId, required int performanceId});
}
