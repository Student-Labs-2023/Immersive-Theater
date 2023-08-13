abstract class AuthenticationRepository {
  Future<void> logIn({required String phoneNumber});

  void logOut();
}
