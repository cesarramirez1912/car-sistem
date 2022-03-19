import 'package:car_system/app/global_widgets/spacing.dart';
import 'package:flutter/material.dart';

import '../core/utils/money_format.dart';

Widget cardDeudor(Map<String, dynamic> deudor, bool isCuote, Function onTap,
    {bool withDate = true, withDaysOrMonth}) {
  Widget conditionalRender(dynamic total, String text) {
    return total != null
        ? Text(
            text + total.toString() + (total == 1 ? ' cuota' : ' cuotas'),
            style: const TextStyle(color: Colors.red),
          )
        : Container();
  }

  if (deudor['total_deuda_guaranies'] != null) {
    if (deudor['total_deuda_guaranies'] < 0) {
      deudor['total_deuda_guaranies'] = 0;
    }
  }

  if (deudor['total_deuda_dolares'] != null) {
    if (deudor['total_deuda_dolares'] < 0) {
      deudor['total_deuda_guaranies'] = 0;
    }
  }

  bool isClean = (deudor['total_deuda_guaranies'] == 0 &&
          deudor['total_deuda_guaranies'] != null) &&
      (deudor['total_deuda_dolares'] == 0 &&
          deudor['total_deuda_dolares'] != null);

  return Container(
    margin: const EdgeInsets.only(right: 5, left: 5, top: 2),
    child: Card(
      child: ListTile(
        onTap: () => onTap(),
        title: Text(deudor['cliente'].toString()),
        subtitle: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            withDate
                ? Text(
                    'Vencimiento: ' + deudor['fecha'],
                    style:
                        TextStyle(color: isClean ? Colors.green : Colors.red),
                  )
                : Container(),
            deudor['total_deuda_guaranies'] != 0 &&
                    deudor['total_deuda_guaranies'] != null
                ? Text(
                    MoneyFormat()
                        .formatCommaToDot(
                            (deudor['total_deuda_guaranies'] ?? 0))
                        .toString(),
                    style: const TextStyle(color: Colors.red),
                  )
                : Container(),
            deudor['total_deuda_dolares'] != 0 &&
                    deudor['total_deuda_dolares'] != null
                ? Text(
                    MoneyFormat()
                        .formatCommaToDot((deudor['total_deuda_dolares'] ?? 0),
                            isGuaranies: false)
                        .toString(),
                    style: const TextStyle(color: Colors.red))
                : Container(),
            !isClean && withDaysOrMonth
                ? conditionalRender(deudor['bajo'], 'Hasta 30 dias: ')
                : Container(),
            withDaysOrMonth
                ? conditionalRender(deudor['medio'], 'De 1 a 3 meses: ')
                : Container(),
            withDaysOrMonth
                ? conditionalRender(deudor['alto'], 'Más de 3 meses: ')
                : Container(),
            CustomSpacing(height: 6),
          ],
        ),
        trailing: const Icon(Icons.chevron_right_sharp),
      ),
    ),
  );
}
