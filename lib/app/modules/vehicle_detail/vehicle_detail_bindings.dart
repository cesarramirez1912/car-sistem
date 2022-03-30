import 'package:car_system/app/modules/dates_venc/dates_venc_controller.dart';
import 'package:car_system/app/modules/vehicle_detail/vehicle_detail_controller.dart';
import 'package:get/get.dart';


class VehicleDetailBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VehicleDetailController>(() => VehicleDetailController());
    Get.lazyPut<DatesVencController>(() => DatesVencController());
  }
}
