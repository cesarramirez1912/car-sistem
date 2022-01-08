import 'package:car_system/models/user_model.dart';
import 'package:car_system/rest.dart';
import 'package:get/get.dart';

class LoginRepository extends GetConnect {
  Future<dynamic> fetchLogin(Map<String, String> _body) async {
    final response =
        await post(Rest.LOGIN, _body).timeout(const Duration(seconds: 5));
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
}
