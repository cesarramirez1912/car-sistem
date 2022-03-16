import 'package:car_system/widgets/title.dart';
import 'package:flutter/material.dart';

import '../app/data/models/vehicle.dart';

Column CustomVehicleDetailCard(Vehicle? _vehicle) {
  return Column(
    children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            _vehicle?.marca ?? '-',
            style: const TextStyle(
              color: Color.fromRGBO(72, 72, 72, 1),
            ),
          ),
          const SizedBox(
            width: 4,
          ),
          CustomTitle(
            _vehicle?.modelo ?? '-',
          )
        ],
      ),
      const SizedBox(
        height: 6,
      ),
      SizedBox(
        height: 110,
        child: GridView(
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisExtent: 50,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 1.0,
          ),
          children: [
            gridElement(_vehicle?.cambio ?? '-', 'cambio'),
            gridElement(_vehicle?.ano ?? '-', 'año'),
            gridElement(_vehicle?.motor ?? '-', 'motor'),
            gridElement(_vehicle?.color ?? '-', 'color'),
            gridElement(_vehicle?.combustible ?? '-', 'combustible'),
            gridElement(_vehicle?.chapa ?? '-', 'chapa'),
          ],
        ),
      ),
     _vehicle?.chassis != null ?  gridElement(_vehicle?.chassis??'-', 'chassis') : Container()
    ],
  );
}

Widget gridElement(String text, String title) {
  return Column(
    children: [
      Text(
        title,
        style: const TextStyle(fontSize: 11),
      ),
      Container(
        padding: const EdgeInsets.symmetric(vertical: 5),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(4)),
          border: Border.all(
            color: Colors.grey,
            width: 1,
          ),
        ),
        child: Text(
          text.toUpperCase(),
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        ),
      )
    ],
  );
}
