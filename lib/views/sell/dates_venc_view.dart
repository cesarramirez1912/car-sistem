import 'package:car_system/common/date_format.dart';
import 'package:car_system/common/money_format.dart';
import 'package:car_system/controllers/vehicle_detail_controller.dart';
import 'package:car_system/widgets/search_dropdown.dart';
import 'package:car_system/widgets/spacing.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DatesVencView extends GetView<VehicleDetailController> {
  @override
  Widget build(BuildContext context) {
    Map<dynamic, dynamic>? args = Get.parameters;
    print(args['isCuote']);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fechas generadas'),
      ),
      body: Obx(
        () => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              CustomSpacing(),
              args['isCuote'] == 'true'
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
                      args['isCuote'] == 'true'
                          ? controller.listDateGeneratedCuotas.length
                          : controller.listDateGeneratedRefuerzos.length,
                      (i) => DataRow(
                          onSelectChanged: (selected) {
                            args['isCuote'] == 'true'
                                ? controller.selectDateCuote(context,
                                    controller.listDateGeneratedCuotas[i], i)
                                : controller.selectDateRefuerzo(
                                    context,
                                    controller.listDateGeneratedRefuerzos[i],
                                    i);
                          },
                          cells: [
                            DataCell(Text((i + 1).toString())),
                            DataCell(Text(
                              DateFormat().formatBr(args['isCuote'] == 'true'
                                  ? controller.listDateGeneratedCuotas[i]
                                  : controller.listDateGeneratedRefuerzos[i]),
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
        ),
      ),
    );
  }
}
