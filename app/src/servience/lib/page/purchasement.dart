import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:servience/components/menu.dart';
import 'package:servience/models/item.dart';
import 'package:servience/utils/beautifyPrice.dart';
import 'package:http/http.dart' as http;
import 'package:servience/config/baseURL.dart';
import 'package:servience/models/providerModels.dart';
import 'package:provider/provider.dart';

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
  int tableID;

  Future<int> _requestPurchasement() async {
    if (tableID == null) {
      return 0;
    }
    final provider = Provider.of<LoginStatus>(context, listen: false);
    final items = [];
    this.basket.forEach((element) {
      items.add(element.name);
    });

    final response = await http.post(baseURL + "/order",
        headers: {
          "Authorization": "jwt " + provider.jwtToken,
          "Content-Type": "application/json"
        },
        body: json.encode({
          "store_id": "Servience 1th",
          "table_id": tableID,
          "menu": items,
        }));
    // dealing with response
    return response.statusCode;
  }

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
              _requestPurchasement().then((statusCode) {
                Widget okButton = FlatButton(
                  child: Text("OK"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                );
                if (statusCode == 0) {
                  AlertDialog alert = AlertDialog(
                    title: Text("주문 실패"),
                    content: Text("Table ID를 채워주세요."),
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
                } else if (statusCode == 200) {
                  Navigator.pushReplacementNamed(context, '/thanks');
                  return;
                } else {
                  AlertDialog alert = AlertDialog(
                    title: Text("주문 실패"),
                    content: Text("잠시후 재 시도해주세요."),
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
                }
              });
            },
            child: Row(
              children: [
                SizedBox(
                    width: 100,
                    child: TextField(
                        onChanged: (content) {
                          debugPrint(content.runtimeType.toString());
                          tableID = int.parse(content);
                        },
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        ],
                        decoration: InputDecoration(
                          hintText: "Table ID",
                        ))),
                Text("Total ${beautifyPrice(this._getSum())}")
              ],
            ),
          ),
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
