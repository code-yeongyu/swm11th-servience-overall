import 'package:flutter/material.dart';
import 'package:servience/page/first.dart';
import 'package:servience/page/login.dart';
import 'package:servience/page/registration.dart';

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
        '/registration': (context) => RegistrationPage()
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}
