import 'package:car_system/app/data/models/user_model.dart';
import 'package:car_system/app/data/repositories/remote/list_vehicles_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../core/utils/user_storage_controller.dart';
import '../../data/models/vehicle.dart';


class ListVehicleController extends GetxController {
  final ListVehiclesRepository _listVehiclesRepository = Get.find();
  UserStorageController userStorageController = Get.find();
  RxList<Vehicle> vehiclesComplete = <Vehicle>[].obs;
  RxList<Vehicle> vehicles = <Vehicle>[].obs;
  RxList<Vehicle> vehiclesAux = <Vehicle>[].obs;
  User? user = User();

  RxBool isLoading = false.obs;

  TextEditingController searchTextController = TextEditingController(text: '');

  @override
  void onInit() async {
    user = userStorageController.user?.value;
    isLoading.value = true;
    await fetchVehicles();
    isLoading.value = false;
    super.onInit();
  }

  Future<void> fetchVehicles() async {
    try {
      List<Vehicle> res =
          await _listVehiclesRepository.fetchVehicles(user?.idSucursal ?? 0);
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
      vehicles.clear();
      vehiclesAux.clear();
      vehicles.addAll(resFil);
      vehiclesAux.addAll(resFil);
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
              element.marca!.contains(text.toUpperCase()) ||
              element.modelo!.contains(text.toUpperCase()))
          .toList();
      vehicles.value = _list;
    }
  }
}
