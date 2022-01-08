import 'package:car_system/models/essencial_vehicle_models/brand.dart';
import 'package:car_system/models/user_model.dart';
import 'package:car_system/rest.dart';
import 'package:get/get.dart';

class EssencialVehicleRepository extends GetConnect {
  Future<dynamic> getchLogin(Map<String, String> _body) async {
    final response = await get(Rest.CLIENTS);
    print(response.statusText);
    if (response.status.hasError) {
      return Future.error(
          'Ocurrio un error al traer los datos, pruebe de nuevo');
    } else {
      if (response.body['response'].length == 0) {
        return Future.error(
            'Sin registro, verifique de nuevo los datos ingressados');
      } else {
        List<User> _list = [];
        for (var i in response.body['response']) {
          _list.add(User.fromJson(i));
        }
        return _list;
      }
    }
  }

  Future<dynamic> fetchVehicleInformation(
      List listType, String url, dynamic fromJson) async {
    final response = await get(url);
    List<String> _listString = [];
    if (response.status.hasError) {
      return Future.error(
          'Ocurrio un error al traer los datos de INFORMACIONES DE VEHICULO, pruebe de nuevo');
    } else {
      for (var i in response.body['response']) {
        String key = response.body['response'][0].keys.elementAt(0);
        _listString.add(i[key]);
        listType.add(fromJson(i));
      }
      return [listType, _listString];
    }
  }
}
