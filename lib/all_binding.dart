
import 'package:car_system/controllers/list_vehicle_controller.dart';
import 'package:car_system/controllers/login_controller.dart';
import 'package:car_system/controllers/vehicle_detail_controller.dart';
import 'package:get/get.dart';

import 'controllers/client_controller.dart';

class AllBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController());
    Get.lazyPut<ClientController>(() => ClientController());
    Get.lazyPut<ListVehicleController>(() => ListVehicleController());
    Get.lazyPut<VehicleDetailController>(() => VehicleDetailController());
  }
}