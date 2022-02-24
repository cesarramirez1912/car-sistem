import 'package:car_system/controllers/client_controller.dart';
import 'package:get/get.dart';

class ClientBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ClientController>(() => ClientController(), fenix: true);
  }
}
