import 'package:car_system/app/core/utils/date_format.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/models/sale_collaborator_model.dart';
import '../../data/repositories/remote/sells_repository.dart';

class SaleDetailController extends GetxController {
  final SellsRepository _sellsRepository = Get.find();
  Rx<SaleCollaboratorModel> saleCollaborator = SaleCollaboratorModel().obs;

  Rx<DateTime> dateFromSell = DateTime.utc(
          DateTime.now().year, DateTime.now().month, DateTime.now().day)
      .obs;

  @override
  void onInit() async {
    Map<dynamic, dynamic> map = Get.parameters;
    saleCollaborator.value = SaleCollaboratorModel.fromMapStringString(map);
    dateFromSell.value = DateFormatBr()
        .formatLocalFromString(saleCollaborator.value.fechaVenta!);
    super.onInit();
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

  Future<void> putDate() async {
    try {
      int response = await _sellsRepository.updateDateSale(
          saleCollaborator.value.idVenta!, dateFromSell.value);
    } catch (e) {
      if(e is DioError){
        print(e.response?.data);
      }
    }
  }
}
