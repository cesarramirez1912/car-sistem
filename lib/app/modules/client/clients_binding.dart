import 'package:get/get.dart';

import 'client_controller.dart';

class ClientBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ClientController>(() => ClientController(), fenix: true);
  }
}
