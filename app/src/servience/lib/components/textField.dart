import 'package:flutter/material.dart';

Widget outlineBorderTextFormField(
    String hintText, bool isObservable, ValueChanged<String> onChanged) {
  return TextFormField(
      obscureText: !isObservable,
      onChanged: onChanged,
      autocorrect: false,
      enableSuggestions: false,
      decoration: InputDecoration(
          hintText: hintText, border: const OutlineInputBorder()));
}
