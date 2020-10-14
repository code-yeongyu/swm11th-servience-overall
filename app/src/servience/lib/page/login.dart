import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:servience/config/baseURL.dart';
import 'package:servience/components/button.dart';
import 'package:servience/components/textField.dart';
import 'package:servience/models/providerModels.dart';
import 'package:servience/page/menu.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String username;
  String password;

  Future<String> _requestLogin() async {
    if (username == null || password == null) {
      return null;
    }
    final response = await http.post(baseURL + "/user/auth",
        body: {"username": username, "password": password});
    return response.statusCode == 200
        ? jsonDecode(response.body)['token']
        : null;
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
            const Text("LOGIN WITH YOUR ACCOUNT"),
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
                          "Password", false, (text) => password = text)
                    ]))),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: roundedButton(Colors.blue[400], () {
                _requestLogin().then((token) {
                  if (token == null) {
                    Widget okButton = FlatButton(
                      child: Text("OK"),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    );
                    AlertDialog alert = AlertDialog(
                      title: Text("로그인 실패"),
                      content: Text("입력하신 정보를 다시 확인해주세요."),
                      actions: [
                        okButton,
                      ],
                    );
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return alert;
                      },
                    );
                    return;
                  }
                  final loginStatus =
                      Provider.of<LoginStatus>(context, listen: false);
                  loginStatus.setToken(token);
                  Navigator.pushReplacementNamed(context, '/menu');
                });
              }, "Login"),
            ),
          ],
        ),
      ),
    );
  }
}
