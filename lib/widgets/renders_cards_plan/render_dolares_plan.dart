import 'package:car_system/common/money_format.dart';
import 'package:car_system/models/cuotes.dart';
import 'package:flutter/material.dart';

import '../plan.dart';
import '../title.dart';

List<Widget> dolaresRender(Cuota cuota) {
  return [
    CustomTitle('Plan dólares'),
    planText(
        'Entrada',
        MoneyFormat()
            .formatCommaToDot(cuota.entradaDolares, isGuaranies: false)),
    planText('Cuota',
        MoneyFormat().formatCommaToDot(cuota.cuotaDolares, isGuaranies: false)),
    planText(
      'Refuerzo',
      MoneyFormat().formatCommaToDot(cuota.refuerzoDolares, isGuaranies: false),
    )
  ];
}
