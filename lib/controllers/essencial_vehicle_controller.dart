import 'dart:async';

import 'package:car_system/controllers/user_controller.dart';
import 'package:car_system/models/essencial_vehicle_models/brand.dart';
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

  RegisterClient? registerClientModel = RegisterClient();

  RxList<Brand> listBrand = <Brand>[].obs;

  TextEditingController typeAheadController = new TextEditingController();
  TextEditingController textController = new TextEditingController();

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
    for (var br in listBrand) {
      print(br.toJson());
    }
  }

  void registerVehicle() async {
    if (formKey.currentState == null) {
      print("_formKey.currentState is null!");
    } else if (formKey.currentState!.validate()) {
      isLoading.value = true;
      try {
        formKey.currentState!.save();
        registerClientModel?.idSucursal = user?.idSucursal;
        registerClientModel?.idEmpresa = user?.idEmpresa;
        // var clientId = await registerClientRepository
        //     ?.createClient(registerClientModel!.toJson());
        //  print(clientId);
        CustomSnackBarSuccess(
            'CLIENTE ${registerClientModel?.cliente} REGISTRADO CON EXITO!');
        formKey.currentState!.reset();
        isLoading.value = false;
      } catch (e) {
        CustomSnackBarError(e.toString());
        isLoading.value = false;
      }
    }
  }
}
