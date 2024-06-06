import 'package:http/http.dart' as http;

Future<bool> checkInternetAccess() async {
  try {
    final response = await http.get(Uri.parse('https://www.google.com'));
    if (response.statusCode == 200) {
      print('Internet access confirmed');
      return true;
    } else {
      print('No internet access');
      return false;
    }
  } catch (_) {
    return false;
  }
}
