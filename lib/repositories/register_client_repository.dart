import 'package:car_system/models/register_client_model.dart';
import 'package:car_system/rest.dart';
import 'package:get/get.dart';

class ClientRepository extends GetConnect {
  Future<dynamic> requestClients(int? idCompany) async {
    final response =
        await get(Rest.CLIENTS_FROM_COMPANY + idCompany.toString());
    if (response.status.hasError) {
      if (response.body['message'] != '') {
        return Future.error(
            'Ocurrió un error al traer los clientes, intente de nuevo.');
      } else {
        return Future.error(response.body['message']);
      }
    } else {
      List<ClientModel> _list = [];
      for (var i in response.body['response']) {
        _list.add(ClientModel.fromJson(i));
      }
      return _list;
    }
  }

  Future<dynamic> createClient(Map<String, dynamic> _body) async {
    final response = await post(Rest.CLIENTS, _body);
    if (response.status.hasError) {
      return Future.error(
          'Ocurrió un error al registrar cliente, intente de nuevo.');
    } else {
      if (response.body['response'].length == 0) {
        return Future.error(
            'Ocurrió un error al registrar cliente, intente de nuevo.');
      } else {
        // List<User> _list = [];
        // for (var i in response.body['response']) {
        //   _list.add(User.fromJson(i));
        // }
        // return _list;
        return response.body['response'][0]['id_cliente'];
      }
    }
  }
}
