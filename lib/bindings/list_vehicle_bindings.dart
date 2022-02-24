import 'package:car_system/controllers/client_controller.dart';
import 'package:car_system/controllers/list_vehicle_controller.dart';
import 'package:get/get.dart';

class ListVehicleBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ListVehicleController>(() => ListVehicleController());
    Get.lazyPut<ClientController>(() => ClientController(), fenix: true);
  }
}
