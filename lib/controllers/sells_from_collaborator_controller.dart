import 'dart:async';

import 'package:car_system/controllers/user_storage_controller.dart';
import 'package:car_system/models/cuote_detail_model.dart';
import 'package:car_system/models/refuerzo_detail_model.dart';
import 'package:car_system/models/sale_collaborator_model.dart';
import 'package:car_system/models/user_model.dart';
import 'package:car_system/repositories/sell_vehicle_repository.dart';
import 'package:car_system/widgets/snack_bars/snack_bar_error.dart';
import 'package:car_system/widgets/snack_bars/snack_bar_success.dart';
import 'package:get/get.dart';

class SellsFromCollaboratorController extends GetxController {
  UserStorageController userStorageController = Get.find();
  SellVehicleRepository sellVehicleRepository = SellVehicleRepository();

  RxList<SaleCollaboratorModel> sales = <SaleCollaboratorModel>[].obs;
  RxList<SaleCollaboratorModel> salesGeral = <SaleCollaboratorModel>[].obs;
  User? user = User();

  RxList<CuoteDetailModel> listaCuotesGeral = <CuoteDetailModel>[].obs;
  RxList<CuoteDetailModel> listaCuotes = <CuoteDetailModel>[].obs;

  RxList<RefuerzoDetailModel> listaRefuerzosGeral = <RefuerzoDetailModel>[].obs;
  RxList<RefuerzoDetailModel> listaRefuerzos = <RefuerzoDetailModel>[].obs;

  RxBool isLoading = false.obs;
  RxBool isCuote = false.obs;

  RxBool isLoadingRequest = false.obs;

  RxList<String> listString = ['TODOS', 'EN ABIERTO', 'CERRADOS'].obs;
  Rx<String> textString = 'TODOS'.obs;

  RxList<String> listStringCuotaOrefuerzo = ['CUOTA', 'REFUERZO'].obs;
  Rx<String> textStringCuotaOrefuerzo = 'CUOTA'.obs;

  RxBool isGuaranies = true.obs;

  @override
  void onInit() async {
    user = userStorageController.user?.value;
    await requestSales();
    super.onInit();
  }

  Future<void> requestSales() async {
    List<SaleCollaboratorModel> _sales =
        await sellVehicleRepository.requestSales(user?.idColaborador);
    salesGeral.clear();
    salesGeral.addAll(_sales);
    filterList();
  }

  Future<void> postPago(dynamic valorDolares, dynamic valorGuaranies, int? id,
      int? idVenta) async {
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
      if (textStringCuotaOrefuerzo.value == 'CUOTA') {
        var resCuote = await sellVehicleRepository.postCuote(bodyCuote);
        List<CuoteDetailModel> _list = await requestCuotes(idVenta);
        listaCuotes.clear();
        listaCuotesGeral.removeWhere((e) => e.idVenta == idVenta);
        listaCuotesGeral.addAll(_list);
        listaCuotes.addAll(_list);
      } else {
        var resRefuerzo =
            await sellVehicleRepository.postRefuerzo(bodyRefuerzo);
        List<RefuerzoDetailModel> _list = await requestRefuerzos(idVenta);
        listaRefuerzos.clear();
        listaRefuerzosGeral.removeWhere((e) => e.idVenta == idVenta);
        listaRefuerzosGeral.addAll(_list);
        listaRefuerzos.addAll(_list);
      }
      Get.back();
      isLoadingRequest.value = false;
      CustomSnackBarSuccess('PAGO EFECTUADO CON EXITO!');
    } catch (e) {
      CustomSnackBarError(e.toString());
      isLoadingRequest.value = false;
    }
  }

  void filterList() {
    switch (textString.value) {
      case 'TODOS':
        sales.clear();
        sales.addAll(salesGeral);
        break;
      case 'EN ABIERTO':
        sales.value = salesGeral
            .where((element) =>
                (int.parse(element.cantidadCuotas) -
                        int.parse(element.cantidadCuotasPagadas)) >
                    0 ||
                (int.parse(element.cantidadRefuerzos) -
                        int.parse(element.cantidadRefuerzosPagados)) >
                    0)
            .toList();
        break;
      default:
        sales.value = salesGeral
            .where((element) =>
                (element.contadoDolares != null ||
                    element.contadoGuaranies != null) ||
                ((int.parse(element.cantidadCuotas) -
                        int.parse(element.cantidadCuotasPagadas)) ==
                    0))
            .toList();
    }
  }

  void filterCuoteOrRefuerzo() {
    switch (textStringCuotaOrefuerzo.value) {
      case 'CUOTA':
        isCuote.value = true;
        break;
      default:
        isCuote.value = false;
    }
  }

  void queryListCuotes(int? idVenta) async {
    listaCuotes.clear();
    isCuote.value = true;
    var lista = listaCuotesGeral.where((e) => e.idVenta == idVenta).toList();
    if (lista.isEmpty) {
      isLoading.value = true;
      List<CuoteDetailModel> _list = await requestCuotes(idVenta);
      listaCuotesGeral.addAll(_list);
      listaCuotes.addAll(_list);
      isLoading.value = false;
    } else {
      listaCuotes.addAll(lista);
    }
  }

  void queryListRefuerzos(int? idVenta) async {
    listaRefuerzos.clear();
    isCuote.value = false;
    var lista = listaRefuerzosGeral.where((e) => e.idVenta == idVenta).toList();
    if (lista.isEmpty) {
      isLoading.value = true;
      List<RefuerzoDetailModel> _list = await requestRefuerzos(idVenta);
      listaRefuerzosGeral.addAll(_list);
      listaRefuerzos.addAll(_list);
      isLoading.value = false;
    } else {
      listaRefuerzos.addAll(lista);
    }
  }

  Future<List<CuoteDetailModel>> requestCuotes(int? idVenta) async {
    return await sellVehicleRepository.requestCuotes(idVenta);
  }

  Future<List<RefuerzoDetailModel>> requestRefuerzos(int? idVenta) async {
    return await sellVehicleRepository.requestRefuerzos(idVenta);
  }
}
