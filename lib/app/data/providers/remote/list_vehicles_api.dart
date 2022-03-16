import 'package:car_system/app/data/models/cuote_detail_model.dart';
import 'package:car_system/app/data/models/refuerzo_detail_model.dart';
import 'package:car_system/app/data/models/sale_collaborator_model.dart';
import 'package:car_system/app/data/models/vehicle.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import '../../../../rest.dart';

class ListVehiclesApi{
  final Dio _dio = Get.find<Dio>();

  Future<List<Vehicle>> fetchVehicles(int idSucursal) async {
    if(idSucursal==0){
      throw Exception('');
    }
    final Response response = await _dio.get(Rest.VEHICLES_BRANCH+idSucursal.toString());
    return (response.data['response'] as List).map((e) => Vehicle.fromJson(e)).toList();
  }

}