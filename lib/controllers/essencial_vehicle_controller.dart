import 'dart:async';

import 'package:car_system/common/remove_money_format.dart';
import 'package:car_system/controllers/user_storage_controller.dart';
import 'package:car_system/models/create_vehicle.dart';
import 'package:car_system/models/cuotes.dart';
import 'package:car_system/models/essencial_vehicle_models/brand.dart';
import 'package:car_system/models/essencial_vehicle_models/color.dart';
import 'package:car_system/models/essencial_vehicle_models/fuel.dart';
import 'package:car_system/models/essencial_vehicle_models/gear.dart';
import 'package:car_system/models/essencial_vehicle_models/model.dart';
import 'package:car_system/models/essencial_vehicle_models/motor.dart';
import 'package:car_system/models/user_model.dart';
import 'package:car_system/repositories/essencial_vehicle_repository.dart';
import 'package:car_system/rest.dart';
import 'package:car_system/widgets/snack_bars/snack_bar_error.dart';
import 'package:car_system/widgets/snack_bars/snack_bar_success.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:get/get.dart';

class EssencialVehicleController extends GetxController {
  User? user = User();
  final formKey = GlobalKey<FormState>();
  final formKeyDialog = GlobalKey<FormState>();
  Rx<bool> isLoading = false.obs;
  EssencialVehicleRepository? essencialVehicleRepository;

  Rx<CreateVehicle> createVehicle = CreateVehicle().obs;
  RxList<Cuota> listCuota = <Cuota>[].obs;
  Rx<Cuota> cuota = Cuota().obs;

  FocusNode myFocusNode = FocusNode();
  FocusNode myFocusNode2 = FocusNode();

  RxList<String> listStringBrand = <String>[].obs;
  RxList<String> listStringModel = <String>[].obs;
  RxList<String> listStringFuel = <String>[].obs;
  RxList<String> listStringColor = <String>[].obs;
  RxList<String> listStringMotor = <String>[].obs;
  RxList<String> listStringCambio = <String>[].obs;

  RxList<Brand> listBrand = <Brand>[].obs;
  RxList<Model> listModel = <Model>[].obs;
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

  @override
  void onInit() async {
    UserStorageController userStorageController =
        Get.find<UserStorageController>();
    essencialVehicleRepository = EssencialVehicleRepository();
    user = userStorageController.user!.value;
    await fetchEssencialsDatas();
    super.onInit();
  }

  Future<void> fetchEssencialsDatas() async {
    try {
      List resListBrand = await essencialVehicleRepository
          ?.fetchVehicleInformation(listBrand, Rest.BRANDS, Brand.fromJson);
      listBrand.value = resListBrand[0];
      listStringBrand.value = resListBrand[1];
      List resListModel = await essencialVehicleRepository
          ?.fetchVehicleInformation(listModel, Rest.MODELS, Model.fromJson);
      listModel.value = resListModel[0];
      listStringModel.value = resListModel[1];
      List resListFuel = await essencialVehicleRepository
          ?.fetchVehicleInformation(listFuel, Rest.FUELS, Fuel.fromJson);
      listFuel.value = resListFuel[0];
      listStringFuel.value = resListFuel[1];
      List resListColor = await essencialVehicleRepository
          ?.fetchVehicleInformation(listColor, Rest.COLORS, Color.fromJson);
      listColor.value = resListColor[0];
      listStringColor.value = resListColor[1];
      List resListMotor = await essencialVehicleRepository
          ?.fetchVehicleInformation(listMotor, Rest.MOTORS, Motor.fromJson);
      listMotor.value = resListMotor[0];
      listStringMotor.value = resListMotor[1];
      List resListCambio = await essencialVehicleRepository
          ?.fetchVehicleInformation(listGear, Rest.GEARS, Gear.fromJson);
      listGear.value = resListCambio[0];
      listStringCambio.value = resListCambio[1];
    } catch (e) {
      CustomSnackBarError(e.toString());
    }
  }

  Future<void> registerVehicle() async {
    if (formKey.currentState == null) {
      print("_formKey.currentState is null!");
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

        createVehicle.value.costoGuaranies =
            RemoveMoneyFormat().format(createVehicle.value.costoGuaranies);
        createVehicle.value.costoDolares =
            RemoveMoneyFormat().format(createVehicle.value.costoDolares);
        createVehicle.value.contadoGuaranies =
            RemoveMoneyFormat().format(createVehicle.value.contadoGuaranies);
        createVehicle.value.contadoDolares =
            RemoveMoneyFormat().format(createVehicle.value.contadoDolares);

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

        var vehicleResponse = await essencialVehicleRepository
            ?.createVehicle(createVehicle.toJson());
        Get.back();
        CustomSnackBarSuccess(
            ' ${createVehicle.value.modelo} REGISTRADO CON EXITO!');
        formKey.currentState?.reset();
        formKeyDialog.currentState?.reset();
        isLoading.value = false;
      } catch (e) {
        print(e);
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
          RemoveMoneyFormat().format(cuota.value.entradaGuaranies);
      cuota.value.cuotaGuaranies =
          RemoveMoneyFormat().format(cuota.value.cuotaGuaranies);
      cuota.value.refuerzoGuaranies =
          RemoveMoneyFormat().format(cuota.value.refuerzoGuaranies);
      cuota.value.entradaDolares =
          RemoveMoneyFormat().format(cuota.value.entradaDolares);
      cuota.value.cuotaDolares =
          RemoveMoneyFormat().format(cuota.value.cuotaDolares);
      cuota.value.refuerzoDolares =
          RemoveMoneyFormat().format(cuota.value.refuerzoDolares);

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
