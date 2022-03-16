import 'package:car_system/common/date_format.dart';
import 'package:car_system/widgets/search_dropdown.dart';
import 'package:car_system/widgets/spacing.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../vehicle_detail/vehicle_detail_controller.dart';

class DatesVencView extends GetView<VehicleDetailController> {
  @override
  Widget build(BuildContext context) {
    Map<dynamic, dynamic>? args = Get.parameters;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fechas generadas'),
      ),
      body: Obx(
        () => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomSpacing(),
              args['isResumen'] == null
                  ? isCuoteRender(
                      args['isCuote'] == 'true' ? true : false, context)
                  : isResumenRender(context)
            ],
          ),
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

  Widget isCuoteRender(bool isCuote, context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          isCuote
              ? Container()
              : CustomDropDowSearch(
                  controller.typesCobroMensuales, 'ENTRE MESES',
                  iconData: Icons.date_range,
                  selectedItem: controller.typeCobroMensualSelected.value,
                  onChanged: (value) {
                  controller.typeCobroMensualSelected.value = value;
                  controller.generatedDatesRefuerzos();
                }),
          Expanded(
            child: SingleChildScrollView(
              child: DataTable(
                showCheckboxColumn: false,
                rows: List.generate(
                  isCuote
                      ? controller.listDateGeneratedCuotas.length
                      : controller.listDateGeneratedRefuerzos.length,
                  (i) => DataRow(
                      onSelectChanged: (selected) {
                        isCuote
                            ? controller.selectDateCuote(context,
                                controller.listDateGeneratedCuotas[i], i)
                            : controller.selectDateRefuerzo(context,
                                controller.listDateGeneratedRefuerzos[i], i);
                      },
                      cells: [
                        DataCell(Text((i + 1).toString())),
                        DataCell(Text(
                          DateFormatBr().formatBrFromString(isCuote
                              ? controller.listDateGeneratedCuotas[i].toString()
                              : controller.listDateGeneratedRefuerzos[i].toString()),
                        )),
                      ]),
                ),
                columns: const <DataColumn>[
                  DataColumn(
                    label: Text('Nº'),
                  ),
                  DataColumn(
                    label: Text('Fecha'),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
