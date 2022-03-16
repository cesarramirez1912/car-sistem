import 'package:car_system/app/data/providers/remote/essencial_vehicle_api.dart';
import 'package:car_system/app/data/providers/remote/list_vehicles_api.dart';
import 'package:get/get.dart';

import '../../models/user_model.dart';

class EssencialVehiclesRepository{
  final EssencialVehicleApi _essencialVehicleApi = Get.find<EssencialVehicleApi>();

  Future<List<User>> getchLogin(Map<String, String> _body) => _essencialVehicleApi.getchLogin(_body);

  Future<dynamic> fetchVehicleInformation(
      List listType, String url, dynamic fromJson,
      {return2arrays = true}) =>_essencialVehicleApi.fetchVehicleInformation(listType, url, fromJson);

  Future<dynamic> postInformations(
      String url, Map<dynamic, dynamic> body) => _essencialVehicleApi.postInformations(url, body);

  Future<dynamic> createVehicle(Map<String, dynamic> _body) => _essencialVehicleApi.createVehicle(_body);

}