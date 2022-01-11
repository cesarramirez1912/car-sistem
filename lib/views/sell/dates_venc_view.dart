import 'package:car_system/common/date_format.dart';
import 'package:car_system/common/money_format.dart';
import 'package:car_system/controllers/vehicle_detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DatesVencView extends GetView<VehicleDetailController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Fechas generadas'),
        ),
        body: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: DataTable(
                    columnSpacing: 50,
                    showCheckboxColumn: false,
                    rows: List.generate(
                      controller.listDateGenerated.length,
                      (i) => DataRow(
                          onSelectChanged: (selected) {
                            controller.selectDate(
                                context, controller.listDateGenerated[i], i);
                          },
                          cells: [
                            DataCell(Text('N' + (i + 1).toString())),
                            DataCell(Text(
                              DateFormat()
                                  .formatBr(controller.listDateGenerated[i]),
                            )),
                            DataCell(
                              Text(MoneyFormat().formatCommaToDot(controller
                                  .cuota.value.cuotaGuaranies
                                  .toString())),
                            ),
                          ]),
                    ),
                    columns: const <DataColumn>[
                      DataColumn(
                        label: Text('Cuota'),
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
              ),
            ],
          ),
        ));
  }
}
