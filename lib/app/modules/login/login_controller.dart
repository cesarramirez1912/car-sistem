import 'package:car_system/app/data/repositories/local/local_auth_repository.dart';
import 'package:car_system/app/data/repositories/remote/login_repository.dart';
import 'package:car_system/app/routes/app_routes.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/utils/user_storage_controller.dart';
import '../../core/utils/static_model.dart';
import '../../data/enums/roles.dart';
import '../../data/models/user_model.dart';
import '../../global_widgets/snack_bars/snack_bar_error.dart';

class LoginController extends GetxController {
  UserStorageController userStorageController = Get.find();
  final LoginRepository _loginRepository = Get.find();
  final LocalAuthRepository _localAuthRepository = Get.find();

  var isFetching = false.obs;
  Rx<User>? user = User().obs;

  TextEditingController phone = TextEditingController(text: '');
  TextEditingController password = TextEditingController(text: '');

  RxBool seePassword = true.obs;

  Future<void> fetchLogin() async {
    UserStorageController userStorageController = Get.find();
    isFetching.value = true;
    try {
      List<User> res = await _loginRepository
          .fetchLogin({"celular": phone.text, "sena": password.text});
      user?.value = res.first;
      await userStorageController.storePriceModel(user!.value);
      _localAuthRepository.setUser(user!.value);

      if (res.first.dias < Static.DAYS_PERMIT_APP_USE ||
          res.first.activo == 0) {
        CustomSnackBarError('Porfavor contactar al soporte.');
      } else {
        Get.offAndToNamed(user?.value.cargo == Roles.SUPER.name ||
                user?.value.cargo == Roles.ADMIN.name
            ? AppRoutes.DASH
            : AppRoutes.VEHICLES);
      }
    } catch (e) {
      if (e is DioError) {
        CustomSnackBarError(e.response?.data['message']);
      } else {
        CustomSnackBarError(e.toString());
      }
    } finally {
      isFetching.value = false;
    }
  }
}
