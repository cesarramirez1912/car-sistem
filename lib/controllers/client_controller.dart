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
  ClientRepository? clientRepository;

  ClientModel? clientModel = ClientModel();

  RxList<String> listClientsString = <String>[].obs;
  RxList<ClientModel> listClients = <ClientModel>[].obs;

  MaskedTextController textCiController =
      MaskedTextController(text: '', mask: '0.000.000-00');
  MaskedTextController textPhoneController =
      MaskedTextController(text: '', mask: '(0000)000-000');

  @override
  void onInit() async {
    userController = Get.find<UserController>();
    clientRepository = ClientRepository();
    user = userController.user;
    await requestClients();
    super.onInit();
  }

  Future<void> requestClients() async {
    try {
      List<ClientModel> listClientsRequest =
          await clientRepository?.requestClients(user!.idEmpresa);
      listClientsString.clear();
      for (var client in listClientsRequest) {
        if (client.cliente != null) {
          listClientsString.add(client.cliente ?? '');
        }
      }
      listClients.clear();
      listClients.addAll(listClientsRequest);
    } catch (e) {
      print(e);
    }
  }

  void registerClient() async {
    if (formKey.currentState == null) {
    } else if (formKey.currentState!.validate()) {
      isLoading.value = true;
      try {
        formKey.currentState!.save();
        clientModel?.idSucursal = user?.idSucursal;
        clientModel?.idEmpresa = user?.idEmpresa;
        clientModel?.celular = clientModel?.celular
            ?.replaceAll('(', '')
            .replaceAll(')', '')
            .replaceAll('-', '');
        clientModel?.ci =
            clientModel?.ci?.replaceAll('.', '').replaceAll('-', '');
        var clientId =
            await clientRepository?.createClient(clientModel!.toJson());
        await requestClients();
        CustomSnackBarSuccess(
            'CLIENTE ${clientModel?.cliente} REGISTRADO CON EXITO!');
        formKey.currentState!.reset();
        isLoading.value = false;
      } catch (e) {
        CustomSnackBarError(e.toString());
        isLoading.value = false;
      }
    }
  }
}
