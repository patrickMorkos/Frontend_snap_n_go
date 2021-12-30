import 'package:shared_preferences/shared_preferences.dart';

bool status = false;

///Function to save the user status if LoggedIn or not
Future isLoggedIn() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool('auth', status);
  return prefs.getBool('auth') ?? false;
}

void switchStatus(bool sts) {
  status = sts;
}
