
import 'package:car_system/app/data/models/user_model.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;

import '../../../../rest.dart';

class AuthenticationApi{
  final Dio _dio = Get.find<Dio>();

  Future<List<User>> fetchUserInformation(int? idCollaborator) async {
    final Response response = await _dio.get(Rest.USER_INFORMATION + idCollaborator.toString());
    return (response.data['response'] as List).map((e) => User.fromJson(e)).toList();
  }

}