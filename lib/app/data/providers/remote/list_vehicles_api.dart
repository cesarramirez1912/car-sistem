import 'package:car_system/app/core/utils/user_storage_controller.dart';
import 'package:car_system/app/data/models/vehicle.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import '../../../../rest.dart';

class ListVehiclesApi{
  final Dio _dio = Get.find<Dio>();
  final UserStorageController _user = Get.find();

  Future<List<Vehicle>> fetchVehicles(int idSucursal) async {
    if(idSucursal==0){
      throw Exception('');
    }
    final Response response = await _dio.get(Rest.VEHICLES_BRANCH+idSucursal.toString(),
        options: Options(
          headers: {'Authorization': 'Bearer: ${_user.user?.value.token}'},
        ));
    return (response.data['response'] as List).map((e) => Vehicle.fromJson(e)).toList();
  }

}