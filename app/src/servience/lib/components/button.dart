import 'package:flutter/material.dart';

FlatButton servienceRoundedButton(Color color, VoidCallback onPressed, String text) {
  return FlatButton(
    color: color,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(18.0),
    ),
    onPressed: onPressed,
    child: Text(text, style: TextStyle(color: Colors.white)),
  );
}