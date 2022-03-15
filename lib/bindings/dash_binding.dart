import 'package:car_system/controllers/client_controller.dart';
import 'package:car_system/controllers/cuotes_month/cuotes_month_controller.dart';
import 'package:car_system/controllers/dash_controller.dart';
import 'package:car_system/controllers/deudor/deudor_controller.dart';
import 'package:car_system/controllers/list_vehicle_controller.dart';
import 'package:car_system/controllers/sells_from_collaborator_controller.dart';
import 'package:get/get.dart';

class DashBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashController>(() => DashController());
    Get.lazyPut<DeudorController>(() => DeudorController());
    Get.lazyPut<CuotesMonthController>(() => CuotesMonthController());
    Get.lazyPut<ListVehicleController>(() => ListVehicleController());
    Get.lazyPut<ClientController>(() => ClientController());
    Get.lazyPut<SellsFromCollaboratorController>(() => SellsFromCollaboratorController());
  }
}
