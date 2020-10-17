import 'package:shared_preferences/shared_preferences.dart';

void setLogin(String username, String password) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool('isLoggedIn', true);
  prefs.setString('username', username);
  prefs.setString('password', password);
}

void setLogout() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool('isLoggedIn', true);
  prefs.remove('username');
  prefs.remove('password');
}

Future<bool> getIsLoggedIn() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  return isLoggedIn;
}

Future<Map<String, String>> getLoginStatus() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return {"username": prefs.get("username"), "password": prefs.get("password")};
}
