import 'package:flutter/material.dart';

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
                      TextFormField(
                          decoration: const InputDecoration(hintText: 'Username', border: const OutlineInputBorder())
                      ),
                      Padding(padding: const EdgeInsets.all(10)),
                      TextFormField(
                          obscureText: true,
                          decoration: const InputDecoration(hintText: 'Password', border: const OutlineInputBorder())
                      ),
                      Padding(padding: const EdgeInsets.all(10)),
                      TextFormField(
                          decoration: const InputDecoration(hintText: 'Nickname', border: const OutlineInputBorder())
                      )
                    ]
                )
            )
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: FlatButton(
                color: const Color(0xFF019CB7),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                ),
                onPressed: () {
                  // Validate will return true if the form is valid, or false if
                  // the form is invalid.
                  /*if (_formKey.currentState.validate()) {
                    // Process data.
                  }*/
                },
                child: Text('Submit', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}