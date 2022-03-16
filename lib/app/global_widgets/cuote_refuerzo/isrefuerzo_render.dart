import 'package:car_system/app/data/models/refuerzo_detail_model.dart';
import '../../core/theme/colors.dart';
import 'package:flutter/material.dart';
import '../../core/utils/date_format.dart';
import 'center_text.dart';
import 'column_text.dart';
import 'columns.dart';
import 'pendiente_text.dart';

Widget isRefuerzo(List<RefuerzoDetailModel> lista, Function onSelectChanged) {
  List<Widget> faltanteRefuerzoSection(RefuerzoDetailModel refuerzo) {
    if (refuerzo.fechaPago != null) {
      if (refuerzo.pagoGuaranies != null) {
        double faltante = (double.parse(refuerzo.refuerzoGuaranies.toString()) -
            double.parse(refuerzo.pagoGuaranies.toString()));
        return [
          pendienteText(faltante),
        ];
      } else {
        double faltante = (double.parse(refuerzo.refuerzoDolares.toString()) -
            double.parse(refuerzo.pagoDolares.toString()));
        return [
          pendienteText(faltante, isGuaranies: false),
        ];
      }
    } else {
      if (refuerzo.refuerzoGuaranies != null) {
        return [centerText(refuerzo.refuerzoGuaranies)];
      } else {
        return [centerText(refuerzo.refuerzoDolares, isGuaranies: false)];
      }
    }
  }

  List<Widget> priceRefuerzoSection(RefuerzoDetailModel refuerzo) {
    if (refuerzo.fechaPago != null) {
      if (refuerzo.pagoGuaranies != null) {
        return [
          ...columnText(refuerzo.pagoGuaranies, refuerzo.fechaPago),
        ];
      } else {
        return [
          ...columnText(refuerzo.pagoDolares, refuerzo.fechaPago,
              isGuaranies: false),
        ];
      }
    } else {
      return [
        const Text(
          'Pediente',
          textAlign: TextAlign.center,
          style: TextStyle(color: ColorPalette.PRIMARY, fontSize: 12),
        ),
      ];
    }
  }

  Widget priceRefuerzoVencSection(RefuerzoDetailModel refuerzo) {
    if (refuerzo.refuerzoGuaranies != null) {
      return centerText(refuerzo.refuerzoGuaranies);
    } else {
      return centerText(refuerzo.refuerzoDolares,
          colorText: Colors.black, isGuaranies: false);
    }
  }

  return DataTable(
      columnSpacing: 0,
      dataRowHeight: 80,
      showCheckboxColumn: false,
      rows: List.generate(
        lista.length,
        (i) => DataRow(
            onSelectChanged: (selected) => onSelectChanged(lista[i]),
            cells: [
              DataCell(
                Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    priceRefuerzoVencSection(lista[i]),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      DateFormatBr().formatBrFromString(
                          lista[i].fechaRefuerzo.toString()),
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 12),
                    ),
                    lista[i].anosMesesDias != null
                        ? const SizedBox(
                            height: 4,
                          )
                        : const SizedBox(),
                    lista[i].anosMesesDias != null
                        ? Text(
                            lista[i].anosMesesDias ?? '',
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 12),
                            textAlign: TextAlign.center,
                          )
                        : const SizedBox()
                  ],
                ),
              ),
              DataCell(
                Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [...priceRefuerzoSection(lista[i])],
                ),
              ),
              DataCell(
                Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [...faltanteRefuerzoSection(lista[i])],
                ),
              ),
            ]),
      ),
      columns: dataColumn());
}
