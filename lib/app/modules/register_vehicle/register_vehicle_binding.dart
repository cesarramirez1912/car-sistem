import 'package:get/get.dart';

import 'essencial_vehicle_controller.dart';

class RegisterVehicleBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<EssencialVehicleController>(EssencialVehicleController(), permanent: true);
  }
}
