import 'package:car_system/colors.dart';
import 'package:car_system/common/date_format.dart';
import 'package:car_system/controllers/sells_from_collaborator_controller.dart';
import 'package:car_system/widgets/cuote_refuerzo/iscuote_render.dart';
import 'package:car_system/widgets/cuote_refuerzo/isrefuerzo_render.dart';
import 'package:car_system/widgets/pay_dialog.dart';
import 'package:car_system/widgets/search_dropdown.dart';
import 'package:car_system/widgets/spacing.dart';
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
      return isCuote(
        controller.listaCuotes.value,
        (selected) async {
          if (((selected.cuotaDolares ?? 0) - (selected.pagoDolares ?? 0)) !=
                  0 ||
              ((selected.cuotaGuaranies ?? 0) -
                      (selected.pagoGuaranies ?? 0)) !=
                  0) {
            await payDialog(controller, selected.idCuotaVenta, selected.idVenta,
                fecha: DateFormatBr()
                    .formatBrFromString(selected.fechaCuota.toString()),
                faltanteDolares: selected.cuotaDolares != null
                    ? ((selected.cuotaDolares ?? 0) -
                        (selected.pagoDolares ?? 0))
                    : null,
                faltanteGuaranies: selected.cuotaGuaranies != null
                    ? ((selected.cuotaGuaranies ?? 0) -
                        (selected.pagoGuaranies ?? 0))
                    : null,
                pagoGuaranies: (selected.pagoGuaranies ?? 0),
                pagoDolares: (selected.pagoDolares ?? 0),
                isCuote: true);
          }
        },
      );
    } else {
      return isRefuerzo(controller.listaRefuerzos.value, (selected) async {
        if (((selected.refuerzoDolares ?? 0) - (selected.pagoDolares ?? 0)) !=
                0 ||
            ((selected.refuerzoGuaranies ?? 0) -
                    (selected.pagoGuaranies ?? 0)) !=
                0) {
          await payDialog(
              controller, selected.idRefuerzoVenta, selected.idVenta,
              fecha: DateFormatBr()
                  .formatBrFromString(selected.fechaRefuerzo.toString()),
              faltanteDolares: selected.refuerzoDolares != null
                  ? ((selected.refuerzoDolares ?? 0) -
                      (selected.pagoDolares ?? 0))
                  : null,
              faltanteGuaranies: selected.refuerzoGuaranies != null
                  ? ((selected.refuerzoGuaranies ?? 0) -
                      (selected.pagoGuaranies ?? 0))
                  : null,
              pagoGuaranies: (selected.pagoGuaranies ?? 0),
              pagoDolares: (selected.pagoDolares ?? 0),
              isCuote: false);
        }
      });
    }
  }

  List<Widget> sectionTotal() {
    if (controller.isCuote.value) {
      return [
        Text(
          'Total Financiado: ' + controller.financiadoTotalStr.value,
          style: const TextStyle(fontWeight: FontWeight.bold),
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
          style: const TextStyle(color: ColorPalette.PRIMARY),
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
          style: const TextStyle(color: ColorPalette.GREEN),
        ),
        Text('Refuerzo faltante: ' + controller.totalRefuerzoFaltanteStr.value,
            style: const TextStyle(color: ColorPalette.PRIMARY))
      ];
    }
  }

  List<DataColumn> dataColumn() {
    return const <DataColumn>[
      DataColumn(
        label: Text(
          'Cuota / Venc.',
          softWrap: true,
          maxLines: 3,
          overflow: TextOverflow.visible,
        ),
      ),
      DataColumn(
        label: Text('Pago / Fecha'),
      ),
      DataColumn(
        label: Text('Pendiente'),
      ),
    ];
  }
}
