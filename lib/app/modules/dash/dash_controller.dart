import 'package:car_system/app/modules/list_vehicles/list_vehicle_controller.dart';
import 'package:car_system/app/modules/sells/sells_from_collaborator_controller.dart';
import 'package:get/get.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import '../../../controllers/user_storage_controller.dart';
import '../../core/theme/colors.dart';
import '../../data/providers/remote/dash_api.dart';
import '../../data/repositories/remote/dash_repository.dart';
import '../client/client_controller.dart';


class DashController extends GetxController {
  final DashRepository _dashRepository = Get.find();
  UserStorageController userStorageController = Get.find();
  ClientController clientController = Get.find();
  ListVehicleController listVehicleController = Get.find();
  SellsFromCollaboratorController sellsFromCollaboratorController = Get.find();
  Rx<Total> totalMes = Total().obs;
  Rx<TotalVenta> totalVentaMes = TotalVenta().obs;
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
      Future _totalMes = _dashRepository.requestCobrosMes(
          userStorageController.user?.value.idEmpresa, monthInt, year);
      Future _totalNegociosMes = _dashRepository.requestTotalVentasMes(
          userStorageController.user?.value.idEmpresa, monthInt, year);
      Future _countMes = _dashRepository.requestCount(
          userStorageController.user?.value.idEmpresa, monthInt, year);
      Future _countCuotesPagos = _dashRepository.requestCountCuotesPagos(
          userStorageController.user?.value.idEmpresa, null, year);
      var responses = await Future.wait(
          [_totalMes, _countMes, _countCuotesPagos, _totalNegociosMes]);
      totalMes.value = Total();
      totalVendidoMes.value = Count();
      totalMes.value = responses[0][0];
      totalVendidoMes.value = responses[1][0];
      List<CountTotalCuotaPago> _list = responses[2];
      listTotalPagoMes.value = _list;
      totalCuotaPago?.value =
          _list.firstWhereOrNull((element) => element.mes == monthInt) ??
              CountTotalCuotaPago();
      totalVentaMes.value = responses[3][0];
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
