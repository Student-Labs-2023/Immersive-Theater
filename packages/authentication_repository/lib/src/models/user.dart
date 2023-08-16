import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String id;
  final String? phoneNumber;

  const UserModel({required this.id, this.phoneNumber});
  @override
  List<Object?> get props => [phoneNumber];

  static const empty = UserModel(id: '');

  bool get isEmpty => this == UserModel.empty;
  bool get isNotEmpty => this != UserModel.empty;
}
