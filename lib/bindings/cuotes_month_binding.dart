import 'package:car_system/controllers/cuotes_month/cuotes_month_controller.dart';
import 'package:get/get.dart';

class CuotesMonthBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CuotesMonthController>(() => CuotesMonthController());
  }
}
