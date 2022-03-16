import 'package:car_system/app/data/providers/remote/list_vehicles_api.dart';
import 'package:get/get.dart';

import '../../models/vehicle.dart';

class ListVehiclesRepository{
  final ListVehiclesApi _sellsApi = Get.find<ListVehiclesApi>();

  Future<List<Vehicle>> fetchVehicles(int idSucursal) => _sellsApi.fetchVehicles(idSucursal);

}