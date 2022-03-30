import 'package:car_system/app/data/models/user_model.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;

import '../../../../rest.dart';
import '../../../core/utils/user_storage_controller.dart';
import '../../../modules/splash/splash_controller.dart';

class AuthenticationApi {
  final Dio _dio = Get.find<Dio>();

  Future<List<User>> fetchUserInformation(int? idCollaborator) async {
    SplashController _splashController = Get.find();
    final Response response = await _dio.get(
      Rest.USER_INFORMATION + idCollaborator.toString(),
        options: Options(
          headers: {'Authorization': 'Bearer: ${_splashController.user.token}'},
        ));
    return (response.data['response'] as List)
        .map((e) => User.fromJson(e))
        .toList();
  }
}