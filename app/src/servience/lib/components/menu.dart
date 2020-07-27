import 'package:flutter/material.dart';

String _beautifyPrice(int price) {
  String stringPrice = price.toString();
  int stringLength = stringPrice.length;
  if (stringLength > 3) {
    for (int i = stringLength - 3; i > 0; i -= 3) {
      stringPrice = stringPrice.substring(0, i) +
          "," +
          stringPrice.substring(i, stringLength);
    }
  }
  return "₩ " + stringPrice;
}

Widget menuItem(String imageUrl, String name, int price) {
  return Container(
      height: 70,
      child: Row(children: <Widget>[
        imageUrl != null
            ? ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.network(imageUrl),
              )
            : Container(),
        Padding(
            padding: const EdgeInsets.only(left: 20, top: 10),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(name,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
              Text("${_beautifyPrice(price)}", textAlign: TextAlign.left)
            ]))
      ]));
}
