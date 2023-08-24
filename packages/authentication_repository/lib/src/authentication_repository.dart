import 'package:authentication_repository/src/models/models.dart';

abstract class AuthenticationRepository {
  Future<void> verifyPhoneNumber({required String phoneNumber});
  Future<void> verifyOTP({required String smsCode});
  Stream<UserModel> get user;
  void logOut();
}
