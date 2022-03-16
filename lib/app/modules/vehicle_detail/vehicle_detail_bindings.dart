import 'package:car_system/app/modules/vehicle_detail/vehicle_detail_controller.dart';
import 'package:get/get.dart';


class VehicleDetailBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VehicleDetailController>(() => VehicleDetailController());
  }
}
