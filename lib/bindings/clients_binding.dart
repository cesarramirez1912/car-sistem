import 'package:get/get.dart';

import '../app/modules/client/client_controller.dart';

class ClientBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ClientController>(() => ClientController(), fenix: true);
  }
}
