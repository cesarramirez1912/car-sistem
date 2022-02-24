import 'package:car_system/controllers/vehicle_detail_controller.dart';
import 'package:get/get.dart';

class VehicleDetailBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VehicleDetailController>(() => VehicleDetailController());
  }
}
