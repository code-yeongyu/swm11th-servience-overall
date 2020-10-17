import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:servience/components/button.dart';
import 'package:servience/components/textField.dart';
import 'package:servience/config/baseURL.dart';
import 'package:flutter/foundation.dart';
import 'package:servience/models/providerModels.dart';

class RegistrationPage extends StatefulWidget {
  RegistrationPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  String username;
  String password;
  String nickname;

  Future<int> _requestRegistration() async {
    if (username == null || password == null || nickname == null) {
      return 0;
    }
    final response = await http.post(baseURL + "/user/register", body: {
      "username": username,
      "password": password,
      "nickname": nickname
    });
    return response.statusCode;
  }

  void gotoMenuPage(BuildContext context) async {
    await Navigator.pushReplacementNamed(context, '/menu');
  }

  void loadMenuPage(BuildContext context) {
    Future.microtask(() {
      if (Provider.of<LoginStatus>(context, listen: false).isLoggedIn == true) {
        gotoMenuPage(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    loadMenuPage(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text("CREATE A NEW ACCOUNT"),
            Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                    //key: _formKey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                      outlineBorderTextFormField(
                          "Username", true, (text) => username = text),
                      const Padding(padding: const EdgeInsets.all(10)),
                      outlineBorderTextFormField(
                          "Password", false, (text) => password = text),
                      const Padding(padding: const EdgeInsets.all(10)),
                      outlineBorderTextFormField(
                          "Nickname", true, (text) => nickname = text),
                    ]))),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: roundedButton(Colors.blue[400], () {
                _requestRegistration().then((statusCode) {
                  AlertDialog alert;
                  if (statusCode == 201) {
                    Widget okButton = FlatButton(
                      child: Text("OK"),
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                    );
                    alert = AlertDialog(
                      title: Text("회원가입 성공"),
                      content: Text("회원가입에 성공하였습니다."),
                      actions: [
                        okButton,
                      ],
                    );
                  } else {
                    Widget okButton = FlatButton(
                      child: Text("OK"),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    );
                    alert = AlertDialog(
                      title: Text("회원가입 실패"),
                      content: Text("회원가입에 실패하였습니다."),
                      actions: [
                        okButton,
                      ],
                    );
                  }
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return alert;
                    },
                  );
                });
              }, "Submit"),
            ),
          ],
        ),
      ),
    );
  }
}
