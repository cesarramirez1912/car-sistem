import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
Widget CustomButton(String text, Function onPressed, Color color,
    {bool withShadow = false,
    bool isLoading = false,
    IconData? iconData,
      double? fontSize,
    EdgeInsetsGeometry? edgeInsets}) {
  return ElevatedButton(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(text,style: TextStyle(fontSize: fontSize),),
        iconData != null
            ? const SizedBox(
                width: 5,
              )
            : const SizedBox(),
        iconData != null
            ? Icon(
                iconData,
                size: 20,
              )
            : const SizedBox(),
      ],
    ),
    onPressed: isLoading ? null : () => onPressed(),
    style: ElevatedButton.styleFrom(
      elevation: withShadow ? 2 : 0,
      primary: color,
      padding: edgeInsets ??
          const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      textStyle: const TextStyle(fontWeight: FontWeight.w500),
    ),
  );
}
