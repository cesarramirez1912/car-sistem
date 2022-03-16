import 'package:car_system/common/money_format.dart';
import 'package:flutter/material.dart';

import '../../app/data/models/cuotes.dart';
import '../plan.dart';
import '../title.dart';

List<Widget> guaraniesRender(Cuota cuota) {
  return [
    CustomTitle('Plan guaranies'),
    planText(
      'Entrada',
          MoneyFormat().formatCommaToDot(
            cuota.entradaGuaranies,
          ),
    ),
    planText(
      'Cuota',
          MoneyFormat().formatCommaToDot(
            cuota.cuotaGuaranies,
          ),
    ),
    planText(
      'Refuerzo',
          MoneyFormat().formatCommaToDot(
            cuota.refuerzoGuaranies,
          ),
    ),
  ];
}
