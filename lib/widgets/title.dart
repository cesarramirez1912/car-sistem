import 'package:flutter/material.dart';

Widget CustomTitle(String? text, {double? fontSize}) {
  return Text(
    text!,
    style: TextStyle(
      fontSize: fontSize ?? 20,
      fontWeight: FontWeight.bold,
      color: const Color.fromRGBO(72, 72, 72, 1),
    ),
  );
}
