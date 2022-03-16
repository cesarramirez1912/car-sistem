import 'package:car_system/app/data/models/user_model.dart';
import 'package:car_system/app/data/providers/remote/authentication_api.dart';
import 'package:get/get.dart';

class AuthenticationRepository{
  final AuthenticationApi _authenticationApi = Get.find<AuthenticationApi>();

  Future<List<User>> fetchUserInformation(idCollaborator) => _authenticationApi.fetchUserInformation(idCollaborator);

}