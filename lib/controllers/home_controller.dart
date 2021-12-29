import 'dart:math';

import 'package:car_system/controllers/login_controller.dart';
import 'package:car_system/models/user_model.dart';
import 'package:car_system/models/vehicle.dart';
import 'package:car_system/repositories/home_repository.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  LoginController loginController = LoginController();
  HomeRepository _homeRepository = HomeRepository();
  RxList vehicles = [].obs;
  User? user = User();

  @override
  void onInit() async {
    loginController = Get.find<LoginController>();
    _homeRepository = HomeRepository();
    user = loginController.user?.value;
    await fetchVehicles();
    super.onInit();
  }

  Future<void> fetchVehicles() async {
    try {
      List<Vehicle> res =
          await _homeRepository.fetchVehicles(user?.idSucursal ?? 0);
      vehicles.value = res;
    } catch (e) {
      print("error");
      print(e);
    }
  }
}
