import 'package:flutter/material.dart';
import 'package:gradient_text/gradient_text.dart';

class ThanksPage extends StatefulWidget {
  @override
  Thanks createState() => Thanks();
}

class Thanks extends State<ThanksPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
          GradientText("Thanks!",
              gradient: LinearGradient(
                  colors: [Colors.deepPurple, Colors.deepOrange, Colors.pink]),
              style: TextStyle(fontSize: 42),
              textAlign: TextAlign.center),
          Text("You can back to the menu page after 3 seconds.",
              style: TextStyle(fontSize: 15))
        ])));
  }
}
