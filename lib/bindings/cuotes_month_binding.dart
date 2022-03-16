import 'package:get/get.dart';

import '../app/modules/cuote_month/cuotes_month_controller.dart';

class CuotesMonthBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CuotesMonthController>(() => CuotesMonthController());
  }
}
