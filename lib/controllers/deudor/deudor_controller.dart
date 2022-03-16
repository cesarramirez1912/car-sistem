import 'package:car_system/common/dedudores_total.dart';
import 'package:car_system/models/deudor_model.dart';
import 'package:car_system/repositories/deudor_repository.dart';
import 'package:car_system/widgets/snack_bars/snack_bar_error.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app/data/models/user_model.dart';
import '../user_storage_controller.dart';

class DeudorController extends GetxController {
  UserStorageController userStorageController = Get.find();
  User? user;

  RxInt selectedIndex = 0.obs;

  RxBool isLoading = false.obs;

  TextEditingController searchTextController = TextEditingController(text: '');

  DeudoresTotal deudoresTotal = DeudoresTotal();

  DeudorRepository deudorRepository = DeudorRepository();
  RxList<Map<String, dynamic>> listDeudoresAgrupadoCuota =
      <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>> listDeudoresAgrupadoCuotaAux =
      <Map<String, dynamic>>[].obs;
  RxList<DeudorModel> listDeudoresCuota = <DeudorModel>[].obs;

  RxList<Map<String, dynamic>> listDeudoresAgrupadoRefuerzo =
      <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>> listDeudoresAgrupadoRefuerzoAux =
      <Map<String, dynamic>>[].obs;
  RxList<DeudorModel> listDeudoresRefuerzo = <DeudorModel>[].obs;

  RxString totalGuaranies = ''.obs;
  RxString totalDolares = ''.obs;

  @override
  Future<void> onInit() async {
    isLoading.value = true;
    user = userStorageController.user?.value;
    await requestDeudores();
    isLoading.value = false;
    super.onInit();
  }

  void queryDeudores() {}

  Map<String, dynamic> tipoMoroso(String? tipo) {
    switch (tipo) {
      case 'BAJO':
        return {"bajo": 1};
      case 'MEDIO':
        return {"medio": 1};
      case 'ALTO':
        return {"alto": 1};
      default:
        return {"": 0};
    }
  }

  void searchText(String text) {
    if (text.isEmpty) {
      listDeudoresAgrupadoCuota.value = listDeudoresAgrupadoCuotaAux;
      listDeudoresAgrupadoRefuerzo.value = listDeudoresAgrupadoRefuerzoAux;
    } else {
      List<Map<String, dynamic>> _list = listDeudoresAgrupadoCuotaAux
          .where((element) =>
              element['cliente'].toUpperCase().contains(text.toUpperCase()))
          .toList();
      List<Map<String, dynamic>> _list2 = listDeudoresAgrupadoRefuerzoAux
          .where((element) =>
              element['cliente'].toUpperCase().contains(text.toUpperCase()))
          .toList();
      listDeudoresAgrupadoCuota.value = _list;
      listDeudoresAgrupadoRefuerzo.value = _list2;
    }
  }

  Future<void> requestDeudores() async {
    try {
      Future _deudorCuota = deudorRepository.requestDeudores(user?.idEmpresa);
      Future _deudorRefuerzo =
          deudorRepository.requestDeudoresRefuerzo(user?.idEmpresa);

      List responses = await Future.wait([_deudorCuota, _deudorRefuerzo]);

      List<Map<String, dynamic>> listCuote =
          deudoresTotal.counterTotal(responses[0], true);
      List<Map<String, dynamic>> listRefuerzo =
          deudoresTotal.counterTotal(responses[1], false);

      listDeudoresCuota.clear();
      listDeudoresRefuerzo.clear();
      listDeudoresAgrupadoCuotaAux.clear();
      listDeudoresAgrupadoRefuerzoAux.clear();
      listDeudoresAgrupadoCuota.clear();
      listDeudoresAgrupadoRefuerzo.clear();
      listDeudoresAgrupadoCuota.addAll(listCuote);
      listDeudoresAgrupadoCuotaAux.addAll(listCuote);
      listDeudoresAgrupadoRefuerzo.addAll(listRefuerzo);
      listDeudoresAgrupadoRefuerzoAux.addAll(listRefuerzo);
      listDeudoresCuota.addAll(responses[0]);
      listDeudoresRefuerzo.addAll(responses[1]);
    } catch (e) {
      isLoading.value = false;
      CustomSnackBarError(e.toString());
    }
  }
}
