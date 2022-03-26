import 'package:car_system/app/data/enums/types_moneys.dart';
import 'package:car_system/app/data/enums/types_sells.dart';
import 'package:car_system/app/data/repositories/remote/sells_repository.dart';
import 'package:car_system/app/global_widgets/dialog_confirm.dart';
import 'package:car_system/app/global_widgets/dialog_fetch.dart';
import 'package:car_system/app/global_widgets/input.dart';
import 'package:car_system/app/global_widgets/snack_bars/snack_bar_success.dart';
import 'package:car_system/app/global_widgets/spacing.dart';
import 'package:car_system/app/global_widgets/title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:get/get.dart';
import '../../core/utils/remove_money_format.dart';
import '../../data/models/cuotes.dart';
import '../../data/models/date_value_model.dart';
import '../../data/models/register_client_model.dart';
import '../../data/models/resument_model.dart';
import '../../data/models/sell_vehicle_model.dart';
import '../../data/models/vehicle.dart';
import '../../global_widgets/snack_bars/snack_bar_error.dart';
import '../list_vehicles/list_vehicle_controller.dart';

class VehicleDetailController extends GetxController {
  final ListVehicleController listVehicleController = Get.find();
  final SellsRepository _sellVehicleRepository = Get.find();
  RxList<Vehicle> vehicles = <Vehicle>[].obs;
  Rx<Vehicle>? vehicleDetail;
  String idVehiculoSucursal = '';

  final RemoveMoneyFormat _remove = RemoveMoneyFormat();

  final formKey = GlobalKey<FormState>();

  RxBool isLoading = false.obs;
  RxList<Vehicle> vehicleSelected = <Vehicle>[].obs;

  RxList<String> typesCobroMensuales = ['3 MESES', '6 MESES', '12 MESES'].obs;
  RxString typeCobroMensualSelected = '3 MESES'.obs;

  RxList<TypesSells> typesSell =
      [TypesSells.CONTADO, TypesSells.FINANCIADO].obs;
  Rx<TypesSells> typeSellSelected = TypesSells.CONTADO.obs;

  RxString typeClientSelectedString = ''.obs;
  Rx<ClientModel> typeClientSelected = ClientModel().obs;

  RxList<TypesMoneys> typesMoney =
      [TypesMoneys.GUARANIES, TypesMoneys.GUARANIES].obs;
  Rx<TypesMoneys> typesMoneySelected = TypesMoneys.GUARANIES.obs;

  RxList<Resumen> listResumen = <Resumen>[].obs;

  RxList<DateValue> listDateGeneratedCuotas = <DateValue>[].obs;
  RxList<DateValue> listDateGeneratedRefuerzos = <DateValue>[].obs;
  Rx<DateTime> firstDateCuoteSelected = DateTime.utc(
          DateTime.now().year, DateTime.now().month + 1, DateTime.now().day)
      .obs;
  Rx<DateTime> firstDateRefuerzoSelected = DateTime.utc(
          DateTime.now().year, DateTime.now().month + 1, DateTime.now().day)
      .obs;

  Rx<DateTime> dateFromSell = DateTime.utc(
          DateTime.now().year, DateTime.now().month, DateTime.now().day)
      .obs;

  final formKeyDialog = GlobalKey<FormState>();

  TextEditingController textDiaVencimientoCuota =
      TextEditingController(text: '5');
  TextEditingController textDiaVencimientoRefuerzo =
      TextEditingController(text: '5');

  //DIALOG INPUTS
  Rx<Cuota> cuota = Cuota().obs;

  //-------------------- INPUTS DIALOG --------------------
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

  //-------------------- FIN DIALOG --------------------

  //-------------------- CONTADO --------------------
  MoneyMaskedTextController textContadoGuaranies = MoneyMaskedTextController(
      leftSymbol: 'G\$ ', precision: 0, decimalSeparator: '');
  MoneyMaskedTextController textContadoDolares =
      MoneyMaskedTextController(leftSymbol: 'U\$ ');

  //-------------------- FIN CONTADO --------------------

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

  List<String> listTypesMoney() {
    List<String> _values = [];
    for (var i in TypesMoneys.values) {
      _values.add(i.name.toString());
    }
    return _values;
  }

  List<String> listTypesSells() {
    List<String> _values = [];
    for (var i in TypesSells.values) {
      _values.add(i.name.toString());
    }
    return _values;
  }

  void setCuoteInDialog() {
    textCantidadCuotas.text =
        verifyIsNull(cuota.value.cantidadCuotas.toString(), valueToReturn: '');
    textCantidadRefuerzos.text = verifyIsNull(
        cuota.value.cantidadRefuerzo.toString(),
        valueToReturn: '');
    textEntradaGuaranies.text =
        verifyIsNull(cuota.value.entradaGuaranies.toString());
    textCuotaGuaranies.text =
        verifyIsNull(cuota.value.cuotaGuaranies.toString());
    textEntradaDolares.text =
        verifyIsNull(cuota.value.entradaDolares.toString());
    textCuotaDolares.text = verifyIsNull(cuota.value.cuotaDolares.toString());
    textRefuezoGuaranies.text =
        verifyIsNull(cuota.value.refuerzoGuaranies.toString());
    textRefuezoDolares.text =
        verifyIsNull(cuota.value.refuerzoDolares.toString());
  }

  String verifyIsNull(dynamic value, {String? valueToReturn}) {
    if (value == 'null') {
      if (valueToReturn == null) {
        return '0';
      } else {
        return valueToReturn;
      }
    } else {
      return value;
    }
  }

  void seletVehicleToSel() {
    vehicleSelected.addAll(vehicles);
  }

  Future<void> deleteVehicle(BuildContext context) async {
    bool? responseCustom = await CustomDialogConfirm(context,
        text: 'Desea eliminar el vehiculo ?');
    if (responseCustom != null && responseCustom) {
      await CustomDialogFetch(
          () async => await _sellVehicleRepository
              .deleteVehicleSucursal(idVehiculoSucursal),
          text: 'Eliminando vehiculo...');
      Get.back();
      CustomSnackBarSuccess('Vehiculo eliminado con exito!');
      listVehicleController.fetchVehicles();
    }
  }

  Future<void> deletePlan(BuildContext context, int idPlan, int index) async {
    bool? responseCustom = await CustomDialogConfirm(context,
        text: 'Desea eliminar el plan n $index ?');
    if (responseCustom != null && responseCustom) {
      await CustomDialogFetch(
          () async => await _sellVehicleRepository.deletePlan(idPlan),
          text: 'Eliminando plan...');
      Get.back();
      CustomSnackBarSuccess('Plan eliminado con exito!');
      listVehicleController.fetchVehicles();
    }
  }

  Future<void> selectDateCuote(
      BuildContext context, DateTime dateTime, int index) async {
    List<DateValue> _auxDateValue = [...listDateGeneratedCuotas];

    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: dateTime,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != dateTime) {
      listDateGeneratedCuotas[index].date = picked;
      listDateGeneratedCuotas.clear();
      listDateGeneratedCuotas.addAll(_auxDateValue);
    }
  }

  Future<void> selectDateRefuerzo(
      BuildContext context, DateTime dateTime, int index) async {
    List<DateValue> _auxDateValue = [...listDateGeneratedRefuerzos];

    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: dateTime,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != dateTime) {
      listDateGeneratedRefuerzos[index].date = picked;
      listDateGeneratedRefuerzos.clear();
      listDateGeneratedRefuerzos.addAll(_auxDateValue);
    }
  }

  Future<void> changeValue(
      BuildContext context, int index, bool isCuote) async {
    MoneyMaskedTextController dolaresFormat =
        MoneyMaskedTextController(leftSymbol: 'U\$ ', initialValue: 0);
    MoneyMaskedTextController guaraniesFormat = MoneyMaskedTextController(
        leftSymbol: 'G\$ ',
        precision: 0,
        decimalSeparator: '',
        initialValue: 0);

    bool isDolar = typesMoneySelected.value == TypesMoneys.DOLARES;

    if (isCuote) {
      if (isDolar) {
        dolaresFormat.text = listDateGeneratedCuotas[index].cuotaDolares;
      } else {
        guaraniesFormat.text =
            listDateGeneratedCuotas[index].cuotaGuaranies.toString();
      }
    } else {
      if (isDolar) {
        dolaresFormat.text = listDateGeneratedRefuerzos[index].refuerzoDolares;
      } else {
        guaraniesFormat.text =
            listDateGeneratedRefuerzos[index].refuerzoGuaranies.toString();
      }
    }

    String newValue = '';
    List<DateValue> _auxDateValue = isCuote
        ? [...listDateGeneratedCuotas]
        : [...listDateGeneratedRefuerzos];
    bool? responseDialog = await CustomDialogConfirm(
      context,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomSpacing(height: 10),
          CustomTitle('Editar valor'),
          CustomSpacing(height: 10),
          CustomInput(
            'Editar valor',
            'Editar valor',
            onChanged: (value) => newValue = value,
            textEditingController: isDolar ? dolaresFormat : guaraniesFormat,
          )
        ],
      ),
    );
    if (responseDialog != null && responseDialog) {
      double doubleValue = _remove.removeToDouble(newValue);
      if (isCuote) {
        if (isDolar) {
          _auxDateValue[index].cuotaDolares = doubleValue;
        } else {
          _auxDateValue[index].cuotaGuaranies = doubleValue;
        }
        listDateGeneratedCuotas.clear();
        listDateGeneratedCuotas.addAll(_auxDateValue);
      } else {
        if (isDolar) {
          _auxDateValue[index].refuerzoDolares = doubleValue;
        } else {
          _auxDateValue[index].refuerzoGuaranies = doubleValue;
        }
        listDateGeneratedRefuerzos.clear();
        listDateGeneratedRefuerzos.addAll(_auxDateValue);
      }
    }
  }

  Future<void> changeDateFromSell(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        locale: const Locale('es'),
        initialDate: dateFromSell.value,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != dateFromSell.value) {
      dateFromSell.value = picked;
    }
  }

  Future<void> firstDateCuote(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        locale: const Locale('es'),
        initialDate: firstDateCuoteSelected.value,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != firstDateCuoteSelected.value) {
      firstDateCuoteSelected.value = picked;
      generatedDatesCuotes();
    }
  }

  Future<void> firstDateRefuerzo(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        locale: const Locale('es'),
        initialDate: firstDateRefuerzoSelected.value,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != firstDateRefuerzoSelected.value) {
      firstDateRefuerzoSelected.value = picked;
      generatedDatesRefuerzos();
    }
  }

  void generatedDatesCuotes() {
    listDateGeneratedCuotas.value = List<DateValue>.generate(
      cuota.value.cantidadCuotas,
      (i) => DateValue(
          date: DateTime.utc(
            firstDateCuoteSelected.value.year,
            firstDateCuoteSelected.value.month + i,
            firstDateCuoteSelected.value.day,
          ),
          cuotaGuaranies: cuota.value.cuotaGuaranies,
          cuotaDolares: cuota.value.cuotaDolares),
    );
  }

  void generatedDatesRefuerzos() {
    String months = typeCobroMensualSelected.value.substring(0, 2);
    if (cuota.value.cantidadRefuerzo != null) {
      int monthInteger = int.parse(months);
      List<DateValue> listGeneratedAux = List<DateValue>.generate(
        cuota.value.cantidadRefuerzo * monthInteger,
        (i) => DateValue(
            date: DateTime.utc(
              firstDateRefuerzoSelected.value.year,
              firstDateRefuerzoSelected.value.month + i,
              firstDateRefuerzoSelected.value.day,
            ),
            refuerzoDolares: cuota.value.refuerzoDolares,
            refuerzoGuaranies: cuota.value.refuerzoGuaranies),
      );

      listDateGeneratedRefuerzos.clear();

      for (int i = 0; i < listGeneratedAux.length; i++) {
        if (i != 0) {
          if ((i % monthInteger) == 0) {
            listDateGeneratedRefuerzos.add(listGeneratedAux[i]);
          }
        } else {
          listDateGeneratedRefuerzos.add(listGeneratedAux[i]);
        }
      }
    }
  }

  void registerCuota() async {
    if (formKeyDialog.currentState == null) {
    } else if (formKeyDialog.currentState!.validate()) {
      formKeyDialog.currentState!.save();
      if (typesMoneySelected.value == TypesMoneys.DOLARES) {
      } else {}
      cuota.value = cuotaTratada();
      generatedDatesCuotes();
      if (cuota.value.cantidadRefuerzo != null) {
        if (cuota.value.cantidadRefuerzo > 0) {
          generatedDatesRefuerzos();
        }
      }
      Get.back();
    }
  }

  void selectedPlan(Cuota _cuota) {
    cuota.value = cuotaTratada(cuote: _cuota);
    generatedDatesCuotes();
    if (_cuota.cantidadRefuerzo != null) {
      generatedDatesRefuerzos();
    }
    Get.back();
  }

  Cuota cuotaTratada({Cuota? cuote}) {
    List<String> keysDols = [
      'entrada_dolares',
      'cuota_dolares',
      'refuerzo_dolares'
    ];

    List<String> keysGs = [
      'entrada_guaranies',
      'cuota_guaranies',
      'refuerzo_guaranies'
    ];

    Map<String, dynamic> cuotaJson =
        cuote == null ? cuota.value.toJson() : cuote.toJson();
    for (var i = 0; i < keysGs.length; i++) {
      String? guaraniStr = _remove.removeToString(cuotaJson[keysGs[i]]);
      String? dolarStr = _remove.removeToString(cuotaJson[keysDols[i]]);
      cuotaJson[keysDols[i]] = dolarStr;
      cuotaJson[keysGs[i]] = guaraniStr;
      if (typesMoneySelected.value == TypesMoneys.DOLARES) {
        cuotaJson[keysGs[i]] = null;
        //dolares
        if (dolarStr != null) {
          if (double.parse(dolarStr) == 0) {
            cuotaJson[keysDols[i]] = null;
          }
        }
      } else {
        cuotaJson[keysDols[i]] = null;
        //guaranies
        if (guaraniStr != null) {
          if (int.parse(guaraniStr) == 0) {
            cuotaJson[keysGs[i]] = null;
          }
        }
      }
    }
    return Cuota.fromJson(cuotaJson);
  }

  Future<bool> registerSale() async {
    if (formKey.currentState == null) {
      return false;
    } else if (formKey.currentState!.validate()) {
      isLoading.value = true;
      try {
        formKey.currentState!.save();
        sellVehicleModel.value.fechaVenta = dateFromSell.value.toString();

        if (typeSellSelected.value != TypesSells.CONTADO) {
          if (typesMoneySelected.value == TypesMoneys.GUARANIES &&
                  cuota.value.cuotaGuaranies == null ||
              typesMoneySelected.value == TypesMoneys.DOLARES &&
                  cuota.value.cuotaDolares == null) {
            isLoading.value = false;
            CustomSnackBarError('SIN VALOR EN CUOTA! HACER UN NUEVO PLAN');
            return false;
          }
          sellVehicleModel.value.entradaDolares =
              _remove.removeToString(cuota.value.entradaDolares);
          sellVehicleModel.value.entradaGuaranies =
              _remove.removeToString(cuota.value.entradaGuaranies);
          if (listDateGeneratedCuotas.isNotEmpty) {
            sellVehicleModel.value.cuotas?.clear();
            for (var fecha in listDateGeneratedCuotas) {
              sellVehicleModel.value.cuotas?.add(Cuotas(
                  cuotaGuaranies: fecha.cuotaGuaranies.toString(),
                  cuotaDolares: fecha.cuotaDolares.toString(),
                  fechaCuota: fecha.date.toString()));
            }
          }
          if (listDateGeneratedRefuerzos.isNotEmpty) {
            sellVehicleModel.value.refuerzos?.clear();
            for (var fecha in listDateGeneratedRefuerzos) {
              sellVehicleModel.value.refuerzos?.add(
                Refuerzos(
                  refuerzoGuaranies: fecha.refuerzoGuaranies.toString(),
                  refuerzoDolares: fecha.refuerzoDolares.toString(),
                  fechaRefuerzo: fecha.date.toString(),
                ),
              );
            }
          }
        } else {
          sellVehicleModel.value.contadoGuaranies =
              _remove.removeToString(sellVehicleModel.value.contadoGuaranies);
          sellVehicleModel.value.contadoDolares =
              _remove.removeToString(sellVehicleModel.value.contadoDolares);
        }
        var responseSellVehicle =
            await _sellVehicleRepository.sellVehicle(sellVehicleModel.toJson());

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

  bool conditionalPlan() {
    if (typeSellSelected.value == TypesSells.FINANCIADO) {
      if (typesMoneySelected.value == TypesMoneys.DOLARES) {
        if (cuota.value.cantidadRefuerzo != null) {
          if (cuota.value.refuerzoDolares != null) {
            return true;
          } else {
            return false;
          }
        }
        if (cuota.value.cantidadCuotas != null) {
          if (cuota.value.cuotaDolares != null) {
            return true;
          } else {
            return false;
          }
        }
      } else {
        if (cuota.value.cantidadRefuerzo != null) {
          if (cuota.value.refuerzoGuaranies != null) {
            return true;
          } else {
            return false;
          }
        }
        if (cuota.value.cantidadCuotas != null) {
          if (cuota.value.cuotaGuaranies != null) {
            return true;
          } else {
            return false;
          }
        }
      }

      return false;
    }
    return false;
  }
}
