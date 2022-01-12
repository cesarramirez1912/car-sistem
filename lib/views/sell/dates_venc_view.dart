import 'package:car_system/common/date_format.dart';
import 'package:car_system/common/money_format.dart';
import 'package:car_system/controllers/vehicle_detail_controller.dart';
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
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              args['isCuote'] == 'true'
                  ? Expanded(
                      child: SingleChildScrollView(
                        child: DataTable(
                          columnSpacing: 20,
                          showCheckboxColumn: false,
                          rows: List.generate(
                            controller.listDateGeneratedCuotas.length,
                            (i) => DataRow(
                                onSelectChanged: (selected) {
                                  controller.selectDateCuote(context,
                                      controller.listDateGeneratedCuotas[i], i);
                                },
                                cells: [
                                  DataCell(Text((i + 1).toString())),
                                  DataCell(Text(
                                    DateFormat().formatBr(
                                        controller.listDateGeneratedCuotas[i]),
                                  )),
                                  DataCell(
                                    Text(MoneyFormat().formatCommaToDot(
                                        controller.cuota.value.cuotaGuaranies
                                            .toString())),
                                  ),
                                  DataCell(
                                    Text('-'),
                                  ),
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
                              label: Text('Cuota'),
                            ),
                            DataColumn(
                              label: Text('Refuerzo'),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Expanded(
                      child: SingleChildScrollView(
                        child: DataTable(
                          columnSpacing: 20,
                          showCheckboxColumn: false,
                          rows: List.generate(
                            controller.listDateGeneratedRefuerzos.length,
                            (i) => DataRow(
                                onSelectChanged: (selected) {
                                  controller.selectDateRefuerzo(
                                      context,
                                      controller.listDateGeneratedRefuerzos[i],
                                      i);
                                },
                                cells: [
                                  DataCell(Text((i + 1).toString())),
                                  DataCell(Text(
                                    DateFormat().formatBr(controller
                                        .listDateGeneratedRefuerzos[i]),
                                  )),
                                  DataCell(
                                    Text(MoneyFormat().formatCommaToDot(
                                        controller.cuota.value.refuerzoGuaranies
                                            .toString())),
                                  ),
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
                              label: Text('Refuerzo'),
                            ),
                          ],
                        ),
                      ),
                    ),
            ],
          ),
        ));
  }
}
