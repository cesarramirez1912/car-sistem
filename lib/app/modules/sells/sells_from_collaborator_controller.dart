import 'dart:async';
import 'package:car_system/app/data/providers/remote/sells_api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/utils/date_format.dart';
import '../../core/utils/money_format.dart';
import '../../core/utils/user_storage_controller.dart';
import '../../data/models/cuote_detail_model.dart';
import '../../data/models/refuerzo_detail_model.dart';
import '../../data/models/sale_collaborator_model.dart';
import '../../data/models/user_model.dart';
import '../../global_widgets/snack_bars/snack_bar_error.dart';
import '../../global_widgets/snack_bars/snack_bar_success.dart';

class SellsFromCollaboratorController extends GetxController {
  final UserStorageController userStorageController = Get.find();
  final SellsApi _sellVehicleRepository = Get.find();

  RxList<SaleCollaboratorModel> sales = <SaleCollaboratorModel>[].obs;
  RxList<SaleCollaboratorModel> salesAux = <SaleCollaboratorModel>[].obs;
  RxList<SaleCollaboratorModel> salesGeral = <SaleCollaboratorModel>[].obs;
  User? user = User();

  RxList<CuoteDetailModel> listaCuotesGeral = <CuoteDetailModel>[].obs;
  RxList<CuoteDetailModel> listaCuotes = <CuoteDetailModel>[].obs;

  RxList<RefuerzoDetailModel> listaRefuerzosGeral = <RefuerzoDetailModel>[].obs;
  RxList<RefuerzoDetailModel> listaRefuerzos = <RefuerzoDetailModel>[].obs;

  Rx<DateTime> fechaPago = DateTime.utc(
          DateTime.now().year, DateTime.now().month, DateTime.now().day)
      .obs;
  Rx<DateTime> fechaCuotaRefuerzo = DateTime.utc(
          DateTime.now().year, DateTime.now().month, DateTime.now().day)
      .obs;

  RxString financiadoTotalStr = ''.obs;

  RxString totalPagadoCuotaStr = ''.obs;
  RxString totalVentaCuotaStr = ''.obs;
  RxString totalCantidadFaltanteCuotaStr = ''.obs;
  RxString totalCantidadPagadoCuotaStr = ''.obs;
  RxString totalCuotaFaltanteStr = ''.obs;

  RxString totalPagadoRefuerzoStr = ''.obs;
  RxString totalVentaRefuerzoStr = ''.obs;
  RxString totalCantidadFaltanteRefuerzoStr = ''.obs;
  RxString totalCantidadPagadoRefuerzoStr = ''.obs;
  RxString totalRefuerzoFaltanteStr = ''.obs;

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
        await _sellVehicleRepository.requestSales(user?.idColaborador);
    salesGeral.clear();
    salesGeral.addAll(_sales);
    filterList();
  }

  Future<void> changeFechaPago(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        locale: const Locale('es'),
        initialDate: fechaPago.value,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != fechaPago.value) {
      fechaPago.value = picked;
    }
  }

  Future<void> changeFechaCuotaRefuerzo(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        locale: const Locale('es'),
        initialDate: fechaCuotaRefuerzo.value,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != fechaCuotaRefuerzo.value) {
      fechaCuotaRefuerzo.value = picked;
    }
  }

  void changeInitialDateCuoteRefuerzo(String dateBr) {
    fechaCuotaRefuerzo.value = DateFormatBr().formatBrToUs(dateBr);
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
      "fecha_cuota": fechaCuotaRefuerzo.value.toString(),
      "pago_dolares": valorDolares,
      "pago_guaranies": valorGuaranies,
      "fecha_pago": fechaPago.value.toString()
    };
    var bodyRefuerzo = {
      "id_refuerzo_venta": id,
      "fecha_refuerzo": fechaCuotaRefuerzo.value.toString(),
      "pago_dolares": valorDolares,
      "pago_guaranies": valorGuaranies,
      "fecha_pago": fechaPago.value.toString()
    };
    isLoadingRequest.value = true;
    try {
      if (isCuote) {
        var resCuote = await _sellVehicleRepository.postCuote(bodyCuote);
        List<CuoteDetailModel> _list = await requestCuotes(idVenta);
        listaCuotes.clear();
        listaCuotesGeral.removeWhere((e) => e.idVenta == idVenta);
        listaCuotesGeral.addAll(_list);
        listaCuotes.addAll(_list);
      } else {
        var resRefuerzo =
            await _sellVehicleRepository.postRefuerzo(bodyRefuerzo);
        List<RefuerzoDetailModel> _list = await requestRefuerzos(idVenta);
        listaRefuerzos.clear();
        listaRefuerzosGeral.removeWhere((e) => e.idVenta == idVenta);
        listaRefuerzosGeral.addAll(_list);
        listaRefuerzos.addAll(_list);
      }
      Get.back();
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
        salesAux.clear();
        salesAux.addAll(salesGeral);
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
        salesAux.clear();
        salesAux.addAll(sales);
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
        salesAux.clear();
        salesAux.addAll(sales);
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

    financiadoTotalStr.value = '';

    totalPagadoCuotaStr.value = '';
    totalVentaCuotaStr.value = '';
    totalCantidadPagadoCuotaStr.value = '';
    totalCantidadFaltanteCuotaStr.value = '';

    totalPagadoRefuerzoStr.value = '';
    totalVentaRefuerzoStr.value = '';
    totalCantidadPagadoRefuerzoStr.value = '';
    totalCantidadFaltanteRefuerzoStr.value = '';

    double totalPagadoCuota = 0.0;
    double totalVentaCuota = 0.0;
    double totalCantidadPagadoCuota = 0;
    double totalCantidadFaltanteCuota = 0;

    double totalPagadoRefuerzo = 0.0;
    double totalVentaRefuerzo = 0.0;
    double totalCantidadPagadoRefuerzo = 0;
    double totalCantidadFaltanteRefuerzo = 0;

    bool isGuaranies = true;

    for (var cuote in listaCuotes) {
      if (cuote.cuotaDolares == null) {
        totalVentaCuota =
            (totalVentaCuota + double.parse(cuote.cuotaGuaranies.toString()));
        if (cuote.pagoGuaranies == null) {
          totalCantidadFaltanteCuota = totalCantidadFaltanteCuota + 1;
        } else {
          totalPagadoCuota =
              (totalPagadoCuota + double.parse(cuote.pagoGuaranies.toString()));
          totalCantidadPagadoCuota = totalCantidadPagadoCuota + 1;
        }
      } else {
        isGuaranies = false;
        totalVentaCuota =
            (totalVentaCuota + double.parse(cuote.cuotaDolares.toString()));
        if (cuote.pagoDolares == null) {
          totalCantidadFaltanteCuota = totalCantidadFaltanteCuota + 1;
        } else {
          totalPagadoCuota =
              (totalPagadoCuota + double.parse(cuote.pagoDolares.toString()));
          totalCantidadPagadoCuota = totalCantidadPagadoCuota + 1;
        }
      }
    }

    for (var refuerzo in listaRefuerzos) {
      if (refuerzo.refuerzoDolares == null) {
        totalVentaRefuerzo = (totalVentaRefuerzo +
            double.parse(refuerzo.refuerzoGuaranies.toString()));
        if (refuerzo.pagoGuaranies == null) {
          totalCantidadFaltanteRefuerzo = totalCantidadFaltanteRefuerzo + 1;
        } else {
          totalPagadoRefuerzo = (totalPagadoRefuerzo +
              double.parse(refuerzo.pagoGuaranies.toString()));
          totalCantidadPagadoRefuerzo = totalCantidadPagadoRefuerzo + 1;
        }
      } else {
        totalVentaRefuerzo = (totalVentaRefuerzo +
            double.parse(refuerzo.refuerzoDolares.toString()));
        if (refuerzo.pagoDolares == null) {
          totalCantidadFaltanteRefuerzo = totalCantidadFaltanteRefuerzo + 1;
        } else {
          totalPagadoRefuerzo = (totalPagadoRefuerzo +
              double.parse(refuerzo.pagoDolares.toString()));
          totalCantidadPagadoRefuerzo = totalCantidadPagadoRefuerzo + 1;
        }
      }
    }

    totalPagadoCuotaStr.value = MoneyFormat()
        .formatCommaToDot(totalPagadoCuota, isGuaranies: isGuaranies);
    totalVentaCuotaStr.value = MoneyFormat()
        .formatCommaToDot(totalVentaCuota, isGuaranies: isGuaranies);
    totalCantidadPagadoCuotaStr.value = MoneyFormat()
        .formatCommaToDot(totalCantidadPagadoCuota, isGuaranies: isGuaranies);
    totalCantidadFaltanteCuotaStr.value = MoneyFormat()
        .formatCommaToDot(totalCantidadFaltanteCuota, isGuaranies: isGuaranies);
    totalCuotaFaltanteStr.value = MoneyFormat().formatCommaToDot(
        (totalVentaCuota - totalPagadoCuota),
        isGuaranies: isGuaranies);

    totalPagadoRefuerzoStr.value = MoneyFormat()
        .formatCommaToDot(totalPagadoRefuerzo, isGuaranies: isGuaranies);
    totalVentaRefuerzoStr.value = MoneyFormat()
        .formatCommaToDot(totalVentaRefuerzo, isGuaranies: isGuaranies);
    totalCantidadPagadoRefuerzoStr.value = MoneyFormat().formatCommaToDot(
        totalCantidadPagadoRefuerzo,
        isGuaranies: isGuaranies);
    totalCantidadFaltanteRefuerzoStr.value = MoneyFormat().formatCommaToDot(
        totalCantidadFaltanteRefuerzo,
        isGuaranies: isGuaranies);
    totalRefuerzoFaltanteStr.value = MoneyFormat().formatCommaToDot(
        (totalVentaRefuerzo - totalPagadoRefuerzo),
        isGuaranies: isGuaranies);

    financiadoTotalStr.value = MoneyFormat().formatCommaToDot(
        totalVentaRefuerzo + totalVentaCuota,
        isGuaranies: isGuaranies);
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
    return await _sellVehicleRepository.requestCuotes(idVenta);
  }

  Future<List<RefuerzoDetailModel>> requestRefuerzos(int? idVenta) async {
    return await _sellVehicleRepository.requestRefuerzos(idVenta);
  }
}
