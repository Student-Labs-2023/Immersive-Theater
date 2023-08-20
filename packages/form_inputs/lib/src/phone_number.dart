import 'package:formz/formz.dart';

enum PhoneNumberValidationError { invalid }

class PhoneNumber extends FormzInput<String, PhoneNumberValidationError> {
  const PhoneNumber.pure([super.value = '+7']) : super.pure();

  const PhoneNumber.dirty([super.value = '']) : super.dirty();

  static final _phonedRegex = RegExp(
      r'^(\+7|7|8)?[\s\-]?\(?[489][0-9]{2}\)?[\s\-]?[0-9]{3}[\s\-]?[0-9]{2}[\s\-]?[0-9]{2}$');

  @override
  PhoneNumberValidationError? validator(String value) {
    return _phonedRegex.hasMatch(value)
        ? null
        : PhoneNumberValidationError.invalid;
  }
}
