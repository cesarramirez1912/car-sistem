import 'package:car_system/models/deudor_model.dart';
import 'package:car_system/rest.dart';
import 'package:get/get.dart';

class DeudorRepository extends GetConnect {
  Future<dynamic> requestDeudores(int? idCompany) async {
    final response = await get(Rest.DEUDORES_CUOTA + idCompany.toString());
    if (response.status.hasError) {
      if (response.body['message'] != '') {
        return Future.error(
            'Ocurrió un error al traer los clientes, intente de nuevo.');
      } else {
        return Future.error(response.body['message']);
      }
    } else {
      List<DeudorModel> _list = [];
      for (var i in response.body['response']) {
        _list.add(DeudorModel.fromJson(i));
      }
      return _list;
    }
  }

  Future<dynamic> requestDeudoresRefuerzo(int? idCompany) async {
    final response = await get(Rest.DEUDORES_REFUERZO + idCompany.toString());
    if (response.status.hasError) {
      if (response.body['message'] != '') {
        return Future.error(
            'Ocurrió un error al traer los clientes, intente de nuevo.');
      } else {
        return Future.error(response.body['message']);
      }
    } else {
      List<DeudorModel> _list = [];
      for (var i in response.body['response']) {
        _list.add(DeudorModel.fromJson(i));
      }
      return _list;
    }
  }
}
