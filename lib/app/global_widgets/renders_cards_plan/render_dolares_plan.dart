import 'package:flutter/material.dart';

import '../../core/utils/money_format.dart';
import '../../data/models/cuotes.dart';
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
