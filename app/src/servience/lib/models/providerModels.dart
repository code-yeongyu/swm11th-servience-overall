import 'package:flutter/material.dart';

class LoginStatus with ChangeNotifier {
  bool _isLoggedIn = false;
  String _jwtToken = "";

  String get jwtToken => _jwtToken;
  bool get isLoggedIn => _isLoggedIn;

  void setLoggedIn(bool isLoggedIn) {
    _isLoggedIn = isLoggedIn;
    notifyListeners();
  }

  void setToken(String token) {
    _isLoggedIn = true;
    _jwtToken = token;
    notifyListeners();
  }
}
