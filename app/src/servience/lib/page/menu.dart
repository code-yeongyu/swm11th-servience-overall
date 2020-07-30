import 'package:flutter/material.dart';
import 'package:servience/components/menu.dart';

class MenuPage extends StatefulWidget {
  MenuPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  final List<DrinkItem> items = [
    DrinkItem("http://image.auction.co.kr/itemimage/18/4a/33/184a334256.jpg",
        "에스프레소 프라푸치노", 5100),
    DrinkItem("http://item.ssgcdn.com/93/68/25/item/1000006256893_i1_1200.jpg",
        "카라멜 프라푸치노", 5600),
    DrinkItem("http://image.auction.co.kr/itemimage/18/4a/32/184a32a8b6.jpg",
        "모카 프라푸치노", 5600),
    DrinkItem("http://image.auction.co.kr/itemimage/18/4a/32/184a3264d6.jpg",
        "화이트 초콜릿 모카 프라푸치노", 5700),
    DrinkItem("https://image.auction.co.kr/itemimage/1a/12/30/1a12307236.jpg",
        "자바칩 프라푸치노", 6500),
    DrinkItem("http://item.ssgcdn.com/93/14/52/item/1000040521493_i1_1200.jpg",
        "바닐라 크림 프라푸치노", 4800),
    DrinkItem("http://item.ssgcdn.com/22/15/52/item/1000040521522_i1_1200.jpg",
        "초콜릿 크림 칩 프라푸치노", 5700),
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
