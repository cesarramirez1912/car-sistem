import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app/core/utils/date_format.dart';
import '../../app/global_widgets/cuote_refuerzo/iscuote_render.dart';
import '../../app/global_widgets/cuote_refuerzo/isrefuerzo_render.dart';
import '../../app/global_widgets/pay_dialog.dart';
import '../../app/modules/cuote_month/cuotes_month_detail_controller.dart';
import '../../responsive.dart';

class CuoteMonthDetailView extends StatelessWidget {
  CuotesMonthDetailController controller =
      Get.put(CuotesMonthDetailController());

  @override
  Widget build(BuildContext context) {
    return Responsive(
      tablet: Center(
        child: Container(
            alignment: Alignment.center, width: 900, child: principal()),
      ),
      desktop: Center(
        child: Container(
            alignment: Alignment.center, width: 900, child: principal()),
      ),
      mobile: principal(),
    );
  }

  Widget principal() {
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.isCuota.value ? 'Cuotas' : 'Refuerzos'),
      ),
      body: SingleChildScrollView(
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              controller.isCuota.value
                  ? isCuote(controller.listDudoresModel, (selected) async {
                      await payDialog(
                          controller, selected.idCuotaVenta, selected.idVenta,
                          fecha: DateFormatBr().formatBrFromString(
                              selected.fechaCuota.toString()),
                          faltanteDolares: selected.cuotaDolares != null
                              ? ((selected.cuotaDolares ?? 0) -
                                  (selected.pagoDolares ?? 0))
                              : null,
                          faltanteGuaranies: selected.cuotaGuaranies != null
                              ? ((selected.cuotaGuaranies ?? 0) -
                                  (selected.pagoGuaranies ?? 0))
                              : null,
                          pagoDolares: (selected.pagoDolares ?? 0),
                          pagoGuaranies: (selected.pagoGuaranies ?? 0),
                          isCuote: controller.isCuota.value);
                    })
                  : isRefuerzo(controller.listDudoresModelRef,
                      (selected) async {
                      await payDialog(controller, selected.idRefuerzoVenta,
                          selected.idVenta,
                          fecha: DateFormatBr().formatBrFromString(
                              selected.fechaRefuerzo.toString()),
                          faltanteGuaranies: selected.refuerzoGuaranies != null
                              ? ((selected.refuerzoGuaranies ?? 0) -
                                  (selected.pagoGuaranies ?? 0))
                              : null,
                          faltanteDolares: selected.refuerzoDolares != null
                              ? ((selected.refuerzoDolares ?? 0) -
                                  (selected.pagoDolares ?? 0))
                              : null,
                          pagoGuaranies: (selected.pagoGuaranies ?? 0),
                          pagoDolares: (selected.pagoDolares ?? 0),
                          isCuote: controller.isCuota.value);
                    })
            ],
          ),
        ),
      ),
    );
  }
}
