import 'package:car_system/app/modules/dates_venc_cuotes/detail_dates_cuotes_refuerzo_controller.dart';
import 'package:get/get.dart';

class DetailDatesCuotesRefuerzosBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailDatesCuotesRefuerzosController>(() => DetailDatesCuotesRefuerzosController());
  }
}
