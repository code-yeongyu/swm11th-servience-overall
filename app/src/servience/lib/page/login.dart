import 'package:flutter/material.dart';
import 'package:servience/components/button.dart';
import 'package:servience/components/textField.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text("LOGIN WITH YOUR ACCOUNT"),
            Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                    //key: _formKey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                      outlineBorderTextFormField("Username", false),
                      const Padding(padding: const EdgeInsets.all(10)),
                      outlineBorderTextFormField("Password", true)
                    ]))),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: roundedButton(Colors.blue[400], () {}, "Login"),
            ),
          ],
        ),
      ),
    );
  }
}
