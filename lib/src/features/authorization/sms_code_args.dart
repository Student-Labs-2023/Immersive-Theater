import 'package:firebase_auth/firebase_auth.dart';

class SMSCodeArgs {
  SMSCodeArgs({required this.number, required this.auth});
  String number;
  FirebaseAuth auth;
}
