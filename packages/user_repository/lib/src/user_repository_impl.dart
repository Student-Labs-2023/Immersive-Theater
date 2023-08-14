import 'package:user_repository/src/models/models.dart';
import 'package:user_repository/src/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  User? _user;
  @override
  Future<User?> getUser() async {
    if (_user != null) return _user;
    return Future.delayed(const Duration(milliseconds: 300),
        () => _user = const User('+74504905940'));
  }
}
