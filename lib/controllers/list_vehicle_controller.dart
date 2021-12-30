import 'dart:math';

import 'package:car_system/controllers/login_controller.dart';
import 'package:car_system/models/user_model.dart';
import 'package:car_system/models/vehicle.dart';
import 'package:car_system/repositories/home_repository.dart';
import 'package:get/get.dart';

class ListVehicleController extends GetxController {
  LoginController loginController = LoginController();
  HomeRepository _homeRepository = HomeRepository();
  RxList vehiclesComplete = [].obs;
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
      vehiclesComplete.value = res;
      List<Vehicle> resFil = [];
      if(res.isNotEmpty){
        resFil.add(res.first);
        print(resFil.first.toJson());
        for(var i in res){
          var find = resFil.where((element) => element.idVehiculoSucursal==i.idVehiculoSucursal);
          if(find.isEmpty){
           resFil.add(i);
          }
        }
      }
      vehicles.value = resFil;
    } catch (e) {
      print("error");
      print(e);
    }
  }
}
