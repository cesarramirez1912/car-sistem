import 'package:car_system/controllers/login_controller.dart';
import 'package:get/get.dart';

class ClientController extends GetxController {
  var count = 1.obs;
  var count2 = 0.obs;
  LoginController loginController = LoginController();

  @override
  void onInit() {
    loginController = Get.find<LoginController>();
    count2 = loginController.count;
    super.onInit();
  }

  void increment() {
    count++;
  }
}