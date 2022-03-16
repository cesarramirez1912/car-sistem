import 'package:car_system/common/money_format.dart';
import 'package:flutter/material.dart';
import '../../app/data/models/cuotes.dart';
import '../plan.dart';
import '../title.dart';

List<Widget> totalesRender(Cuota cuota, showDolares, showGuaranies) {
  return [
    CustomTitle('Plan total'),
    showGuaranies
        ? planText(
            'Guaranies',
            MoneyFormat().formatCommaToDot(
              (verifyIsStringToDouble(cuota.cuotaGuaranies) *
                      verifyIsStringToDouble(cuota.cantidadCuotas)) +
                  ((verifyIsStringToDouble(cuota.cantidadRefuerzo)) *
                      (verifyIsStringToDouble(cuota.refuerzoGuaranies))) +
                  (verifyIsStringToDouble(cuota.entradaGuaranies)),
            ),
          )
        : SizedBox(),
    showDolares
        ? planText(
            'Dolares',
            MoneyFormat().formatCommaToDot(
                (verifyIsStringToDouble(cuota.cuotaDolares) *
                        verifyIsStringToDouble(cuota.cantidadCuotas)) +
                    ((verifyIsStringToDouble(cuota.cantidadRefuerzo)) *
                        (verifyIsStringToDouble(cuota.refuerzoDolares))) +
                    (verifyIsStringToDouble(cuota.entradaDolares)),
                isGuaranies: false),
          )
        : Container(),
  ];
}

double verifyIsStringToDouble(dynamic value) {
  if (value == null) {
    return 0;
  } else {
    try {
      return double.parse(value);
    } catch (e) {
      return double.parse(value.toString());
    }
  }
}
