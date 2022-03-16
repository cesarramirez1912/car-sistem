import 'package:car_system/app/data/models/user_model.dart';
import 'package:car_system/app/data/providers/remote/login_api.dart';
import 'package:get/get.dart';

class LoginRepository{
  final LoginApi _loginApi = Get.find<LoginApi>();

  Future<List<User>> fetchLogin(Map<String,String> user) => _loginApi.fetchLogin(user);

}