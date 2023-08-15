part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginPhoneNumberChanged extends LoginEvent {
  final String phoneNumber;

  const LoginPhoneNumberChanged({required this.phoneNumber});

  @override
  List<Object> get props => [phoneNumber];
}

class LoginVerifyPhoneNumber extends LoginEvent {
  const LoginVerifyPhoneNumber();
}

class LoginVerifyOTP extends LoginEvent {
  final String smsCode;
  const LoginVerifyOTP({required this.smsCode});
  @override
  List<Object> get props => [smsCode];
}
