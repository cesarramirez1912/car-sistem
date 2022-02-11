import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget CustomSearchInput(
    {String? hintText,
    Function? onChanged,
    TextEditingController? controller,
    Function? onClean}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    alignment: Alignment.topLeft,
    margin: const EdgeInsets.only(right: 10, left: 10, bottom: 10),
    decoration: const BoxDecoration(
        color: Color.fromRGBO(248, 248, 248, 1),
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        )),
    child: TextFormField(
      autofocus: false,
      onChanged: (text) => onChanged!(text),
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        border: InputBorder.none,
        suffixIcon: IconButton(
          onPressed: () {
            onClean!();
            controller?.clear();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          icon: const Icon(Icons.clear),
        ),
      ),
    ),
  );
}
