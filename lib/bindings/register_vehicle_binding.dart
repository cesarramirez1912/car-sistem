import 'package:car_system/controllers/essencial_vehicle_controller.dart';
import 'package:get/get.dart';

class RegisterVehicleBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<EssencialVehicleController>(EssencialVehicleController(), permanent: true);
  }
}
