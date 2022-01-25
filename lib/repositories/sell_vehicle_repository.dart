import 'package:car_system/models/cuote_detail_model.dart';
import 'package:car_system/models/refuerzo_detail_model.dart';
import 'package:car_system/models/register_client_model.dart';
import 'package:car_system/models/sale_collaborator_model.dart';
import 'package:car_system/rest.dart';
import 'package:get/get.dart';

class SellVehicleRepository extends GetConnect {
  Future<dynamic> requestSales(int? idCollaborator) async {
    final response =
        await get(Rest.SELLS_COLLABORATOR + idCollaborator.toString());
    if (response.status.hasError) {
      if (response.body['message'] != '') {
        return Future.error(response.body['message']);
      } else {
        return Future.error(
            'Ocurrió un error al hacer venta, intente de nuevo.');
      }
    } else {
      List<SaleCollaboratorModel> _list = [];
      for (var res in response.body['response']) {
        _list.add(SaleCollaboratorModel.fromJson(res));
      }
      return _list;
    }
  }

  Future<dynamic> postCuote(Map<String, dynamic> _body) async {
    final response = await post(Rest.SELLS_CUOTE, _body);
    if (response.status.hasError) {
      if (response.body['message'] != '') {
        return Future.error(response.body['message']);
      } else {
        return Future.error(
            'Ocurrió un error al hacer PAGAR, intente de nuevo.');
      }
    } else {
      return 'ok';
    }
  }

  Future<dynamic> postRefuerzo(Map<String, dynamic> _body) async {
    final response = await post(Rest.SELLS_REFUERZO, _body);
    if (response.status.hasError) {
      if (response.body['message'] != '') {
        return Future.error(response.body['message']);
      } else {
        return Future.error('Ocurrió un error al PAGAR, intente de nuevo.');
      }
    } else {
      return 'ok';
    }
  }

  Future<dynamic> sellVehicle(Map<String, dynamic> _body) async {
    final response = await post(Rest.SELLS, _body);
    if (response.status.hasError) {
      if (response.body['message'] != '') {
        return Future.error(response.body['message']);
      } else {
        return Future.error(
            'Ocurrió un error al hacer venta, intente de nuevo.');
      }
    } else {
      return 'ok';
    }
  }

  Future<dynamic> requestCuotes(int? idVenta) async {
    final response = await get(Rest.SELLS_CUOTES_DETAILS + idVenta.toString());
    if (response.status.hasError) {
      if (response.body['message'] != '') {
        return Future.error(response.body['message']);
      } else {
        return Future.error(
            'Ocurrió un error al hacer venta, intente de nuevo.');
      }
    } else {
      List<CuoteDetailModel> _list = [];
      for (var res in response.body['response']) {
        _list.add(CuoteDetailModel.fromJson(res));
      }
      return _list;
    }
  }

  Future<dynamic> requestRefuerzos(int? idVenta) async {
    final response =
        await get(Rest.SELLS_REFUERZOS_DETAILS + idVenta.toString());
    if (response.status.hasError) {
      if (response.body['message'] != '') {
        return Future.error(response.body['message']);
      } else {
        return Future.error(
            'Ocurrió un error al hacer venta, intente de nuevo.');
      }
    } else {
      List<RefuerzoDetailModel> _list = [];
      for (var res in response.body['response']) {
        _list.add(RefuerzoDetailModel.fromJson(res));
      }
      return _list;
    }
  }
}
