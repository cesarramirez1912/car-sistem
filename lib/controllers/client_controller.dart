import 'dart:async';
import 'package:car_system/controllers/user_storage_controller.dart';
import 'package:car_system/models/register_client_model.dart';
import 'package:car_system/models/user_model.dart';
import 'package:car_system/repositories/register_client_repository.dart';
import 'package:car_system/widgets/snack_bars/snack_bar_error.dart';
import 'package:car_system/widgets/snack_bars/snack_bar_success.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:get/get.dart';

class ClientController extends GetxController {
  Rx<User>? user = User().obs;
  final formKey = GlobalKey<FormState>();
  Rx<bool> isLoading = false.obs;
  ClientRepository? clientRepository;

  ClientModel? clientModel = ClientModel();

  RxList<String> listClientsString = <String>[].obs;
  RxList<ClientModel> listClients = <ClientModel>[].obs;
  RxList<ClientModel> listClientsAux = <ClientModel>[].obs;

  MaskedTextController textCiController =
      MaskedTextController(text: '', mask: '0.000.000-00');

  MaskedTextController textPhoneController =
      MaskedTextController(text: '', mask: '(0000)000-000');

  @override
  void onInit() async {
    UserStorageController userStorageController =
        Get.find<UserStorageController>();
    clientRepository = ClientRepository();
    user?.value = await userStorageController.restoreModel();
    await requestClients();
    super.onInit();
  }

  Future<void> requestClients() async {
    try {
      List<ClientModel> listClientsRequest =
          await clientRepository?.requestClients(user?.value.idEmpresa);
      listClientsString.clear();
      for (var client in listClientsRequest) {
        if (client.cliente != null) {
          listClientsString.add(client.cliente ?? '');
        }
      }
      listClients.clear();
      listClientsAux.clear();
      listClientsAux.addAll(listClientsRequest);
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
        clientModel?.idSucursal = user?.value.idSucursal;
        clientModel?.idEmpresa = user?.value.idEmpresa;
        clientModel?.celular = clientModel?.celular
            ?.replaceAll('(', '')
            .replaceAll(')', '')
            .replaceAll('-', '');
        clientModel?.ci =
            clientModel?.ci?.replaceAll('.', '').replaceAll('-', '');
        var clientId =
            await clientRepository?.createClient(clientModel!.toJson());
        await requestClients();
        textCiController = MaskedTextController(text: '', mask: '0.000.000-00');
        textPhoneController =
            MaskedTextController(text: '', mask: '(0000)000-000');

        Get.back(result: clientId);
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
