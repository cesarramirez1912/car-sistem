import 'package:car_system/common/money_format.dart';
import 'package:car_system/models/cuotes.dart';
import 'package:flutter/material.dart';

import '../plan.dart';
import '../title.dart';

List<Widget> dolaresRender(Cuota cuota) {
  return [
    CustomTitle('Plan dólares'),
    planText('Entrada',
        'U\$ ' + MoneyFormat().formatCommaToDot(cuota.entradaDolares)),
    planText(
        'Cuota', 'U\$ ' + MoneyFormat().formatCommaToDot(cuota.cuotaDolares)),
    planText(
      'Refuerzo',
      'U\$ ' + MoneyFormat().formatCommaToDot(cuota.refuerzoDolares),
    )
  ];
}
