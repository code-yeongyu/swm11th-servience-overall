import 'dart:async';

import 'package:flutter/material.dart';
import 'package:servience/components/menu.dart';
import 'package:servience/models/item.dart';
import 'package:servience/utils/beautifyPrice.dart';

class PurchasementPage extends StatefulWidget {
  final List<DrinkItem> basket;
  final int sum;
  PurchasementPage({Key key, @required this.basket, @required this.sum})
      : super(key: key);
  @override
  _PurchasementPageState createState() =>
      _PurchasementPageState(basket: this.basket, sum: this.sum);
}

class _PurchasementPageState extends State<PurchasementPage> {
  final List<DrinkItem> basket;
  int sum;
  _PurchasementPageState({@required this.basket, @required this.sum});

  int _getSum() {
    int sum = 0;
    this.basket.forEach((item) {
      sum += item.price;
    });
    return sum;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: SizedBox(
          width: double.infinity,
          child: RaisedButton(
              color: Colors.amber,
              onPressed: () {
                Navigator.pushNamed(context, '/thanks');
                Timer(Duration(seconds: 3), () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                  // navigator hack: to pop thanks page and the purchasement page at the same time.
                });
              },
              child: Text("Total ${beautifyPrice(this._getSum())}")),
        ),
        appBar: AppBar(title: Text("Purchase")),
        body: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: basket.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
                title: Column(children: <Widget>[
              Row(children: <Widget>[
                menuItem(basket[index].imageURL, basket[index].name,
                    basket[index].price),
                Spacer(),
                IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      setState(() {
                        this.sum -= basket[index].price;
                        basket.removeAt(index);
                      });
                    })
              ]),
              const Padding(padding: const EdgeInsets.all(4))
            ]));
          },
        ));
  }
}
