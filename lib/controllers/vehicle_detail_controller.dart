import 'dart:math';

import 'package:car_system/controllers/list_vehicle_controller.dart';
import 'package:car_system/controllers/login_controller.dart';
import 'package:car_system/models/cuotes.dart';
import 'package:car_system/models/user_model.dart';
import 'package:car_system/models/vehicle.dart';
import 'package:car_system/repositories/home_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:get/get.dart';

class VehicleDetailController extends GetxController {
  ListVehicleController listVehicleController = ListVehicleController();
  RxList<Vehicle> vehicles = <Vehicle>[].obs;
  Rx<Vehicle>? vehicleDetail;
  String idVehiculoSucursal = '';

  RxBool isLoading = false.obs;
  RxList<Vehicle> vehicleSelected = <Vehicle>[].obs;

  RxList<String> typesSell = ['CONTADO', 'CREDITO'].obs;
  RxString typeSellSelected = ''.obs;

  RxList<String> typesMoney = ['GUARANIES', 'DOLARES'].obs;
  RxString typesMoneySelected = ''.obs;

  RxList<DateTime> listDateGenerated = <DateTime>[].obs;
  Rx<DateTime> firstDateCuoteSelected = DateTime.utc(
          DateTime.now().year, DateTime.now().month + 1, DateTime.now().day)
      .obs;

  final formKeyDialog = GlobalKey<FormState>();

  TextEditingController textDiaVencimientoCuota =
      TextEditingController(text: '5');
  TextEditingController textDiaVencimientoRefuerzo =
      TextEditingController(text: '5');

  //DIALOG INPUTS
  Rx<Cuota> cuota = Cuota().obs;
  TextEditingController textCantidadCuotas = TextEditingController();
  TextEditingController textCantidadRefuerzos = TextEditingController();
  MoneyMaskedTextController textEntradaGuaranies = MoneyMaskedTextController(
      leftSymbol: 'G\$ ', precision: 0, decimalSeparator: '');
  MoneyMaskedTextController textCuotaGuaranies = MoneyMaskedTextController(
      leftSymbol: 'G\$ ', precision: 0, decimalSeparator: '');
  MoneyMaskedTextController textEntradaDolares =
      MoneyMaskedTextController(leftSymbol: 'U\$ ');
  MoneyMaskedTextController textCuotaDolares =
      MoneyMaskedTextController(leftSymbol: 'U\$ ');
  MoneyMaskedTextController textRefuezoGuaranies = MoneyMaskedTextController(
      leftSymbol: 'G\$ ', precision: 0, decimalSeparator: '');
  MoneyMaskedTextController textRefuezoDolares =
      MoneyMaskedTextController(leftSymbol: 'U\$ ');

  MoneyMaskedTextController textContadoGuaranies = MoneyMaskedTextController(
      leftSymbol: 'G\$ ', precision: 0, decimalSeparator: '');
  MoneyMaskedTextController textContadoDolares =
      MoneyMaskedTextController(leftSymbol: 'U\$ ');

  @override
  void onInit() async {
    Map<dynamic, dynamic>? args = Get.parameters;
    typeSellSelected.value = typesSell.first;
    typesMoneySelected.value = typesMoney.first;
    firstDateCuoteSelected.value = DateTime.utc(
        DateTime.now().year, DateTime.now().month + 1, DateTime.now().day);
    idVehiculoSucursal = args['idVehiculoSucursal'];
    listVehicleController = Get.find<ListVehicleController>();
    vehicles
        .addAll(listVehicleController.getVehiclesFromId(idVehiculoSucursal));
    vehicleDetail?.value = vehicles.first;
  }

  void seletVehicleToSel() {
    vehicleSelected.addAll(vehicles);
  }

  void selectedPlan(Cuota _cuota) {
    cuota.value = _cuota;
    Get.back();
  }

  Future<void> selectDate(
      BuildContext context, DateTime dateTime, int index) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: dateTime,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != dateTime) {
      listDateGenerated[index] = picked;
    }
  }

  Future<void> firstDateCuote(BuildContext context) async {
    print('acaes');
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: firstDateCuoteSelected.value,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != firstDateCuoteSelected) {
      firstDateCuoteSelected.value = picked;
    }
  }

  void generatedDates() {
    listDateGenerated.value = List<DateTime>.generate(
        cuota.value.cantidadCuotas,
        (i) => DateTime.utc(
              firstDateCuoteSelected.value.year,
              firstDateCuoteSelected.value.month + i,
              firstDateCuoteSelected.value.day,
            ));
  }

  void registerCuota() async {
    if (formKeyDialog.currentState == null) {
      print("formKeyDialog.currentState is null!");
    } else if (formKeyDialog.currentState!.validate()) {
      formKeyDialog.currentState!.save();

      cuota.value.entradaGuaranies = cuota.value.entradaGuaranies
          .toString()
          .replaceAll('G\$', '')
          .replaceAll('.', '')
          .replaceAll(' ', '');
      cuota.value.cuotaGuaranies = cuota.value.cuotaGuaranies
          .toString()
          .replaceAll('G\$', '')
          .replaceAll('.', '')
          .replaceAll(' ', '');
      cuota.value.refuerzoGuaranies = cuota.value.refuerzoGuaranies
          .toString()
          .replaceAll('G\$', '')
          .replaceAll('.', '')
          .replaceAll(' ', '');
      cuota.value.entradaDolares = cuota.value.entradaDolares
          .toString()
          .replaceAll('U\$', '')
          .replaceAll('.', '')
          .replaceAll(',', '.')
          .replaceAll(' ', '');
      cuota.value.cuotaDolares = cuota.value.cuotaDolares
          .toString()
          .replaceAll('U\$', '')
          .replaceAll('.', '')
          .replaceAll(',', '.')
          .replaceAll(' ', '');
      cuota.value.refuerzoDolares = cuota.value.refuerzoDolares
          .toString()
          .replaceAll('U\$', '')
          .replaceAll('.', '')
          .replaceAll(',', '.')
          .replaceAll(' ', '');

      if (cuota.value.entradaDolares != 'null') {
        if (double.parse(cuota.value.entradaDolares) == 0.0) {
          cuota.value.entradaDolares = null;
        }
      } else {
        cuota.value.entradaDolares = null;
      }

      if (cuota.value.cuotaDolares != 'null') {
        if (double.parse(cuota.value.cuotaDolares) == 0.0) {
          cuota.value.cuotaDolares = null;
        }
      } else {
        cuota.value.cuotaDolares = null;
      }

      if (cuota.value.refuerzoDolares != 'null') {
        if (double.parse(cuota.value.refuerzoDolares) == 0.0) {
          cuota.value.refuerzoDolares = null;
        }
      } else {
        cuota.value.refuerzoDolares = null;
      }

      if (cuota.value.entradaGuaranies != 'null') {
        if (int.parse(cuota.value.entradaGuaranies) == 0) {
          cuota.value.entradaGuaranies = null;
        }
      } else {
        cuota.value.entradaGuaranies = null;
      }
      if (cuota.value.cuotaGuaranies != 'null') {
        if (int.parse(cuota.value.cuotaGuaranies) == 0) {
          cuota.value.cuotaGuaranies = null;
        }
      } else {
        cuota.value.cuotaGuaranies = null;
      }

      if (cuota.value.refuerzoGuaranies != 'null') {
        if (int.parse(cuota.value.refuerzoGuaranies) == 0) {
          cuota.value.refuerzoGuaranies = null;
        }
      } else {
        cuota.value.refuerzoGuaranies = null;
      }
      cuota.refresh();

      Get.back();
    }
  }
}
