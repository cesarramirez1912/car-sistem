import 'package:car_system/common/money_format.dart';
import 'package:car_system/models/vehicle.dart';
import 'package:car_system/widgets/title.dart';
import 'package:car_system/widgets/vehicle_detail_card.dart';
import 'package:flutter/material.dart';

Widget VehicleDetails(Vehicle vehicle) {
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
              "G\$ ${MoneyFormat().formatCommaToDot(vehicle.contadoGuaranies)}",
              style: const TextStyle(
                  color: Color.fromRGBO(72, 72, 72, 1),
                  fontSize: 18,
                  fontWeight: FontWeight.w700),
            ),
            Text(
              "U\$ ${MoneyFormat().formatCommaToDot(vehicle.contadoDolares)}",
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
            CustomVehicleDetailCard(vehicle)
          ],
        ),
      )
    ],
  );
}
