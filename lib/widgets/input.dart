import 'package:flutter/material.dart';

Widget CustomInput({String? labelText, Widget? prefixIcon, TextEditingController? textEditingController}) {
  return Container(
    padding: const EdgeInsets.only(top: 4),
    decoration:const BoxDecoration(
        color: Color.fromRGBO(248, 248, 248, 1),
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(8),topRight: Radius.circular(8))),
    child: TextFormField(
      controller: textEditingController,
      decoration: InputDecoration(
        prefixIcon: prefixIcon ?? prefixIcon,
        labelText: labelText,
      ),
    ),
  );
}
