import 'package:car_system/controllers/user_storage_controller.dart';
import 'package:car_system/models/static_model.dart';
import 'package:car_system/models/user_model.dart';
import 'package:car_system/repositories/login_repository.dart';
import 'package:car_system/route_manager.dart';
import 'package:car_system/widgets/snack_bars/snack_bar_error.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  var isFetching = false.obs;
  Rx<User>? user = User().obs;
  LoginRepository _loginRepository = LoginRepository();

  TextEditingController phone = TextEditingController(text: '');
  TextEditingController password = TextEditingController(text: '');

  RxBool seePassword = true.obs;

  @override
  void onInit() {
    _loginRepository = LoginRepository();
    super.onInit();
  }

  Future<void> fetchLogin() async {
    UserStorageController userStorageController = Get.find();
    isFetching.value = true;
    try {
      List<User> res = await _loginRepository
          .fetchLogin({"celular": phone.text, "sena": password.text});
      user?.value = res.first;
      await userStorageController.storePriceModel(user!.value);
      isFetching.value = false;
      if (res.first.dias < Static.DAYS_PERMIT_APP_USE ||
          res.first.activo == 0) {
        CustomSnackBarError('Porfavor contactar al soporte.');
      } else {
        Get.offAndToNamed(RouterManager.HOME);
      }
    } catch (e) {
      isFetching.value = false;
      CustomSnackBarError(e.toString());
    }
  }
}
