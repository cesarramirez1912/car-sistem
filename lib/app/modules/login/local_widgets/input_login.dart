import 'package:flutter/material.dart';

Widget CustomInputLogin(
    {String? labelText,
    Widget? prefixIcon,
    TextEditingController? textEditingController,
    Widget? suffixIcon,
    bool obscureText = false}) {
  return Container(
    padding: const EdgeInsets.only(top: 4),
    decoration: const BoxDecoration(
        color: Color.fromRGBO(248, 248, 248, 1),
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8), topRight: Radius.circular(8))),
    child: TextFormField(
      obscureText: obscureText,
      controller: textEditingController,
      decoration: InputDecoration(
        suffixIcon: suffixIcon ?? suffixIcon,
        prefixIcon: prefixIcon ?? prefixIcon,
        labelText: labelText,
      ),
    ),
  );
}
