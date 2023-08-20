abstract class AuthenticationRepository {
  Future<void> verifyPhoneNumber({required String phoneNumber});
  Future<void> verifyOTP({required String smsCode});
  void logOut();
}
