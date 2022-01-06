import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
Widget CustomTitle(String? text, {double? fontSize}) {
  return Text(
    text!,
    style: TextStyle(
      fontSize: fontSize ?? 18,
      fontWeight: FontWeight.bold,
      color: const Color.fromRGBO(72, 72, 72, 1),
    ),
  );
}
