import 'package:car_system/app/data/repositories/remote/cuotes_month_repository.dart';
import 'package:car_system/widgets/snack_bars/snack_bar_error.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/user_storage_controller.dart';
import '../../core/utils/dedudores_total.dart';
import '../../data/models/deudor_model.dart';
import '../../data/models/user_model.dart';

class CuotesMonthController extends GetxController {
 final  CuotesMonthRepository cuotesMonthRepository = Get.find();

  Rx<DateTime> firstDateCuoteSelected = DateTime.utc(
          DateTime.now().year, DateTime.now().month, DateTime.now().day)
      .obs;

  UserStorageController userStorageController = Get.find();
  User? user;

  RxInt selectedIndex = 0.obs;

  RxBool isLoading = false.obs;

  TextEditingController searchTextController = TextEditingController(text: '');

  DeudoresTotal deudoresTotal = DeudoresTotal();

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

  var monthInt = DateTime.now().month;
  var year = DateTime.now().year;

  @override
  Future<void> onInit() async {
    isLoading.value = true;
    user = userStorageController.user?.value;
    await requestDeudoresMonth();
    isLoading.value = false;
    super.onInit();
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

  Future<void> requestDeudoresMonth() async {
    try {
      Future _deudorCuota = cuotesMonthRepository.requestMonthDeudores(
          user?.idEmpresa,
          firstDateCuoteSelected.value.month,
          firstDateCuoteSelected.value.year);
      Future _deudorRefuerzo =
          cuotesMonthRepository.requestDeudoresMonthRefuerzo(
              user?.idEmpresa,
              firstDateCuoteSelected.value.month,
              firstDateCuoteSelected.value.year);
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
