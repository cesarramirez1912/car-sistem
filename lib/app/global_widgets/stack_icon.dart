import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget StackIcon(
    {required Function onTap,
    required IconData primaryIcon,
    required IconData secundaryIcon}) {
  return IconButton(
    onPressed: () => onTap(),
    icon: SizedBox(
      height: 33,
      width: 32,
      child: Stack(
        children: [
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Icon(primaryIcon),
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.topRight,
              child: Icon(
                secundaryIcon,
                size: 18,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
