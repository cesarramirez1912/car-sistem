import 'package:car_system/controllers/deudor/deudor_controller.dart';
import 'package:get/get.dart';

import '../../models/cuote_detail_model.dart';
import '../../models/refuerzo_detail_model.dart';
import '../../repositories/sell_vehicle_repository.dart';
import '../../widgets/snack_bars/snack_bar_error.dart';
import '../../widgets/snack_bars/snack_bar_success.dart';

class DeudorDetailController extends GetxController {
  DeudorController deudorController = Get.find();

  RxList<CuoteDetailModel> listDudoresModel = <CuoteDetailModel>[].obs;
  RxList<RefuerzoDetailModel> listDudoresModelRef = <RefuerzoDetailModel>[].obs;
  RxBool isCuota = true.obs;
  int idCliente = 0;

  RxBool isLoadingRequest = false.obs;
  SellVehicleRepository sellVehicleRepository = SellVehicleRepository();

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
      Get.back();
      isLoadingRequest.value = false;
      CustomSnackBarSuccess('PAGO EFECTUADO CON EXITO!');
    } catch (e) {
      CustomSnackBarError(e.toString());
      isLoadingRequest.value = false;
    }
  }
}
