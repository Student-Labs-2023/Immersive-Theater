import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String phoneNumber;

  const User(this.phoneNumber);
  @override
  List<Object?> get props => [phoneNumber];

  static const empty = User('-');
}
