import 'package:flutter/material.dart';
import 'package:servience/components/menu.dart';

class MenuPage extends StatefulWidget {
  MenuPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  var menuInfo = [
    {
      "image_url":
          "https://image.auction.co.kr/itemimage/1a/12/30/1a12307236.jpg",
      "name": "자바칩 프라푸치노",
      "price": 6500
    },
    {
      "image_url":
          "https://lh3.googleusercontent.com/proxy/sRg5n6_QB4ZepcUkhFDmVuW89000Hm1X5C-6ioru1aeJIJWvxiQyHTwMGqmu_2uINcerqFYWmn-ndw3Sc_uknNeSVStpzPt9vAgG_U_n8YLy0iBxtao",
      "name": "카라멜 프라푸치노",
      "price": 5600
    }
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Menu")),
      body: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: menuInfo.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              child: Column(children: <Widget>[
                menuItem(menuInfo[index]["image_url"], menuInfo[index]["name"],
                    menuInfo[index]["price"]),
                const Padding(padding: const EdgeInsets.all(4))
              ]),
            );
          }),
    );
  }
}
