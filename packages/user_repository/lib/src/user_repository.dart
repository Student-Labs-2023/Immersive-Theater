import 'package:user_repository/src/models/models.dart';

abstract class UserRepository {
  Future<User?> getUser();
}
