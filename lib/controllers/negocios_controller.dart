import 'dart:async';
import 'package:car_system/controllers/user_storage_controller.dart';
import 'package:car_system/models/sale_collaborator_model.dart';
import 'package:car_system/repositories/dash_repository.dart';
import 'package:car_system/widgets/snack_bars/snack_bar_error.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NegociosController extends GetxController {
  UserStorageController userController = Get.find();
  DashRepository dashRepository = DashRepository();
  RxBool isLoading = true.obs;
  RxList<SaleCollaboratorModel> listSales = <SaleCollaboratorModel>[].obs;
  Rx<SaleCollaboratorModel> saleSelected = SaleCollaboratorModel().obs;

  Rx<DateTime> firstDateCuoteSelected = DateTime.utc(
          DateTime.now().year, DateTime.now().month, DateTime.now().day)
      .obs;

  @override
  void onInit() async {
    await requestNegocios();
    isLoading.value = false;
    super.onInit();
  }

  Future<void> requestNegocios() async {
    try {
      listSales.value = await dashRepository.requestNegocios(userController.user?.value.idEmpresa,
          firstDateCuoteSelected.value.month, firstDateCuoteSelected.value.year);
    } catch (e) {
      CustomSnackBarError(e.toString());
    }
  }

  void setSaleSelected(SaleCollaboratorModel sale) {
    saleSelected.value = sale;
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
}
