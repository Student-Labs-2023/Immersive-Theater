part of 'login_bloc.dart';

class LoginState extends Equatable {
  final FormzSubmissionStatus status;
  final PhoneNumber phoneNumber;
  final bool isValidPassword;
  final bool isValidCode;
  const LoginState({
    this.status = FormzSubmissionStatus.initial,
    this.phoneNumber = const PhoneNumber.pure(),
    this.isValidCode = true,
    this.isValidPassword = false,
  });

  LoginState copyWith({
    FormzSubmissionStatus? status,
    PhoneNumber? phoneNumber,
    bool? isValidPassword,
    bool? isValidCode,
  }) {
    return LoginState(
      status: status ?? this.status,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      isValidPassword: isValidPassword ?? this.isValidPassword,
      isValidCode: isValidCode ?? this.isValidCode,
    );
  }

  @override
  List<Object> get props => [status, phoneNumber, isValidCode, isValidPassword];
}
