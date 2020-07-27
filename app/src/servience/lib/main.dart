import 'package:flutter/material.dart';
import 'package:servience/page/first.dart';
import 'package:servience/page/login.dart';
import 'package:servience/page/registration.dart';
import 'package:servience/page/menu.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => FirstUserPage(),
        '/login': (context) => LoginPage(),
        '/registration': (context) => RegistrationPage(),
        '/menu': (context) => MenuPage(),
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}
