part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginPhoneNumberChanged extends LoginEvent {
  final String phoneNumber;

  const LoginPhoneNumberChanged(this.phoneNumber);

  @override
  List<Object> get props => [phoneNumber];
}

class LoginSubmitted extends LoginEvent {
  const LoginSubmitted();
}
