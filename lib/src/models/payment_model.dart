import 'package:http/http.dart' as http;

class Payment {
  Future<http.Response> getLink(
    String email,
    String event,
    String amount,
  ) async {
//    https: //shebalin.na4u.ru/?email={email}&event=shebalin&amount=1
    var url = Uri.https(
      'shebalin.na4u.ru',
      '/',
      {'email': email, 'event': event, 'amount': amount},
    );
    var response = await http.get(url);
    return response;
  }
}
