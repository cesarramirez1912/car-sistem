import 'package:car_system/common/date_format.dart';
import 'package:car_system/controllers/deudor_controller.dart';
import 'package:car_system/models/cuote_detail_model.dart';
import 'package:car_system/models/refuerzo_detail_model.dart';
import 'package:car_system/repositories/sell_vehicle_repository.dart';
import 'package:car_system/widgets/cuote_refuerzo/iscuote_render.dart';
import 'package:car_system/widgets/cuote_refuerzo/isrefuerzo_render.dart';
import 'package:car_system/widgets/pay_dialog.dart';
import 'package:car_system/widgets/snack_bars/snack_bar_error.dart';
import 'package:car_system/widgets/snack_bars/snack_bar_success.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeudorDetailView extends StatelessWidget {
  DeudorDetailController controller = Get.put(DeudorDetailController());

  @override
  Widget build(BuildContext context) {
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

class DeudorDetailController extends GetxController {
  RxList<CuoteDetailModel> listDudoresModel = <CuoteDetailModel>[].obs;
  RxList<RefuerzoDetailModel> listDudoresModelRef = <RefuerzoDetailModel>[].obs;
  RxBool isCuota = true.obs;
  int idCliente = 0;

  RxBool isLoadingRequest = false.obs;
  SellVehicleRepository sellVehicleRepository = SellVehicleRepository();
  DeudorController deudorController = Get.find();

  @override
  Future<void> onInit() async {
    Map<String, dynamic> values = Get.parameters;
    isCuota.value = values['isCuota'] == 'true' ? true : false;
    idCliente = int.parse(values['idCliente']);
    initial();
    super.onInit();
  }

  void initial() {
    List<dynamic> listDeudores = isCuota.value
        ? deudorController.listDeudoresAgrupadoCuota.value
        : deudorController.listDeudoresAgrupadoRefuerzo.value;
    var _list = listDeudores
        .where((element) => element['idCliente'] == idCliente)
        .toList();
    listDudoresModel.clear();
    listDudoresModelRef.clear();
    if (isCuota.value) {
      for (var i = 0; i < _list.first['lista'].length; i++) {
        listDudoresModel
            .add(CuoteDetailModel.fromJson(_list.first['lista'][i].toJson()));
      }
    } else {
      for (var i = 0; i < _list.first['lista'].length; i++) {
        listDudoresModelRef.add(
            RefuerzoDetailModel.fromJson(_list.first['lista'][i].toJson()));
      }
    }
  }

  Future<void> postPago(
      dynamic valorDolares, dynamic valorGuaranies, int? id, int? idVenta,
      {required bool isCuote}) async {
    if (valorDolares == null && double.parse(valorGuaranies) == 0) {
      CustomSnackBarError('TOTAL NO VALIDO');
      return;
    }
    if (valorGuaranies == null && double.parse(valorDolares) == 0) {
      CustomSnackBarError('TOTAL NO VALIDO');
      return;
    }
    var bodyCuote = {
      "id_cuota_venta": id,
      "pago_dolares": valorDolares,
      "pago_guaranies": valorGuaranies
    };
    var bodyRefuerzo = {
      "id_refuerzo_venta": id,
      "pago_dolares": valorDolares,
      "pago_guaranies": valorGuaranies
    };
    isLoadingRequest.value = true;
    try {
      if (isCuote) {
        var resCuote = await sellVehicleRepository.postCuote(bodyCuote);
      } else {
        var resRefuerzo =
            await sellVehicleRepository.postRefuerzo(bodyRefuerzo);
      }
      await deudorController.requestDeudores();
      initial();
      Get.back();
      isLoadingRequest.value = false;
      CustomSnackBarSuccess('PAGO EFECTUADO CON EXITO!');
    } catch (e) {
      CustomSnackBarError(e.toString());
      isLoadingRequest.value = false;
    }
  }
}
