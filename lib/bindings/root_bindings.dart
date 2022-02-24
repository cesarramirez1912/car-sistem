import 'package:car_system/controllers/client_controller.dart';
import 'package:car_system/controllers/essencial_vehicle_controller.dart';
import 'package:car_system/controllers/list_vehicle_controller.dart';
import 'package:car_system/controllers/sells_from_collaborator_controller.dart';
import 'package:car_system/controllers/vehicle_detail_controller.dart';
import 'package:get/get.dart';

class RootBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ClientController>(() => ClientController(),fenix: true);
    Get.lazyPut<ListVehicleController>(() => ListVehicleController());
    Get.lazyPut<VehicleDetailController>(() => VehicleDetailController());
    Get.lazyPut<EssencialVehicleController>(() => EssencialVehicleController(), fenix: true);
    Get.lazyPut<SellsFromCollaboratorController>(() => SellsFromCollaboratorController(),fenix: true);
  }
}
