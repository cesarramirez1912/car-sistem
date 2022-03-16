import 'package:car_system/app/modules/list_vehicles/list_vehicle_controller.dart';
import 'package:get/get.dart';
import '../client/client_controller.dart';

class ListVehicleBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ListVehicleController>(() => ListVehicleController());
    Get.lazyPut<ClientController>(() => ClientController(), fenix: true);
  }
}
