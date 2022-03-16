import 'package:flutter/material.dart';

Widget textInputContainer(String text, String value, {Function? onTap}) {
  return GestureDetector(
    onTap: () => onTap!(),
    child: Stack(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          margin: const EdgeInsets.only(top: 10),
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(4)),
              border: Border.all(color: Colors.grey)),
          child: Text(value, style: const TextStyle(fontSize: 16)),
        ),
        Positioned(
          top: 0,
          left: 10,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            color: Colors.white,
            child: Text(
              text,
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
          ),
        ),
      ],
    ),
  );
}