import 'package:car_system/rest.dart';
import 'package:get/get.dart';

class RegisterClientRepository extends GetConnect {
  Future<dynamic> createClient(Map<String, dynamic> _body) async {
    print(_body);
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
