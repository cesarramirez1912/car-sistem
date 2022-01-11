import 'package:car_system/common/money_format.dart';
import 'package:car_system/models/cuotes.dart';
import 'package:car_system/widgets/renders_cards_plan/render_dolares_plan.dart';
import 'package:car_system/widgets/renders_cards_plan/render_guaranies_plan.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../plan.dart';
import '../title.dart';

Widget renderCuotas(Cuota cuota, {String? textRender}) {
  List<Widget> listRender() {
    switch (textRender) {
      case 'GUARANIES':
        return guaraniesRender(cuota);
      case 'DOLARES':
        return dolaresRender(cuota);
      default:
        return guaraniesRender(cuota) + dolaresRender(cuota);
    }
  }

  return Container(
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: listRender(),
            )
          ],
        ),
      ],
    ),
  );
}
