import 'dart:async';

import 'package:authentication_repository/src/authentication_repository.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final _controller = StreamController<AuthenticationStatus>();

  Stream<AuthenticationStatus> get status async* {
    await Future.delayed(const Duration(seconds: 1));
    yield AuthenticationStatus.unknown;
    yield* _controller.stream;
  }

  @override
  Future<void> logIn({required String phoneNumber}) async {
    await Future.delayed(
      const Duration(milliseconds: 300),
      () => _controller.add(AuthenticationStatus.authenticated),
    );
  }

  @override
  void logOut() {
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  void dispose() => _controller.close();
}
