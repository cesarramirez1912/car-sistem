import 'package:car_system/controllers/client_controller.dart';
import 'package:car_system/controllers/dash_controller.dart';
import 'package:car_system/controllers/deudor_controller.dart';
import 'package:car_system/controllers/list_vehicle_controller.dart';
import 'package:car_system/controllers/sells_from_collaborator_controller.dart';
import 'package:get/get.dart';

class DashBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashController>(() => DashController());
    Get.lazyPut<DeudorController>(() => DeudorController());
    Get.lazyPut<ListVehicleController>(() => ListVehicleController());
    Get.lazyPut<ClientController>(() => ClientController());
    Get.lazyPut<SellsFromCollaboratorController>(() => SellsFromCollaboratorController());
  }
}
