import 'package:formz/formz.dart';

enum PhoneNumberError { empty }

class PhoneNumber extends FormzInput<String, PhoneNumberError> {
  const PhoneNumber.pure() : super.pure('');

  const PhoneNumber.dirty({String value = ''}) : super.dirty(value);

  @override
  PhoneNumberError? validator(String value) {
    return value.isEmpty ? PhoneNumberError.empty : null;
  }
}
