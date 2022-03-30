import 'package:car_system/app/modules/dates_venc/dates_venc_controller.dart';
import 'package:get/get.dart';
import 'new_dates_controller.dart';

class NewDatesBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NewDatesController>(() => NewDatesController());
    Get.lazyPut<DatesVencController>(() => DatesVencController());
  }
}
