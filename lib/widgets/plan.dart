import 'package:car_system/common/money_format.dart';
import 'package:car_system/models/cuotes.dart';
import 'package:car_system/widgets/title.dart';
import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
Widget CustomPlan(int index, Cuota cuota) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      CustomTitle('Plan n° ${(index + 1).toString()}', fontSize: 17),
      Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(4),
            ),
            border: Border.all(width: 1, color: Colors.grey)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CustomTitle('Cant. Cuotas | Refuerzos'),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                planText('Cant. de cuotas',
                    MoneyFormat().formatCommaToDot(cuota.cantidadCuotas)),
                planText('Cant. de refuerzos',
                    MoneyFormat().formatCommaToDot(cuota.cantidadRefuerzo)),
              ],
            ),
            CustomTitle('Plan guaranies'),
            planText(
              'Entrada',
              'G\$ ' +
                  MoneyFormat().formatCommaToDot(
                    cuota.entradaGuaranies,
                  ),
            ),
            planText(
              'Cuota',
              'G\$ ' +
                  MoneyFormat().formatCommaToDot(
                    cuota.cuotaGuaranies,
                  ),
            ),
            planText(
              'Refuerzo',
              'G\$ ' +
                  MoneyFormat().formatCommaToDot(
                    cuota.refuerzoGuaranies,
                  ),
            ),
            CustomTitle('Plan dólares'),
            planText('Entrada',
                'U\$ ' + MoneyFormat().formatCommaToDot(cuota.entradaDolares)),
            planText('Cuota',
                'U\$ ' + MoneyFormat().formatCommaToDot(cuota.cuotaDolares)),
            planText(
              'Refuerzo',
              'U\$ ' + MoneyFormat().formatCommaToDot(cuota.refuerzoDolares),
            ),
          ],
        ),
      ),
      const SizedBox(
        height: 10,
      )
    ],
  );
}

Widget planText(String left, String rigth) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          left + ':',
        ),
        Text(
          rigth,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
      ],
    ),
  );
}
