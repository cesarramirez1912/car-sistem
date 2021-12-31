import 'package:car_system/common/money_format.dart';
import 'package:car_system/models/vehicle.dart';
import 'package:car_system/widgets/title.dart';
import 'package:flutter/material.dart';

Widget VehicleDetails(Vehicle? _vehicle) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        height: 180,
        color: const Color.fromRGBO(235, 235, 235, 1),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              Icons.image,
              size: 150,
              color: Color.fromRGBO(225, 225, 225, 1),
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "G\$ ${MoneyFormat().formatCommaToDot(_vehicle?.contadoGuaranies)}",
              style: const TextStyle(
                  color: Color.fromRGBO(72, 72, 72, 1),
                  fontSize: 18,
                  fontWeight: FontWeight.w700),
            ),
            Text(
              "U\$ ${MoneyFormat().formatCommaToDot(_vehicle?.contadoDolares)}",
              style: const TextStyle(
                  color: Color.fromRGBO(72, 72, 72, 1),
                  fontSize: 18,
                  fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: 10,
            ),
            const Divider(
              color: Colors.grey,
            ),
            const SizedBox(
              height: 10,
            ),
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
                CustomTitle(_vehicle?.modelo ?? '-',)
              ],
            ),
            const SizedBox(
              height: 6,
            ),
            SizedBox(
              height: 100,
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
          ],
        ),
      )
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
