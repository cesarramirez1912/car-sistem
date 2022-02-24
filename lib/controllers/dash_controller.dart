import 'dart:async';
import 'package:car_system/colors.dart';
import 'package:car_system/controllers/client_controller.dart';
import 'package:car_system/controllers/list_vehicle_controller.dart';
import 'package:car_system/controllers/sells_from_collaborator_controller.dart';
import 'package:car_system/controllers/user_storage_controller.dart';
import 'package:car_system/models/register_client_model.dart';
import 'package:car_system/repositories/dash_repository.dart';
import 'package:car_system/repositories/register_client_repository.dart';
import 'package:car_system/widgets/snack_bars/snack_bar_error.dart';
import 'package:car_system/widgets/snack_bars/snack_bar_success.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:get/get.dart';

import '../views/dash/chart_bar_secondary_view.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class DashController extends GetxController {
  DashRepository dashRepository = DashRepository();
  UserStorageController userStorageController = Get.find();
  ClientController clientController = Get.find();
  ListVehicleController listVehicleController = Get.find();
  SellsFromCollaboratorController sellsFromCollaboratorController = Get.find();
  Rx<Total> totalMes = Total().obs;
  Rx<Count> totalVendidoMes = Count().obs;
  Rx<CountTotalCuotaPago>? totalCuotaPago = CountTotalCuotaPago().obs;
  RxList<CountTotalCuotaPago> listTotalPagoMes = <CountTotalCuotaPago>[].obs;
  var monthInt = DateTime.now().month;
  var year = DateTime.now().year;

  RxBool isLoading = false.obs;

  @override
  void onInit() async {
    isLoading.value = true;
    await requestTotalMes();
    isLoading.value = false;
    super.onInit();
  }

  Future<void> requestTotalMes() async {
    try {
      Future _totalMes = dashRepository.requestCobrosMes(
          userStorageController.user?.value.idEmpresa, monthInt, year);
      Future _countMes = dashRepository.requestCount(
          userStorageController.user?.value.idEmpresa, monthInt, year);
      Future _countCuotesPagos = dashRepository.requestCountCuotesPagos(
          userStorageController.user?.value.idEmpresa, null, year);
      var responses =
          await Future.wait([_totalMes, _countMes, _countCuotesPagos]);
      totalMes.value = Total();
      totalVendidoMes.value = Count();
      totalMes.value = responses[0][0];
      totalVendidoMes.value = responses[1][0];
      List<CountTotalCuotaPago> _list = responses[2];
      listTotalPagoMes.value = _list;
      totalCuotaPago?.value =
          _list.firstWhereOrNull((element) => element.mes == monthInt) ??
              CountTotalCuotaPago();
    } catch (e) {
      print(e);
    }
  }

  List<charts.Series<OrdinalSales, String>> createBars() {
    if (listTotalPagoMes.isNotEmpty) {
      final desktopSalesData = listTotalPagoMes
          .map((element) =>
              OrdinalSales(element.mes.toString(), element.totalCuotas ?? 0))
          .toList();

      final tabletSalesData = listTotalPagoMes
          .map((element) =>
              OrdinalSales(element.mes.toString(), element.totalPagado ?? 0))
          .toList();

      return [
        charts.Series<OrdinalSales, String>(
          id: 'Desktop',
          colorFn: (_, __) =>
              charts.ColorUtil.fromDartColor(ColorPalette.GRAY_LIGTH300),
          domainFn: (OrdinalSales sales, _) => sales.year,
          measureFn: (OrdinalSales sales, _) => sales.sales,
          data: desktopSalesData,
        ),
        charts.Series<OrdinalSales, String>(
          id: 'Tablet',
          colorFn: (_, __) =>
              charts.ColorUtil.fromDartColor(ColorPalette.GREEN),
          domainFn: (OrdinalSales sales, _) => sales.year,
          measureFn: (OrdinalSales sales, _) => sales.sales,
          data: tabletSalesData,
        ),
      ];
    } else {
      return [];
    }
  }
}

class OrdinalSales {
  final String year;
  final int sales;

  OrdinalSales(this.year, this.sales);
}
