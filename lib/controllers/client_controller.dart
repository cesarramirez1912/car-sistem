import 'package:car_system/controllers/user_controller.dart';
import 'package:car_system/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClientController extends GetxController {
  User? user = User();
  UserController userController = UserController();
  final  formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    userController = Get.find<UserController>();
    user = userController.user;
    super.onInit();
  }

  void registerClient() {
    if (formKey.currentState == null) {
      print("_formKey.currentState is null!");
    } else if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      print(user?.toJson());
    }
  }
}
