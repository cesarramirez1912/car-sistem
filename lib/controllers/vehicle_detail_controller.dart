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
  Rx<Vehicle>? vehicleDetail;
  String idVehiculoSucursal = '';

  @override
  void onInit() async {
    Map<dynamic, dynamic>? args = Get.parameters;
    idVehiculoSucursal = args['idVehiculoSucursal'];
    listVehicleController = Get.find<ListVehicleController>();
    vehicles.addAll(listVehicleController.getVehiclesFromId(idVehiculoSucursal));
    vehicleDetail?.value = vehicles.first;
  }
}
