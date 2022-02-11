import 'package:car_system/colors.dart';
import 'package:car_system/common/date_format.dart';
import 'package:car_system/models/cuote_detail_model.dart';
import 'package:car_system/widgets/cuote_refuerzo/center_text.dart';
import 'package:car_system/widgets/cuote_refuerzo/column_text.dart';
import 'package:car_system/widgets/cuote_refuerzo/columns.dart';
import 'package:car_system/widgets/cuote_refuerzo/pendiente_text.dart';
import 'package:flutter/material.dart';

Widget isCuote(List<CuoteDetailModel> lista, Function onSelectChanged) {
  List<Widget> faltanteSection(CuoteDetailModel cuote) {
    if (cuote.fechaPago != null) {
      if (cuote.pagoGuaranies != null) {
        double faltante = (double.parse(cuote.cuotaGuaranies.toString()) -
            double.parse(cuote.pagoGuaranies.toString()));
        return [pendienteText(faltante)];
      } else {
        double faltante = (double.parse(cuote.cuotaDolares.toString()) -
            double.parse(cuote.pagoDolares.toString()));
        return [pendienteText(faltante, isGuaranies: false)];
      }
    } else {
      if (cuote.cuotaGuaranies != null) {
        return [
          centerText(
            cuote.cuotaGuaranies,
          )
        ];
      } else {
        return [centerText(cuote.cuotaDolares, isGuaranies: false)];
      }
    }
  }

  List<Widget> pricePagoSection(CuoteDetailModel cuote) {
    if (cuote.fechaPago != null) {
      if (cuote.pagoGuaranies != null) {
        return [
          ...columnText(cuote.pagoGuaranies, cuote.fechaPago),
        ];
      } else {
        return [
          ...columnText(cuote.pagoDolares, cuote.fechaPago, isGuaranies: false),
        ];
      }
    } else {
      return [
        const Text(
          'Pediente',
          textAlign: TextAlign.center,
          style: TextStyle(color: ColorPalette.PRIMARY,fontSize: 12),
        ),
      ];
    }
  }

  Widget priceVencSection(CuoteDetailModel cuote) {
    if (cuote.cuotaGuaranies != null) {
      return centerText(cuote.cuotaGuaranies, colorText: Colors.black);
    } else {
      return centerText(cuote.cuotaDolares,
          colorText: Colors.black, isGuaranies: false);
    }
  }

  return DataTable(
      columnSpacing: 0,
      dataRowHeight: 85,
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
                  priceVencSection(lista[i]),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    DateFormatBr()
                        .formatBrFromString(lista[i].fechaCuota.toString()),
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
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [...pricePagoSection(lista[i])],
              ),
            ),
            DataCell(
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [...faltanteSection(lista[i])],
              ),
            ),
          ],
        ),
      ),
      columns: dataColumn());
}
