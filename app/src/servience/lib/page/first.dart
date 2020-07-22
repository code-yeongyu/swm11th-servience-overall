import 'package:flutter/material.dart';

class FirstUserPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child:Column(
                children: <Widget> [
                  Stack(
                      children: <Widget>[
                        Container(
                            child:Image.network(
                              'https://cdn.trendhunterstatic.com/thumbs/softbanks-pepper-robot.jpeg',
                            ),
                            height:280
                        ),
                        Padding(padding: const EdgeInsets.only(top: 240, left: 10),
                            child: Text(
                              'Servience Cafe',
                              style: TextStyle(color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22.0),
                            )
                        ),

                      ]
                  ),
                  Padding(padding: const EdgeInsets.only(left:20, top:20, right:20, bottom:40), child:Text("Welcome to Servience Cafe", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
                  FlatButton(
                    color: Colors.blue[400],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/registration');
                    },
                    child: Text("Registration", style: TextStyle(color: Colors.white,
                      fontWeight: FontWeight.bold),
                    ),
                  ),

                  Padding(padding: const EdgeInsets.all(20)),
                  FlatButton(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.blue[400])
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    child: Text("Login", style: TextStyle(
                        color: Colors.blue[400],
                        fontWeight: FontWeight.bold),
                    ),
                  )

                ]
            )
        ) // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}