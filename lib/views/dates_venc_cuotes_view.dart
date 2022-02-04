import 'package:car_system/colors.dart';
import 'package:car_system/common/date_format.dart';
import 'package:car_system/common/money_format.dart';
import 'package:car_system/controllers/sells_from_collaborator_controller.dart';
import 'package:car_system/widgets/button.dart';
import 'package:car_system/widgets/search_dropdown.dart';
import 'package:car_system/widgets/spacing.dart';
import 'package:car_system/widgets/title.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DatesVencCuotesView extends StatelessWidget {
  SellsFromCollaboratorController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    controller.filterCuoteOrRefuerzo();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fechas'),
      ),
      body: Obx(() => controller.isLoading.value
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomDropDowSearch(
                      controller.listStringCuotaOrefuerzo.value, '',
                      iconData: Icons.filter_alt_outlined, onChanged: (value) {
                    controller.textStringCuotaOrefuerzo.value = value;
                    controller.filterCuoteOrRefuerzo();
                  }, selectedItem: controller.textStringCuotaOrefuerzo.value),
                  const SizedBox(
                    height: 6,
                  ),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [...sectionTotal()],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [render()],
                      ),
                    ),
                  )
                ],
              ),
            )),
    );
  }

  Widget render() {
    if (controller.isCuote.value) {
      return isCuote();
    } else {
      return isRefuerzo();
    }
  }

  List<Widget> sectionTotal() {
    if (controller.isCuote.value) {
      return [
        Text(
          'Total Financiado: ' + controller.financiadoTotalStr.value,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        CustomSpacing(height: 6),
        Text(
          'Total Cuota: ' + controller.totalVentaCuotaStr.value,
        ),
        Text(
          'Cuota Pagado: ' + controller.totalPagadoCuotaStr.value,
          style: const TextStyle(color: ColorPalette.GREEN),
        ),
        Text(
          'Cuota Faltante: ' + controller.totalCuotaFaltanteStr.value,
          style: const TextStyle(color:  ColorPalette.PRIMARY),
        )
      ];
    } else {
      return [
        Text(
          'Total Financiado: ' + controller.financiadoTotalStr.value,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        CustomSpacing(height: 6),
        Text('Total Refuerzo: ' + controller.totalVentaRefuerzoStr.value),
        Text(
          'Refuerzo Pagado: ' + controller.totalPagadoRefuerzoStr.value,
          style: const TextStyle(color:  ColorPalette.GREEN),
        ),
        Text('Refuerzo faltante: ' + controller.totalRefuerzoFaltanteStr.value,
            style: const TextStyle(color: ColorPalette.PRIMARY))
      ];
    }
  }

  Widget isCuote() {
    return DataTable(
      columnSpacing: 0,
      showCheckboxColumn: false,
      rows: List.generate(
        controller.listaCuotes.length,
        (i) => DataRow(
            onSelectChanged: (selected) {
              if (controller.listaCuotes[i].fechaPago == null) {
                openDialog(
                    controller,
                    DateFormatBr().formatBrFromString(
                        controller.listaCuotes[i].fechaCuota.toString()),
                    controller.listaCuotes[i].cuotaGuaranies,
                    controller.listaCuotes[i].cuotaDolares,
                    controller.listaCuotes[i].idCuotaVenta,
                    controller.listaCuotes[i].idVenta);
              }
            },
            cells: [
              DataCell(Text(controller.listaCuotes[i].cuotaGuaranies != null
                  ? MoneyFormat().formatCommaToDot(
                      controller.listaCuotes[i].cuotaGuaranies.toString())
                  : MoneyFormat().formatCommaToDot(
                      controller.listaCuotes[i].cuotaDolares.toString(),
                      isGuaranies: false))),
              DataCell(
                Text(
                  DateFormatBr().formatBrFromString(
                      controller.listaCuotes[i].fechaCuota.toString()),
                ),
              ),
              DataCell(
                Text(
                  controller.listaCuotes[i].fechaPago != null
                      ? DateFormatBr().formatBrFromString(
                          controller.listaCuotes[i].fechaPago.toString())
                      : '-',
                  style: const TextStyle(color: ColorPalette.GREEN),
                ),
              ),
            ]),
      ),
      columns: const <DataColumn>[
        DataColumn(
          label: Text('Cuota'),
        ),
        DataColumn(
          label: Text('Venc.'),
        ),
        DataColumn(
          label: Text('Fecha Pag.'),
        ),
      ],
    );
  }

  Widget isRefuerzo() {
    return DataTable(
      columnSpacing: 0,
      showCheckboxColumn: false,
      rows: List.generate(
        controller.listaRefuerzos.length,
        (i) => DataRow(
            onSelectChanged: (selected) {
              if (controller.listaRefuerzos[i].fechaPago == null) {
                openDialog(
                    controller,
                    DateFormatBr().formatBrFromString(
                        controller.listaRefuerzos[i].fechaRefuerzo.toString()),
                    controller.listaRefuerzos[i].refuerzoGuaranies,
                    controller.listaRefuerzos[i].refuerzoDolares,
                    controller.listaRefuerzos[i].idRefuerzoVenta,
                    controller.listaRefuerzos[i].idVenta);
              }
            },
            cells: [
              DataCell(Text(controller.listaRefuerzos[i].refuerzoGuaranies !=
                      null
                  ? MoneyFormat().formatCommaToDot(
                      controller.listaRefuerzos[i].refuerzoGuaranies.toString())
                  : MoneyFormat().formatCommaToDot(
                      controller.listaRefuerzos[i].refuerzoDolares.toString(),
                      isGuaranies: false))),
              DataCell(
                Text(
                  DateFormatBr().formatBrFromString(
                      controller.listaRefuerzos[i].fechaRefuerzo.toString()),
                ),
              ),
              DataCell(
                Text(
                  controller.listaRefuerzos[i].fechaPago != null
                      ? DateFormatBr().formatBrFromString(
                          controller.listaRefuerzos[i].fechaPago.toString())
                      : '-',
                  style: const TextStyle(color: ColorPalette.GREEN),
                ),
              ),
            ]),
      ),
      columns: const <DataColumn>[
        DataColumn(
          label: Text('Cuota'),
        ),
        DataColumn(
          label: Text('Venc.'),
        ),
        DataColumn(
          label: Text('Fecha Pag.'),
        ),
      ],
    );
  }
}

Future openDialog(SellsFromCollaboratorController controller, String fecha,
    dynamic valorGuaranies, dynamic valorDolares, int? id, int? idVenta) {
  return Get.defaultDialog(
      title: 'PAGAR ${controller.textStringCuotaOrefuerzo}',
      content: dialogPlan(controller, fecha, valorGuaranies, valorDolares),
      actions: [
        Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CustomButton(
                '     PAGAR     ',
                () => controller.postPago(
                    valorDolares, valorGuaranies, id, idVenta),
                ColorPalette.GREEN,
                edgeInsets:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                fontSize: 12,
                isLoading: controller.isLoadingRequest.value),
            const SizedBox(
              width: 10,
            ),
            CustomButton('CANCELAR', () => Get.back(), ColorPalette.PRIMARY,
                edgeInsets:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                fontSize: 12,
                isLoading: controller.isLoadingRequest.value),
          ],
        ),
      ]);
}

Widget dialogPlan(controller, fecha, valorGuaranies, valorDolares) {
  return SingleChildScrollView(
    child: Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomTitle('FECHA'),
          CustomTitle(fecha, fontWeight: FontWeight.w500, fontSize: 15),
          CustomTitle('TOTAL'),
          CustomTitle(
              valorGuaranies != null
                  ? MoneyFormat().formatCommaToDot(valorGuaranies)
                  : MoneyFormat()
                      .formatCommaToDot(valorDolares, isGuaranies: false),
              fontWeight: FontWeight.w500,
              fontSize: 15),
          CustomTitle('PAGAR ?'),
        ],
      ),
    ),
  );
}
