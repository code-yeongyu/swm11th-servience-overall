import 'package:flutter/material.dart';

Widget outlineBorderTextFormField(String hintText, bool isObservable) {
  return TextFormField(
      obscureText: !isObservable,
      decoration: InputDecoration(hintText: hintText, border: const OutlineInputBorder())
  );
}