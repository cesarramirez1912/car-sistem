import 'package:get/get.dart';
import '../app/modules/vehicle_detail/vehicle_detail_controller.dart';

class VehicleDetailBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VehicleDetailController>(() => VehicleDetailController());
  }
}
