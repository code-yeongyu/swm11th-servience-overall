import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';
import 'package:servience/config/baseURL.dart';
import 'package:servience/utils/sharedPreferencesAccesor.dart';
import 'package:servience/models/providerModels.dart';

class FirstUserPage extends StatefulWidget {
  _FirstUserPageState createState() => _FirstUserPageState();
  FirstUserPage({Key key}) : super(key: key);
}

class _FirstUserPageState extends State<FirstUserPage> {
  Future<String> _requestLogin(String username, String password) async {
    final response = await http.post(baseURL + "/user/auth",
        body: {"username": username, "password": password});
    return response.statusCode == 200
        ? jsonDecode(response.body)['token']
        : null;
  }

  @override
  void initState() {
    super.initState();
    getIsLoggedIn().then((isLoggedIn) {
      if (isLoggedIn) {
        var loginStatus = Provider.of<LoginStatus>(context, listen: false);
        loginStatus.setLoggedIn(isLoggedIn);
        getLoginStatus().then(
          (loginStatus) {
            debugPrint("loginStatus: " + loginStatus.toString());
            _requestLogin(loginStatus['username'], loginStatus['password'])
                .then((token) {
              if (token == null) {
                var loginStatus =
                    Provider.of<LoginStatus>(context, listen: false);
                loginStatus.setLoggedIn(false);
                setLogout();
                return;
              }
              final loginStatus =
                  Provider.of<LoginStatus>(context, listen: false);
              loginStatus.setToken(token);
            });
          },
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(children: <Widget>[
      Stack(children: <Widget>[
        Container(
            child: Image.network(
              'https://cdn.trendhunterstatic.com/thumbs/softbanks-pepper-robot.jpeg',
            ),
            height: 280),
        Padding(
            padding: const EdgeInsets.only(top: 240, left: 10),
            child: const Text(
              'Servience Cafe',
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 22.0),
            ))
      ]),
      Padding(
          padding:
              const EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 40),
          child: const Text("Welcome to Servience Cafe",
              style:
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
      FlatButton(
        color: Colors.blue[400],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
        onPressed: () {
          Navigator.pushNamed(context, '/registration');
        },
        child: const Text(
          "Registration",
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      const Padding(padding: const EdgeInsets.all(20)),
      FlatButton(
        color: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
            side: BorderSide(color: Colors.blue[400])),
        onPressed: () {
          Navigator.pushNamed(context, '/login');
        },
        child: Text(
          "Login",
          style:
              TextStyle(color: Colors.blue[400], fontWeight: FontWeight.bold),
        ),
      )
    ])) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
