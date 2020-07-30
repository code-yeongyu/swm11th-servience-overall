import 'package:flutter/material.dart';
import 'package:servience/utils/beautifyPrice.dart';

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
              Text("${beautifyPrice(price)}", textAlign: TextAlign.left)
            ]))
      ]));
}
