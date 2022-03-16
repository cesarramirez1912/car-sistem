import 'package:car_system/app/data/models/cuote_detail_model.dart';
import 'package:car_system/app/data/models/refuerzo_detail_model.dart';
import 'package:car_system/app/data/models/sale_collaborator_model.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import '../../../../rest.dart';
import '../../models/user_model.dart';

class EssencialVehicleApi {
  final Dio _dio = Get.find<Dio>();

  Future<List<User>> getchLogin(Map<String, String> _body) async {
    final Response response = await _dio.get(Rest.CLIENTS);
    return (response.data['response'] as List).map((e) => User.fromJson(e)).toList();
  }

  Future<dynamic> fetchVehicleInformation(
      List listType, String url, dynamic fromJson,
      {return2arrays = true}) async {
    final Response response = await _dio.get(url);
    List<String> _listString = [];
    for (var i in response.data['response']) {
      if (return2arrays) {
        String key = response.data['response'][0].keys.elementAt(0);
        _listString.add(i[key]);
        listType.add(fromJson(i));
      } else {
        listType.add(fromJson(i));
      }
    }
    return [listType, _listString];
  }

  Future<dynamic> postInformations(
      String url, Map<dynamic, dynamic> body) async {
    final Response response = await _dio.post(url, data: body);
    return 'ok';
  }

  Future<dynamic> createVehicle(Map<String, dynamic> _body) async {
    final Response response = await _dio.post(Rest.VEHICLES, data: _body);
    return response.data['response'];
  }
}
