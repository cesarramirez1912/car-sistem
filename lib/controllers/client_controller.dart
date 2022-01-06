import 'dart:async';

import 'package:car_system/controllers/user_controller.dart';
import 'package:car_system/models/register_client_model.dart';
import 'package:car_system/models/user_model.dart';
import 'package:car_system/repositories/register_client_repository.dart';
import 'package:car_system/widgets/snack_bars/snack_bar_error.dart';
import 'package:car_system/widgets/snack_bars/snack_bar_success.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:get/get.dart';

class ClientController extends GetxController {
  User? user = User();
  UserController userController = UserController();
  final formKey = GlobalKey<FormState>();
  Rx<bool> isLoading = false.obs;
  RegisterClientRepository? registerClientRepository;

  RegisterClient? registerClientModel = RegisterClient();

  MaskedTextController textCiController =  MaskedTextController(text: '', mask: '0.000.000-00');
  MaskedTextController textPhoneController =  MaskedTextController(text: '', mask: '(0000)000-000');

  @override
  void onInit() {
    userController = Get.find<UserController>();
    registerClientRepository = RegisterClientRepository();
    user = userController.user;
    super.onInit();
  }

  void registerClient() async {
    if (formKey.currentState == null) {
      print("_formKey.currentState is null!");
    } else if (formKey.currentState!.validate()) {
      isLoading.value = true;
      try {
        formKey.currentState!.save();
        registerClientModel?.idSucursal = user?.idSucursal;
        registerClientModel?.idEmpresa = user?.idEmpresa;
        registerClientModel?.celular = registerClientModel?.celular?.replaceAll('(','').replaceAll(')', '').replaceAll('-', '');
        registerClientModel?.ci = registerClientModel?.ci?.replaceAll('.','').replaceAll('-', '');
        var clientId = await registerClientRepository
            ?.createClient(registerClientModel!.toJson());
        print(clientId);
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
