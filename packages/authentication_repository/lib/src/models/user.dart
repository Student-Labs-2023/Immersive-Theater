import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String? phoneNumber;

  const User({required this.id, this.phoneNumber});
  @override
  List<Object?> get props => [phoneNumber];

  static const empty = User(id: '');

  bool get isEmpty => this == User.empty;

  bool get isNotEmpty => this != User.empty;
}
