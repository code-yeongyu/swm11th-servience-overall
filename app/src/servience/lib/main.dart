import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:servience/models/providerModels.dart';
import 'package:servience/page/first.dart';
import 'package:servience/page/login.dart';
import 'package:servience/page/registration.dart';
import 'package:servience/page/menu.dart';
import 'package:servience/page/thanks.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => LoginStatus(),
          ),
        ],
        child: Consumer<LoginStatus>(builder: (context, counter, _) {
          return MaterialApp(
            initialRoute: '/',
            routes: {
              '/': (context) => FirstUserPage(),
              '/login': (context) => LoginPage(),
              '/registration': (context) => RegistrationPage(),
              '/menu': (context) => MenuPage(),
              '/thanks': (context) => ThanksPage()
            },
            theme: ThemeData(
              primarySwatch: Colors.blue,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
          );
        }));
  }
}
