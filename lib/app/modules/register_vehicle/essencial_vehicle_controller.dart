import 'dart:async';
import 'package:car_system/app/data/models/essencial_vehicle_models/color.dart';
import 'package:car_system/app/data/repositories/remote/essencial_vehicle_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:get/get.dart';
import '../../../rest.dart';
import '../../core/utils/remove_money_format.dart';
import '../../core/utils/user_storage_controller.dart';
import '../../data/models/create_vehicle.dart';
import '../../data/models/cuotes.dart';
import '../../data/models/essencial_vehicle_models/brand.dart';
import '../../data/models/essencial_vehicle_models/fuel.dart';
import '../../data/models/essencial_vehicle_models/gear.dart';
import '../../data/models/essencial_vehicle_models/model.dart';
import '../../data/models/essencial_vehicle_models/motor.dart';
import '../../data/models/user_model.dart';
import '../../global_widgets/dialog_fetch.dart';
import '../../global_widgets/snack_bars/snack_bar_error.dart';

class EssencialVehicleController extends GetxController {
  User? user = User();
  final formKey = GlobalKey<FormState>();
  final formKeyDialog = GlobalKey<FormState>();
  Rx<bool> isLoading = false.obs;
  final EssencialVehiclesRepository _essencialVehicleRepository = Get.find();

  Rx<CreateVehicle> createVehicle = CreateVehicle().obs;
  RxList<Cuota> listCuota = <Cuota>[].obs;
  Rx<Cuota> cuota = Cuota().obs;

  FocusNode myFocusNode = FocusNode();
  FocusNode myFocusNode2 = FocusNode();

  Rx<Brand> brandSelected = Brand().obs;
  Rx<Model> modelSelected = Model().obs;

  RxList<String> listStringBrand = <String>[].obs;
  RxList<String> listStringModel = <String>[].obs;
  RxList<String> listStringFuel = <String>[].obs;
  RxList<String> listStringColor = <String>[].obs;
  RxList<String> listStringMotor = <String>[].obs;
  RxList<String> listStringCambio = <String>[].obs;

  RxList<Brand> listBrand = <Brand>[].obs;
  RxList<Model> listModel = <Model>[].obs;
  RxList<Model> listModelAux = <Model>[].obs;
  RxList<Fuel> listFuel = <Fuel>[].obs;
  RxList<Color> listColor = <Color>[].obs;
  RxList<Motor> listMotor = <Motor>[].obs;
  RxList<Gear> listGear = <Gear>[].obs;

  //VEHICULO REGISTRO
  TextEditingController textBrandController = TextEditingController();
  TextEditingController textModelController = TextEditingController();
  TextEditingController textFuelController = TextEditingController();
  TextEditingController textColorController = TextEditingController();
  TextEditingController textMotorController = TextEditingController();
  MoneyMaskedTextController textGuaraniesCosto = MoneyMaskedTextController(
      leftSymbol: 'G\$ ', precision: 0, decimalSeparator: '');
  MoneyMaskedTextController textDolaresCosto =
      MoneyMaskedTextController(leftSymbol: 'U\$ ');
  MoneyMaskedTextController textGuaraniesVenta = MoneyMaskedTextController(
      leftSymbol: 'G\$ ', precision: 0, decimalSeparator: '');
  MoneyMaskedTextController textDolaresVenta =
      MoneyMaskedTextController(leftSymbol: 'U\$ ');
  MaskedTextController textNumeroChapa = MaskedTextController(mask: '********');
  MaskedTextController maskTextNumeroChapa =
      MaskedTextController(mask: '000.000.000-00');

  //PLANES FINANCIACION DIALOG
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

  MoneyMaskedTextController textTotalDolares =
      MoneyMaskedTextController(leftSymbol: 'U\$ ');
  MoneyMaskedTextController textTotalGuaranies = MoneyMaskedTextController(
      leftSymbol: 'G\$ ', precision: 0, decimalSeparator: '');

  RxString textTotalGuaraniesString = '0'.obs;
  RxString textTotalDolaresString = '0'.obs;

  @override
  void onInit() async {
    UserStorageController userStorageController =
        Get.find<UserStorageController>();
    user = userStorageController.user!.value;
    super.onInit();
  }

  @override
  void onReady() async {
    // TODO: implement onReady
    await CustomDialogFetch(() async => await fetchEssencialsDatas());
    super.onReady();
  }

  Future<void> fetchEssencialsDatas() async {
    try {
      Future resListBrand = _essencialVehicleRepository
          .fetchVehicleInformation(<Brand>[], Rest.BRANDS, Brand.fromJson);

      Future resListModel = _essencialVehicleRepository
          .fetchVehicleInformation(<Model>[], Rest.MODELS, Model.fromJson);

      Future resListFuel = _essencialVehicleRepository
          .fetchVehicleInformation(<Fuel>[], Rest.FUELS, Fuel.fromJson);

      Future resListColor = _essencialVehicleRepository
          .fetchVehicleInformation(<Color>[], Rest.COLORS, Color.fromJson);

      Future resListMotor = _essencialVehicleRepository
          .fetchVehicleInformation(<Motor>[], Rest.MOTORS, Motor.fromJson);

      Future resListCambio = _essencialVehicleRepository
          .fetchVehicleInformation(<Gear>[], Rest.GEARS, Gear.fromJson);

      List responseList = await Future.wait<dynamic>([
        resListBrand,
        resListModel,
        resListFuel,
        resListColor,
        resListMotor,
        resListCambio
      ]);

      listBrand.value = responseList[0][0];
      listStringBrand.value = responseList[0][1];
      brandSelected.value = listBrand.first;

      listModel.value = responseList[1][0];
      listStringModel.value = responseList[1][1];

      listFuel.value = responseList[2][0];
      listStringFuel.value = responseList[2][1];

      listColor.value = responseList[3][0];
      listStringColor.value = responseList[3][1];

      listMotor.value = responseList[4][0];
      listStringMotor.value = responseList[4][1];

      listGear.value = responseList[5][0];
      listStringCambio.value = responseList[5][1];

      listModelAux.value = listModel
          .where((el) => el.idMarca == brandSelected.value.idMarca)
          .toList();
      if (listModelAux.isEmpty) {
        modelSelected.value = Model();
      } else {
        modelSelected.value = listModelAux.first;
      }
    } catch (e) {
      CustomSnackBarError(e.toString());
    }
  }

  void sumTotal(String? text) {
    sumTotalGuaranies();
    sumTotalDolares();
  }

  void sumTotalGuaranies() {
    double cuotaXcantidad = (RemoveMoneyFormat()
            .removeToDouble(textCuotaGuaranies.text) *
        int.parse(
            textCantidadCuotas.text.isEmpty ? '0' : textCantidadCuotas.text));

    double refuerzoXcantidad =
        (RemoveMoneyFormat().removeToDouble(textRefuezoGuaranies.text) *
            int.parse(textCantidadRefuerzos.text.isEmpty
                ? '0'
                : textCantidadRefuerzos.text));

    double refuerzoMasEntrada =
        RemoveMoneyFormat().removeToDouble(textEntradaGuaranies.text) +
            refuerzoXcantidad;
    textTotalGuaraniesString.value=(refuerzoMasEntrada + cuotaXcantidad).toString();
  }

  void sumTotalDolares() {
    double cuotaXcantidad = (RemoveMoneyFormat()
            .removeToDouble(textCuotaDolares.text) *
        int.parse(
            textCantidadCuotas.text.isEmpty ? '0' : textCantidadCuotas.text));

    double refuerzoXcantidad =
        (RemoveMoneyFormat().removeToDouble(textRefuezoDolares.text) *
            int.parse(textCantidadRefuerzos.text.isEmpty
                ? '0'
                : textCantidadRefuerzos.text));

    double refuerzoMasEntrada =
        RemoveMoneyFormat().removeToDouble(textEntradaDolares.text) +
            refuerzoXcantidad;
    textTotalDolaresString.value = (refuerzoMasEntrada + cuotaXcantidad).toString();
  }

  Future<void> registerVehicle() async {
    if (formKey.currentState == null) {
    } else if (formKey.currentState!.validate()) {
      isLoading.value = true;
      try {
        formKey.currentState!.save();
        createVehicle.value.idSucursal = user?.idSucursal;
        createVehicle.value.idEmpresa = user?.idEmpresa;

        createVehicle.value.chapa = createVehicle.value.chapa
            .toString()
            .replaceAll('-', '')
            .replaceAll(' ', '');

        createVehicle.value.costoGuaranies = RemoveMoneyFormat()
            .removeToString(createVehicle.value.costoGuaranies);
        createVehicle.value.costoDolares = RemoveMoneyFormat()
            .removeToString(createVehicle.value.costoDolares);
        createVehicle.value.contadoGuaranies = RemoveMoneyFormat()
            .removeToString(createVehicle.value.contadoGuaranies);
        createVehicle.value.contadoDolares = RemoveMoneyFormat()
            .removeToString(createVehicle.value.contadoDolares);

        if (createVehicle.value.chapa == '') {
          createVehicle.value.chapa = null;
        }
        if (createVehicle.value.chassis == '') {
          createVehicle.value.chassis = null;
        }
        if (double.parse(createVehicle.value.contadoDolares.toString()) ==
            0.0) {
          createVehicle.value.contadoDolares = null;
        }
        if (int.parse(createVehicle.value.contadoGuaranies) == 0) {
          createVehicle.value.contadoGuaranies = null;
        }
        if (double.parse(createVehicle.value.costoDolares) == 0.0) {
          createVehicle.value.costoDolares = null;
        }
        if (int.parse(createVehicle.value.costoGuaranies) == 0) {
          createVehicle.value.costoGuaranies = null;
        }
        createVehicle.value.cuotas = listCuota;
        var vehicleResponse = await _essencialVehicleRepository.createVehicle(createVehicle.toJson());

        formKey.currentState?.reset();
        formKeyDialog.currentState?.reset();
        isLoading.value = false;
      } catch (e) {
        CustomSnackBarError(e.toString());
        isLoading.value = false;
      }
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

      if (double.parse(cuota.value.entradaDolares) == 0.0) {
        cuota.value.entradaDolares = null;
      }
      if (double.parse(cuota.value.cuotaDolares) == 0.0) {
        cuota.value.cuotaDolares = null;
      }
      if (double.parse(cuota.value.refuerzoDolares) == 0.0) {
        cuota.value.refuerzoDolares = null;
      }
      if (int.parse(cuota.value.entradaGuaranies) == 0) {
        cuota.value.entradaGuaranies = null;
      }
      if (int.parse(cuota.value.cuotaGuaranies) == 0) {
        cuota.value.cuotaGuaranies = null;
      }
      if (int.parse(cuota.value.refuerzoGuaranies) == 0) {
        cuota.value.refuerzoGuaranies = null;
      }

      listCuota.add(cuota.value);
      Get.back();
    }
  }
}
