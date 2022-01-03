import 'dart:async';

import 'package:car_system/controllers/user_controller.dart';
import 'package:car_system/models/create_vehicle.dart';
import 'package:car_system/models/essencial_vehicle_models/brand.dart';
import 'package:car_system/models/essencial_vehicle_models/color.dart';
import 'package:car_system/models/essencial_vehicle_models/fuel.dart';
import 'package:car_system/models/essencial_vehicle_models/model.dart';
import 'package:car_system/models/essencial_vehicle_models/motor.dart';
import 'package:car_system/models/register_client_model.dart';
import 'package:car_system/models/user_model.dart';
import 'package:car_system/repositories/essencial_vehicle_repository.dart';
import 'package:car_system/repositories/register_client_repository.dart';
import 'package:car_system/rest.dart';
import 'package:car_system/widgets/snack_bars/snack_bar_error.dart';
import 'package:car_system/widgets/snack_bars/snack_bar_success.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EssencialVehicleController extends GetxController {
  User? user = User();
  UserController userController = UserController();
  final formKey = GlobalKey<FormState>();
  Rx<bool> isLoading = false.obs;
  EssencialVehicleRepository? essencialVehicleRepository;

  Rx<CreateVehicle> createVehicle = CreateVehicle().obs;

  FocusNode myFocusNode = FocusNode();
  FocusNode myFocusNode2 = FocusNode();

  RxList<Brand> listBrand = <Brand>[].obs;
  RxList<Model> listModel = <Model>[].obs;
  RxList<Fuel> listFuel = <Fuel>[].obs;
  RxList<Color> listColor = <Color>[].obs;
  RxList<Motor> listMotor = <Motor>[].obs;

  TextEditingController textBrandController = TextEditingController();
  TextEditingController textModelController = TextEditingController();
  TextEditingController textFuelController = TextEditingController();
  TextEditingController textColorController = TextEditingController();
  TextEditingController textMotorController = TextEditingController();

  @override
  void onInit() async {
    userController = Get.find<UserController>();
    essencialVehicleRepository = EssencialVehicleRepository();
    user = userController.user;
    await fetchEssencialsDatas();
    super.onInit();
  }

  Future<void> fetchEssencialsDatas() async {
    listBrand = await essencialVehicleRepository?.fetchVehicleInformation(
        listBrand, Rest.BRANDS, Brand.fromJson);
    listModel = await essencialVehicleRepository?.fetchVehicleInformation(
        listModel, Rest.MODELS, Model.fromJson);
    listFuel = await essencialVehicleRepository?.fetchVehicleInformation(
        listFuel, Rest.FUELS, Fuel.fromJson);
    listColor = await essencialVehicleRepository?.fetchVehicleInformation(
        listColor, Rest.COLORS, Color.fromJson);
    listMotor = await essencialVehicleRepository?.fetchVehicleInformation(
        listMotor, Rest.MOTORS, Motor.fromJson);
  }

  void registerVehicle() async {
    if (formKey.currentState == null) {
      print("_formKey.currentState is null!");
    } else if (formKey.currentState!.validate()) {
      isLoading.value = true;
      try {
        formKey.currentState!.save();
        print('entro ca');
        createVehicle.value.idSucursal = user?.idSucursal;
        createVehicle.value.idEmpresa = user?.idEmpresa;
        print(createVehicle.toJson());
        // var clientId = await registerClientRepository
        //     ?.createClient(registerClientModel!.toJson());
        //  print(clientId);
        // CustomSnackBarSuccess(
        //     'CLIENTE ${registerClientModel?.cliente} REGISTRADO CON EXITO!');
        formKey.currentState!.reset();
        isLoading.value = false;
      } catch (e) {
        CustomSnackBarError(e.toString());
        isLoading.value = false;
      }
    }
  }
}
