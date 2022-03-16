import 'package:car_system/app/global_widgets/vehicle_detail_card.dart';
import 'package:flutter/material.dart';
import '../core/utils/money_format.dart';
import '../data/models/vehicle.dart';

Widget VehicleDetails(Vehicle vehicle,
    {double heithImage = 180, bool withImage = true, bool withPrice = true}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      withImage
          ? Container(
              height: heithImage,
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
            )
          : Container(),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           vehicle.contadoGuaranies!=null && withPrice ? Text(
              MoneyFormat().formatCommaToDot(vehicle.contadoGuaranies),
              style: const TextStyle(
                  color: Color.fromRGBO(72, 72, 72, 1),
                  fontSize: 18,
                  fontWeight: FontWeight.w700),
            ) : Container(),
            vehicle.contadoDolares!=null && withPrice ? Text(
              MoneyFormat()
                  .formatCommaToDot(vehicle.contadoDolares, isGuaranies: false),
              style: const TextStyle(
                  color: Color.fromRGBO(72, 72, 72, 1),
                  fontSize: 18,
                  fontWeight: FontWeight.w700),
            ) : Container(),
            (vehicle.contadoDolares!=null ||  vehicle.contadoGuaranies!=null)&& withPrice ? const SizedBox(
              height: 10,
            ) : Container(),
            (vehicle.contadoDolares!=null ||  vehicle.contadoGuaranies!=null)&& withPrice ? const Divider(
              color: Colors.grey,
            ) : Container(),
            (vehicle.contadoDolares!=null ||  vehicle.contadoGuaranies!=null)&& withPrice ? const SizedBox(
              height: 10,
            ) : Container(),
            CustomVehicleDetailCard(vehicle)
          ],
        ),
      )
    ],
  );
}
