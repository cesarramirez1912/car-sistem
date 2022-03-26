import 'package:car_system/app/core/utils/money_format.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/utils/date_format.dart';
import '../../global_widgets/search_dropdown.dart';
import '../../global_widgets/spacing.dart';
import '../vehicle_detail/vehicle_detail_controller.dart';

class DatesVencView extends StatelessWidget {
  VehicleDetailController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    print(controller.listDateGeneratedCuotas.value.first.cuotaGuaranies);
    print(controller.listDateGeneratedCuotas.value.first.cuotaDolares);
    Map<dynamic, dynamic>? args = Get.parameters;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fechas generadas'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomSpacing(),
            isCuoteRender(
              args['isCuote'] == 'true' ? true : false,
              context,
              args,
              args['isDolar'] == 'true' ? true : false,
            )
          ],
        ),
      ),
    );
  }

  Widget isResumenRender(context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: DataTable(
                showCheckboxColumn: false,
                rows: List.generate(
                  controller.listResumen.length,
                  (i) => DataRow(
                    cells: [
                      DataCell(Text((i + 1).toString())),
                      DataCell(
                        Text(controller.listResumen[i].fechaCuota),
                      ),
                    ],
                  ),
                ),
                columns: const <DataColumn>[
                  DataColumn(
                    label: Text('Nº'),
                  ),
                  DataColumn(
                    label: Text('Fecha Cuota'),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget isCuoteRender(bool isCuote, context, args, isDolar) {
    return Expanded(
      child: Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            isCuote
                ? Container()
                : CustomDropDowSearch(
                    controller.typesCobroMensuales,
                    'ENTRE MESES',
                    iconData: Icons.date_range,
                    selectedItem: controller.typeCobroMensualSelected.value,
                    onChanged: (value) {
                      controller.typeCobroMensualSelected.value = value;
                      controller.generatedDatesRefuerzos();
                    },
                  ),
            Expanded(
              child: SingleChildScrollView(
                child: DataTable(
                  showCheckboxColumn: false,
                  rows: List.generate(
                    isCuote
                        ? controller.listDateGeneratedCuotas.length
                        : controller.listDateGeneratedRefuerzos.length,
                    (i) => DataRow(cells: [
                      DataCell(Text((i + 1).toString())),
                      DataCell(
                        GestureDetector(
                          onTap: () => isCuote
                              ? controller.selectDateCuote(
                                  context,
                                  controller.listDateGeneratedCuotas[i].date!,
                                  i)
                              : controller.selectDateRefuerzo(
                                  context,
                                  controller
                                      .listDateGeneratedRefuerzos[i].date!,
                                  i),
                          child: Container(
                            color: Colors.transparent,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 6),
                            child: Text(
                              DateFormatBr().formatBrFromString(isCuote
                                  ? controller.listDateGeneratedCuotas[i].date!
                                      .toString()
                                  : controller
                                      .listDateGeneratedRefuerzos[i].date!
                                      .toString()),
                            ),
                          ),
                        ),
                      ),
                      DataCell(
                        GestureDetector(
                          onTap: () => controller.changeValue(context, i,isCuote),
                          child: Container(
                            color: Colors.transparent,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 6),
                            child: Text(
                              MoneyFormat().formatCommaToDot(
                                  isCuote
                                      ? (isDolar
                                              ? controller
                                                  .listDateGeneratedCuotas[i]
                                                  .cuotaDolares
                                              : controller
                                                  .listDateGeneratedCuotas[i]
                                                  .cuotaGuaranies)
                                          .toString()
                                      : (isDolar
                                              ? controller
                                                  .listDateGeneratedRefuerzos[i]
                                                  .refuerzoDolares
                                              : controller
                                                  .listDateGeneratedRefuerzos[i]
                                                  .refuerzoGuaranies)
                                          .toString(),
                                  isGuaranies: !isDolar),
                            ),
                          ),
                        ),
                      )
                    ]),
                  ),
                  columns: const <DataColumn>[
                    DataColumn(
                      label: Text('Nº'),
                    ),
                    DataColumn(
                      label: Text('Fecha'),
                    ),
                    DataColumn(
                      label: Text('Valor'),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
