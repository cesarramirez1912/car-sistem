import 'package:car_system/common/money_format.dart';
import 'package:car_system/models/cuotes.dart';
import 'package:flutter/material.dart';

import '../plan.dart';
import '../title.dart';

List<Widget> guaraniesRender(Cuota cuota) {
  return [
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
  ];
}
