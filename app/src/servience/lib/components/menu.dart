import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

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

Widget menuElement(String image_url, String name, int price) {
  return Container(
      height: 70,
      child: Row(children: <Widget>[
        image_url != null
            ? ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.network(image_url),
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
