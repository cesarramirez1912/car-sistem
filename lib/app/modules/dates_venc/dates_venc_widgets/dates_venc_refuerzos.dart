import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utils/date_format.dart';
import '../../../core/utils/money_format.dart';
import '../dates_venc_controller.dart';

Widget DateVencRefuerzos(context) {
  DatesVencController controller = Get.find();

  return SingleChildScrollView(
    child: Obx(
      () => DataTable(
        showCheckboxColumn: false,
        rows: List.generate(
          controller.listDateGeneratedRefuerzos.length,
          (i) => DataRow(cells: [
            DataCell(Text((i + 1).toString())),
            DataCell(
              GestureDetector(
                onTap: () => controller.changeDateRefuerzo(context,i),
                child: Container(
                  color: Colors.transparent,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        DateFormatBr().formatBrFromString(
                          controller.listDateGeneratedRefuerzos[i].date
                              .toString(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            DataCell(
              GestureDetector(
                onTap: () => controller.changeValueRefuerzo(context,i),
                child: Container(
                  color: Colors.transparent,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    MoneyFormat().formatCommaToDot(
                        controller.isDolar.value
                            ? controller
                                .listDateGeneratedRefuerzos[i].refuerzoDolares
                            : controller.listDateGeneratedRefuerzos[i]
                                .refuerzoGuaranies,
                        isGuaranies: !controller.isDolar.value),
                  ),
                ),
              ),
            )
          ]),
        ),
        columns: const <DataColumn>[
          DataColumn(
            label: Text(
              'Nº',
              textAlign: TextAlign.center,
            ),
          ),
          DataColumn(
            label: Text(
              'Fecha cuota',
              textAlign: TextAlign.center,
            ),
          ),
          DataColumn(
            label: Text(
              'Valor cuota',
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    ),
  );
}
