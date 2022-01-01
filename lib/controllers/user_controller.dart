import 'package:car_system/controllers/login_controller.dart';
import 'package:car_system/models/user_model.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  User? user = User();
  LoginController loginController = LoginController();

  @override
  void onInit() {
    loginController = Get.find<LoginController>();
    user = loginController.user?.value;
    print(user?.toJson());
    super.onInit();
  }



}
