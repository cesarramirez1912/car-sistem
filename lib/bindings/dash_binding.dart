import 'package:car_system/controllers/deudor/deudor_controller.dart';
import 'package:car_system/controllers/list_vehicle_controller.dart';
import 'package:car_system/controllers/sells_from_collaborator_controller.dart';
import 'package:get/get.dart';

import '../app/modules/client/client_controller.dart';
import '../app/modules/cuote_month/cuotes_month_controller.dart';

class DashBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DeudorController>(() => DeudorController());
    Get.lazyPut<CuotesMonthController>(() => CuotesMonthController());
    Get.lazyPut<ListVehicleController>(() => ListVehicleController());
    Get.lazyPut<ClientController>(() => ClientController());
    Get.lazyPut<SellsFromCollaboratorController>(() => SellsFromCollaboratorController());
  }
}
