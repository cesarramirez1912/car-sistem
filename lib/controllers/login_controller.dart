import 'dart:math';

import 'package:car_system/models/user_model.dart';
import 'package:car_system/repositories/login_repository.dart';
import 'package:car_system/route_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  var isFetching = false.obs;
   Rx<User>? user = User().obs;
  LoginRepository _loginRepository = LoginRepository();

  TextEditingController phone = TextEditingController(text: '0973412178');
  TextEditingController password = TextEditingController(text: '12345');


  @override
  void onInit() {
    _loginRepository = LoginRepository();
    super.onInit();
  }

  Future<void> fetchLogin() async {
    isFetching.value = true;
    try {
      List<User> res = await _loginRepository.fetchLogin( {"celular": phone.text, "sena": password.text});
      user?.value = res.first;
      isFetching.value = false;
      Get.offAndToNamed(RouterManager.HOME);
    } catch (e) {
      isFetching.value = false;
      Get.snackbar("ERROR", e.toString(), instantInit: false,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red);
    }
  }
}
