import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  static late SharedPreferences prefs;

  static Future<void> initSharedPreference() async {
    prefs = await SharedPreferences.getInstance();
  }

  static Future<void> setString(
      {required String key, required String value}) async {
    await prefs.setString(key, value);
  }

  static String? getString({required String key}) {
    return prefs.getString(key);
  }
}
