import 'dart:math';

import 'package:car_system/models/user_model.dart';
import 'package:car_system/models/vehicle.dart';
import 'package:car_system/rest.dart';
import 'package:get/get.dart';

class HomeRepository extends GetConnect {
  Future<dynamic> fetchVehicles(int idSucursal) async {
    if(idSucursal==0){
      return ;
    }
    final response = await get(Rest.VEHICLES_BRANCH+idSucursal.toString());
    if (response.status.hasError) {
      return Future.error(
          'Ocurrio un error al traer los datos, pruebe de nuevo');
    } else {
      List<Vehicle> _list = [];
      for (var i in response.body['response']) {
        _list.add(Vehicle.fromJson(i));
      }
      return _list;
    }
  }
}
