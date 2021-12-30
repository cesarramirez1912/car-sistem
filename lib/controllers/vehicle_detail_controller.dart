import 'dart:math';

import 'package:car_system/controllers/list_vehicle_controller.dart';
import 'package:car_system/controllers/login_controller.dart';
import 'package:car_system/models/user_model.dart';
import 'package:car_system/models/vehicle.dart';
import 'package:car_system/repositories/home_repository.dart';
import 'package:get/get.dart';

class VehicleDetailController extends GetxController {
  ListVehicleController listVehicleController = ListVehicleController();
  RxList<Vehicle> vehicles = <Vehicle>[].obs;
  RxList<Vehicle> vehiclesComplete = <Vehicle>[].obs;
  Rx<Vehicle>? vehicleDetail;
  @override
  void onInit() async {
    //final Map<dynamic, dynamic>? args = Get.arguments;
    listVehicleController = Get.find<ListVehicleController>();
    vehicles.add(listVehicleController.vehiclesComplete.first);
  }
  void filter(){
   // var find = vehiclesComplete.where((element) => element.idVehiculoSucursal==i.idVehiculoSucursal);
  }
}
