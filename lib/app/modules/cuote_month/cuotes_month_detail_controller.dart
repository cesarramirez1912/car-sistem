import 'package:car_system/app/data/providers/remote/sells_api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/models/cuote_detail_model.dart';
import '../../data/models/refuerzo_detail_model.dart';
import '../../global_widgets/snack_bars/snack_bar_error.dart';
import '../../global_widgets/snack_bars/snack_bar_success.dart';
import 'cuotes_month_controller.dart';

class CuotesMonthDetailController extends GetxController {
  CuotesMonthController deudorController = Get.find();

  RxList<CuoteDetailModel> listDudoresModel = <CuoteDetailModel>[].obs;
  RxList<RefuerzoDetailModel> listDudoresModelRef = <RefuerzoDetailModel>[].obs;
  RxBool isCuota = true.obs;
  int idCliente = 0;

  RxBool isLoadingRequest = false.obs;
  final SellsApi _sellVehicleRepository = Get.find();

  Rx<DateTime> fechaPago = DateTime.utc(
          DateTime.now().year, DateTime.now().month, DateTime.now().day)
      .obs;

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

  Future<void> changeFechaPago(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        locale: const Locale('es'),
        initialDate: fechaPago.value,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != fechaPago) {
      fechaPago.value = picked;
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
      "pago_guaranies": valorGuaranies,
      "fecha_pago": fechaPago.value.toString()
    };
    var bodyRefuerzo = {
      "id_refuerzo_venta": id,
      "pago_dolares": valorDolares,
      "pago_guaranies": valorGuaranies,
      "fecha_pago": fechaPago.value.toString()
    };
    isLoadingRequest.value = true;
    try {
      if (isCuote) {
        var resCuote = await _sellVehicleRepository.postCuote(bodyCuote);
      } else {
        var resRefuerzo =
            await _sellVehicleRepository.postRefuerzo(bodyRefuerzo);
      }
      await deudorController.requestDeudoresMonth();
      initial();
      Get.back();
      Get.back();
      isLoadingRequest.value = false;
      CustomSnackBarSuccess('PAGO EFECTUADO CON EXITO!');
    } catch (e) {
      CustomSnackBarError(e.toString());
      isLoadingRequest.value = false;
    }
  }
}
