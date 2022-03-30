import 'package:get/get.dart';

import 'dates_venc_controller.dart';

class DatesVencBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DatesVencController>(() => DatesVencController());
  }
}
