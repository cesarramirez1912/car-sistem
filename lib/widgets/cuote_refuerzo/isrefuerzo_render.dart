import 'package:car_system/colors.dart';
import 'package:car_system/common/date_format.dart';
import 'package:car_system/common/money_format.dart';
import 'package:car_system/models/cuote_detail_model.dart';
import 'package:car_system/models/refuerzo_detail_model.dart';
import 'package:car_system/views/dates_venc_cuotes_view.dart';
import 'package:car_system/widgets/cuote_refuerzo/center_text.dart';
import 'package:car_system/widgets/cuote_refuerzo/column_text.dart';
import 'package:car_system/widgets/cuote_refuerzo/columns.dart';
import 'package:car_system/widgets/cuote_refuerzo/pendiente_text.dart';
import 'package:flutter/material.dart';

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
