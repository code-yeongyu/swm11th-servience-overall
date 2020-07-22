import 'package:flutter/material.dart';
import 'package:servience/components/button.dart';
import 'package:servience/components/textField.dart';

class RegistrationPage extends StatefulWidget {
  RegistrationPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("CREATE A NEW ACCOUNT"),
            Padding(padding: const EdgeInsets.all(20), child:Form(
              //key: _formKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      outlineBorderTextFormField("Username", false),
                      Padding(padding: const EdgeInsets.all(10)),
                      outlineBorderTextFormField("Password", true),
                      Padding(padding: const EdgeInsets.all(10)),
                      outlineBorderTextFormField("Nickname", false),
                    ]
                )
            )
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: roundedButton(Colors.blue[400], () {}, "Submit"),
            ),
          ],
        ),
      ),
    );
  }
}