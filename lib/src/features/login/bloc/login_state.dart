part of 'login_bloc.dart';

class LoginState extends Equatable {
  final FormzSubmissionStatus status;
  final PhoneNumber phoneNumber;
  final bool isValid;
  const LoginState({
    this.status = FormzSubmissionStatus.initial,
    this.phoneNumber = const PhoneNumber.pure(),
    this.isValid = false,
  });

  LoginState copyWith({
    FormzSubmissionStatus? status,
    PhoneNumber? phoneNumber,
    bool? isValid,
  }) {
    return LoginState(
      status: status ?? this.status,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      isValid: isValid ?? this.isValid,
    );
  }

  @override
  List<Object> get props => [status, phoneNumber, isValid];
}
