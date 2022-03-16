import 'package:car_system/app/modules/splash/splash_controller.dart';
import 'package:get/instance_manager.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => SplashController());
  }
}
