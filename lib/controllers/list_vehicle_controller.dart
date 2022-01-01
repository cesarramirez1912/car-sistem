import 'dart:math';

import 'package:car_system/controllers/login_controller.dart';
import 'package:car_system/controllers/user_controller.dart';
import 'package:car_system/models/user_model.dart';
import 'package:car_system/models/vehicle.dart';
import 'package:car_system/repositories/home_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ListVehicleController extends GetxController {
  UserController userController = Get.put(UserController());
  LoginController loginController = LoginController();
  HomeRepository _homeRepository = HomeRepository();
  RxList<Vehicle> vehiclesComplete = <Vehicle>[].obs;
  RxList<Vehicle> vehicles = <Vehicle>[].obs;
  RxList<Vehicle> vehiclesAux = <Vehicle>[].obs;
  User? user = User();

  TextEditingController searchTextController = TextEditingController(text: '');

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
      if (res.isNotEmpty) {
        resFil.add(res.first);
        for (var i in res) {
          var find = resFil.where(
              (element) => element.idVehiculoSucursal == i.idVehiculoSucursal);
          if (find.isEmpty) {
            resFil.add(i);
          }
        }
      }
      vehicles.value = resFil;
      vehiclesAux.value = resFil;
    } catch (e) {
      print("error");
      print(e);
    }
  }

  List<Vehicle> getVehiclesFromId(String id) {
    return vehiclesComplete
        .where((element) => element.idVehiculoSucursal.toString() == id)
        .toList();
  }

  void searchText(String text) {
    if (text.isEmpty) {
      vehicles.value = vehiclesAux;
    } else {
      List<Vehicle> _list = vehiclesAux
          .where((element) =>
              element.marca.contains(text.toUpperCase()) ||
              element.modelo.contains(text.toUpperCase()))
          .toList();
      vehicles.value = _list;
    }
  }
}
