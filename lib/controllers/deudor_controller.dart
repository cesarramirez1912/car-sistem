import 'package:car_system/controllers/user_storage_controller.dart';
import 'package:car_system/models/deudor_model.dart';
import 'package:car_system/repositories/deudor_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/user_model.dart';

class DeudorController extends GetxController {
  UserStorageController userStorageController = Get.find();
  User? user;

  RxInt selectedIndex = 0.obs;

  RxBool isLoading = false.obs;

  TextEditingController searchTextController = TextEditingController(text: '');

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
    Future _deudorCuota = deudorRepository.requestDeudores(user?.idEmpresa);
    Future _deudorRefuerzo =
        deudorRepository.requestDeudoresRefuerzo(user?.idEmpresa);

    List responses = await Future.wait([_deudorCuota, _deudorRefuerzo]);

    List<Map<String, dynamic>> listCuote = counterTotal(responses[0], true);
    List<Map<String, dynamic>> listRefuerzo = counterTotal(responses[1], false);

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
  }

  List<Map<String, dynamic>> counterTotal(
      List<DeudorModel> _list, bool isCuote) {
    List<Map<String, dynamic>> _newListFilter = [];

    for (var deu in _list) {
      var exist = _newListFilter
          .indexWhere((element) => element['idCliente'] == deu.idCliente);
      if (exist != -1) {
        _newListFilter[exist]['lista'].add(deu);

        _newListFilter[exist]['total_deuda_guaranies'] = ((_newListFilter[exist]
                    ['total_deuda_guaranies'] ??
                0) +
            (isCuote
                ? ((deu.cuotaGuaranies ?? 0) - (deu.pagoGuaranies ?? 0))
                : ((deu.refuerzoGuaranies ?? 0) - (deu.pagoGuaranies ?? 0))));
        _newListFilter[exist]['total_deuda_dolares'] =
            ((_newListFilter[exist]['total_deuda_dolares'] ?? 0) +
                (isCuote
                    ? ((deu.cuotaDolares ?? 0) - (deu.pagoDolares ?? 0))
                    : ((deu.refuerzoDolares ?? 0) - (deu.pagoDolares ?? 0))));

        if (deu.tipoMoroso == 'bajo') {
          if (_newListFilter[exist]['bajo'] != null) {
            _newListFilter[exist]['bajo'] = _newListFilter[exist]['bajo'] + 1;
          } else {
            _newListFilter[exist]['bajo'] = 1;
          }
        } else if (deu.tipoMoroso == 'medio') {
          if (_newListFilter[exist]['medio'] != null) {
            _newListFilter[exist]['medio'] = _newListFilter[exist]['medio'] + 1;
          } else {
            _newListFilter[exist]['medio'] = 1;
          }
        } else {
          if (_newListFilter[exist]['alto'] != null) {
            _newListFilter[exist]['alto'] = _newListFilter[exist]['alto'] + 1;
          } else {
            _newListFilter[exist]['alto'] = 1;
          }
        }
      } else {
        _newListFilter.add({
          "idCliente": deu.idCliente,
          "cliente": deu.cliente,
          "lista": [deu],
          "total_deuda_guaranies": isCuote
              ? ((deu.cuotaGuaranies ?? 0) - (deu.pagoGuaranies ?? 0))
              : ((deu.refuerzoGuaranies ?? 0) - (deu.pagoGuaranies ?? 0)),
          "total_deuda_dolares": isCuote
              ? ((deu.cuotaDolares ?? 0) - (deu.pagoDolares ?? 0))
              : ((deu.refuerzoDolares ?? 0) - (deu.pagoDolares ?? 0)),
          ...tipoMoroso(deu.tipoMoroso)
        });
      }
    }
    return _newListFilter;
  }
}
