import 'package:car_system/models/user_model.dart';
import 'package:car_system/rest.dart';
import 'package:get/get.dart';

class UserStorageRepository extends GetConnect {
  Future<dynamic> fetchUserInformation(int? idCollaborator) async {
    final response =
        await get(Rest.USER_INFORMATION + idCollaborator.toString())
            .timeout(const Duration(seconds: 10));
    if (response.status.hasError) {
      if (response.body['message'] != '') {
        return Future.error(response.body['message']);
      } else {
        return Future.error(
            'Sin registro, verifique de nuevo los datos ingressados');
      }
    } else {
      List<User> _list = [];
      for (var i in response.body['response']) {
        _list.add(User.fromJson(i));
      }
      return _list;
    }
  }
}
