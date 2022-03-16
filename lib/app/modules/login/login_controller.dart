import 'package:car_system/app/data/repositories/local/local_auth_repository.dart';
import 'package:car_system/app/data/repositories/remote/login_repository.dart';
import 'package:car_system/app/routes/app_routes.dart';
import 'package:car_system/controllers/user_storage_controller.dart';
import 'package:car_system/models/static_model.dart';
import 'package:car_system/widgets/menu_drawer.dart';
import 'package:car_system/widgets/snack_bars/snack_bar_error.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/models/user_model.dart';

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

      isFetching.value = false;
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
      isFetching.value = false;
      CustomSnackBarError(e.toString());
    }
  }
}
