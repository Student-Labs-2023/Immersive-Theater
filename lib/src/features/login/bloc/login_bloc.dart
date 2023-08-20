import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({required AuthenticationRepositoryImpl authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(const LoginState()) {
    on<LoginPhoneNumberChanged>(_onLoginPhoneNumberChanged);
    on<LoginVerifyPhoneNumber>(_onLoginVerifyPhoneNumber);
    on<LoginVerifyOTP>(_onLoginVerifyOTP);
  }

  static const String countryCode = '+7';
  final AuthenticationRepositoryImpl _authenticationRepository;

  void _onLoginPhoneNumberChanged(
    LoginPhoneNumberChanged event,
    Emitter<LoginState> emit,
  ) {
    final phoneNumber = PhoneNumber.dirty(event.phoneNumber);
    emit(
      state.copyWith(
        phoneNumber: phoneNumber,
        isValidPassword: Formz.validate([phoneNumber]),
        status: FormzSubmissionStatus.inProgress,
      ),
    );
  }

  void _onLoginVerifyPhoneNumber(
    LoginVerifyPhoneNumber event,
    Emitter<LoginState> emit,
  ) {
    try {
      _authenticationRepository.verifyPhoneNumber(
        phoneNumber: state.phoneNumber.value.trim(),
      );
      emit(state.copyWith(status: FormzSubmissionStatus.success));
    } catch (e) {
      emit(state.copyWith(status: FormzSubmissionStatus.failure));
    }
  }

  void _onLoginVerifyOTP(
    LoginVerifyOTP event,
    Emitter<LoginState> emit,
  ) async {
    try {
      emit(state.copyWith(isValidCode: true));
      await _authenticationRepository.verifyOTP(smsCode: event.smsCode);
    } catch (e) {
      emit(state.copyWith(isValidCode: false));
    }
  }
}
