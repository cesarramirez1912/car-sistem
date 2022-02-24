import 'package:car_system/common/date_format.dart';
import 'package:car_system/common/remove_money_format.dart';
import 'package:car_system/controllers/list_vehicle_controller.dart';
import 'package:car_system/models/cuotes.dart';
import 'package:car_system/models/register_client_model.dart';
import 'package:car_system/models/resument_model.dart';
import 'package:car_system/models/sell_vehicle_model.dart';
import 'package:car_system/models/vehicle.dart';
import 'package:car_system/repositories/sell_vehicle_repository.dart';
import 'package:car_system/widgets/snack_bars/snack_bar_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:get/get.dart';

class VehicleDetailController extends GetxController {
  ListVehicleController listVehicleController = ListVehicleController();
  SellVehicleRepository sellVehicleRepository = SellVehicleRepository();
  RxList<Vehicle> vehicles = <Vehicle>[].obs;
  Rx<Vehicle>? vehicleDetail;
  String idVehiculoSucursal = '';

  final formKey = GlobalKey<FormState>();

  RxBool isLoading = false.obs;
  RxList<Vehicle> vehicleSelected = <Vehicle>[].obs;

  RxList<String> typesCobroMensuales = ['3 MESES', '6 MESES', '12 MESES'].obs;
  RxString typeCobroMensualSelected = '3 MESES'.obs;

  RxList<String> typesSell = ['CONTADO', 'FINANCIADO'].obs;
  RxString typeSellSelected = ''.obs;

  RxString typeClientSelectedString = ''.obs;
  Rx<ClientModel> typeClientSelected = ClientModel().obs;

  RxList<String> typesMoney = ['GUARANIES', 'DOLARES'].obs;
  RxString typesMoneySelected = ''.obs;

  RxList<Resumen> listResumen = <Resumen>[].obs;

  RxList<DateTime> listDateGeneratedCuotas = <DateTime>[].obs;
  RxList<DateTime> listDateGeneratedRefuerzos = <DateTime>[].obs;
  Rx<DateTime> firstDateCuoteSelected = DateTime.utc(
          DateTime.now().year, DateTime.now().month + 1, DateTime.now().day)
      .obs;
  Rx<DateTime> firstDateRefuerzoSelected = DateTime.utc(
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

  Rx<SellVehicleModel> sellVehicleModel =
      SellVehicleModel(cuotas: [], refuerzos: []).obs;

  @override
  void onInit() async {
    Map<dynamic, dynamic>? args = Get.parameters;
    typeSellSelected.value = typesSell.first;
    typesMoneySelected.value = typesMoney.first;
    firstDateCuoteSelected.value = DateTime.utc(
        DateTime.now().year, DateTime.now().month + 1, DateTime.now().day);
    firstDateRefuerzoSelected.value = DateTime.utc(
        DateTime.now().year, DateTime.now().month + 1, DateTime.now().day);
    idVehiculoSucursal = args['idVehiculoSucursal'];
    listVehicleController = Get.find<ListVehicleController>();
    vehicles
        .addAll(listVehicleController.getVehiclesFromId(idVehiculoSucursal));
    vehicleDetail?.value = vehicles.first;
    textContadoGuaranies.text = vehicles.first.contadoGuaranies == null
        ? '0'
        : vehicles.first.contadoGuaranies.toString();
    textContadoDolares.text = vehicles.first.contadoDolares.toString() + '00';
    sellVehicleModel.value.idVehiculoSucursal =
        vehicles.first.idVehiculoSucursal;
  }

  void seletVehicleToSel() {
    vehicleSelected.addAll(vehicles);
  }

  void selectedPlan(Cuota _cuota) {
    cuota.value = _cuota;
    Get.back();
  }

  Future<void> selectDateCuote(
      BuildContext context, DateTime dateTime, int index) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: dateTime,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != dateTime) {
      listDateGeneratedCuotas[index] = picked;
    }
  }

  Future<void> selectDateRefuerzo(
      BuildContext context, DateTime dateTime, int index) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: dateTime,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != dateTime) {
      listDateGeneratedRefuerzos[index] = picked;
    }
  }

  Future<void> firstDateCuote(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        locale: const Locale('es'),
        initialDate: firstDateCuoteSelected.value,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != firstDateCuoteSelected) {
      firstDateCuoteSelected.value = picked;
    }
  }

  Future<void> firstDateRefuerzo(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        locale: const Locale('es'),
        initialDate: firstDateRefuerzoSelected.value,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != firstDateRefuerzoSelected) {
      firstDateRefuerzoSelected.value = picked;
    }
  }

  void generatedDatesCuotes() {
    listDateGeneratedCuotas.value = List<DateTime>.generate(
      cuota.value.cantidadCuotas,
      (i) => DateTime.utc(
        firstDateCuoteSelected.value.year,
        firstDateCuoteSelected.value.month + i,
        firstDateCuoteSelected.value.day,
      ),
    );
  }

  void generatedDatesRefuerzos() {
    String valueFromString = typeCobroMensualSelected.value.substring(0, 2);
    if (cuota.value.cantidadRefuerzo != null) {
      int typeCobroMensualSelectedInt = int.parse(valueFromString);
      List<DateTime> listGeneratedAux = List<DateTime>.generate(
        cuota.value.cantidadRefuerzo * typeCobroMensualSelectedInt,
        (i) => DateTime.utc(
          firstDateRefuerzoSelected.value.year,
          firstDateRefuerzoSelected.value.month + i,
          firstDateRefuerzoSelected.value.day,
        ),
      );
      listDateGeneratedRefuerzos.clear();
      for (int i = 0; i < listGeneratedAux.length; i++) {
        if (i != 0) {
          if ((i % typeCobroMensualSelectedInt) == 0) {
            listDateGeneratedRefuerzos.add(listGeneratedAux[i]);
          }
        } else {
          listDateGeneratedRefuerzos.add(listGeneratedAux[i]);
        }
      }
    }
  }

  void generatedDatesResumen() {
    listResumen.clear();
    for (int i = 0; i < listDateGeneratedCuotas.length; i++) {
      listResumen.add(
        Resumen(
          fechaCuota: DateFormatBr()
              .formatBrFromString(listDateGeneratedRefuerzos[i].toString()),
          fechaRefuerzo: DateFormatBr()
              .formatBrFromString(listDateGeneratedRefuerzos[i].toString()),
          valorCuota: cuota.value.cuotaGuaranies,
          valorRefuerzo: cuota.value.cuotaGuaranies,
        ),
      );
    }
  }

  void registerCuota() async {
    if (formKeyDialog.currentState == null) {
    } else if (formKeyDialog.currentState!.validate()) {
      formKeyDialog.currentState!.save();
      cuota.value.entradaGuaranies =
          RemoveMoneyFormat().removeToString(cuota.value.entradaGuaranies);
      cuota.value.cuotaGuaranies =
          RemoveMoneyFormat().removeToString(cuota.value.cuotaGuaranies);
      cuota.value.refuerzoGuaranies =
          RemoveMoneyFormat().removeToString(cuota.value.refuerzoGuaranies);
      cuota.value.entradaDolares =
          RemoveMoneyFormat().removeToString(cuota.value.entradaDolares);
      cuota.value.cuotaDolares =
          RemoveMoneyFormat().removeToString(cuota.value.cuotaDolares);
      cuota.value.refuerzoDolares =
          RemoveMoneyFormat().removeToString(cuota.value.refuerzoDolares);

      if (cuota.value.entradaDolares != null) {
        if (double.parse(cuota.value.entradaDolares) == 0.0) {
          cuota.value.entradaDolares = null;
        }
      }

      if (cuota.value.cuotaDolares != null) {
        if (double.parse(cuota.value.cuotaDolares) == 0.0) {
          cuota.value.cuotaDolares = null;
        }
      }

      if (cuota.value.refuerzoDolares != null) {
        if (double.parse(cuota.value.refuerzoDolares) == 0.0) {
          cuota.value.refuerzoDolares = null;
        }
      }

      if (cuota.value.entradaGuaranies != null) {
        if (int.parse(cuota.value.entradaGuaranies) == 0) {
          cuota.value.entradaGuaranies = null;
        }
      }

      if (cuota.value.cuotaGuaranies != null) {
        if (int.parse(cuota.value.cuotaGuaranies) == 0) {
          cuota.value.cuotaGuaranies = null;
        }
      }

      if (cuota.value.refuerzoGuaranies != null) {
        if (int.parse(cuota.value.refuerzoGuaranies) == 0) {
          cuota.value.refuerzoGuaranies = null;
        }
      }

      cuota.refresh();

      Get.back();
    }
  }

  Future<bool> registerSale() async {
    if (formKey.currentState == null) {
      return false;
    } else if (formKey.currentState!.validate()) {
      isLoading.value = true;
      try {
        formKey.currentState!.save();
        sellVehicleModel.value.fechaVenta = DateTime.now().toString();

        if (textCantidadRefuerzos.text.isNotEmpty) {
          generatedDatesRefuerzos();
        }
        if (textCantidadCuotas.text.isNotEmpty ||
            cuota.value.cantidadCuotas != null) {
          generatedDatesCuotes();
        }

        if (typeSellSelected != 'CONTADO') {
          if (typesMoneySelected == 'GUARANIES' &&
                  cuota.value.cuotaGuaranies == null ||
              typesMoneySelected == 'DOLARES' &&
                  cuota.value.cuotaDolares == null) {
            isLoading.value = false;
            CustomSnackBarError('SIN VALOR EN CUOTA! HACER UN NUEVO PLAN');
            return false;
          }

          sellVehicleModel.value.entradaDolares =
              RemoveMoneyFormat().removeToString(cuota.value.entradaDolares);
          sellVehicleModel.value.entradaGuaranies =
              RemoveMoneyFormat().removeToString(cuota.value.entradaGuaranies);

          if (listDateGeneratedCuotas.isNotEmpty) {
            sellVehicleModel.value.cuotas?.clear();
            for (var fecha in listDateGeneratedCuotas) {
              sellVehicleModel.value.cuotas?.add(Cuotas(
                  cuotaGuaranies: cuota.value.cuotaGuaranies.toString(),
                  cuotaDolares: cuota.value.cuotaDolares.toString(),
                  fechaCuota: fecha.toString()));
            }
          }
          if (listDateGeneratedRefuerzos.isNotEmpty) {
            sellVehicleModel.value.refuerzos?.clear();
            for (var fecha in listDateGeneratedRefuerzos) {
              sellVehicleModel.value.refuerzos?.add(Refuerzos(
                  refuerzoGuaranies: cuota.value.refuerzoGuaranies.toString(),
                  refuerzoDolares: cuota.value.refuerzoDolares.toString(),
                  fechaRefuerzo: fecha.toString()));
            }
          }
        } else {
          sellVehicleModel.value.contadoGuaranies = RemoveMoneyFormat()
              .removeToString(sellVehicleModel.value.contadoGuaranies);
          sellVehicleModel.value.contadoDolares = RemoveMoneyFormat()
              .removeToString(sellVehicleModel.value.contadoDolares);
        }
        var responseSellVehicle =
            await sellVehicleRepository.sellVehicle(sellVehicleModel.toJson());

        formKey.currentState!.reset();
        isLoading.value = false;
        return true;
      } catch (e) {
        CustomSnackBarError(e.toString());
        isLoading.value = false;
        return false;
      }
    } else {
      isLoading.value = false;
      CustomSnackBarError('Falta completar algun campo');
      return false;
    }
  }

  void cleanInputsCuotes() {
    cuota.value.entradaGuaranies = null;
    cuota.value.entradaDolares = null;

    cuota.value.cuotaGuaranies = null;
    cuota.value.cuotaDolares = null;

    cuota.value.cantidadRefuerzo = null;
    cuota.value.cantidadCuotas = null;

    cuota.value.refuerzoDolares = null;
    cuota.value.refuerzoGuaranies = null;

    textCantidadRefuerzos.text = '';
    textCantidadCuotas.text = '';

    textCuotaGuaranies.text = '0';
    textCuotaDolares.text = '000';

    textRefuezoDolares.text = '000';
    textRefuezoGuaranies.text = '00';

    textEntradaGuaranies.text = '0';
    textEntradaDolares.text = '000';

    sellVehicleModel.value.refuerzos?.clear();
    sellVehicleModel.value.cuotas?.clear();

    listDateGeneratedCuotas.clear();
    listDateGeneratedRefuerzos.clear();
  }

  void sellVehicle() {
    try {
      SellVehicleModel sellVehicleModel = SellVehicleModel(
          idVehiculoSucursal: vehicleDetail?.value.idVehiculoSucursal,
          entradaGuaranies: 10,
          entradaDolares: 20,
          idCliente: 1,
          idColaborador: vehicleDetail?.value.idVehiculoSucursal,
          idEmpresa: vehicleDetail?.value.idVehiculoSucursal,
          idSucursal: vehicleDetail?.value.idSucursal);
      //  sellVehicleRepository.sellVehicle(_body);
    } catch (e) {
      CustomSnackBarError(e.toString());
    }
  }
}
