import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget CustomButton(String text, Function onPressed, Color color,
    {bool withShadow = false}) {
  return ElevatedButton(
    child: Text(text),
    onPressed:  ()=> onPressed(),
    style: ElevatedButton.styleFrom(
      elevation: withShadow?2:0,
      primary: color,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      textStyle: const TextStyle(
        fontWeight: FontWeight.w500
      ),
    ),
  );
}
