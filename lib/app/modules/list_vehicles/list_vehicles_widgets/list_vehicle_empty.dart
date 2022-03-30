

import 'package:flutter/cupertino.dart';

Widget listVehicleEmpty(double _height){
  return Center(
    child: ListView(
      shrinkWrap: true,
      children: [
        Container(
          height: _height-200,
          alignment: Alignment.center,
          child: const Text('Sin vehiculos en stock'),
        )
      ],
    ),
  );
}