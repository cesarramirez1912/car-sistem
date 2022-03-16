import 'package:car_system/app/data/models/user_model.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import '../../../../rest.dart';

class LoginApi{
  final Dio _dio = Get.find<Dio>();

  Future<List<User>> fetchLogin(Map<String, String> _body) async {
    final Response response = await _dio.post(Rest.LOGIN,data: _body).timeout(const Duration(seconds: 5));
    return (response.data['response'] as List).map((e) => User.fromJson(e)).toList();
  }

}