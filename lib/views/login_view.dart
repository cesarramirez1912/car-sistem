import 'package:car_system/colors.dart';
import 'package:car_system/controllers/login_controller.dart';
import 'package:car_system/controllers/user_storage_controller.dart';
import 'package:car_system/widgets/button.dart';
import 'package:car_system/widgets/input_login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginView extends GetView<LoginController> {
  UserStorageController userStorageController = Get.find();

  @override
  Widget build(context) => Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 45),
          child: Center(
            child: SingleChildScrollView(
                child: Obx(
              () => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'CAR SYSTEM',
                    style: TextStyle(
                        letterSpacing: -2,
                        color: ColorPalette.PRIMARY,
                        fontSize: 30,
                        fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomInputLogin(
                      labelText: 'Celular',
                      prefixIcon: const Icon(Icons.phone_android),
                      textEditingController: controller.phone),
                  const SizedBox(
                    height: 6,
                  ),
                  CustomInputLogin(
                    obscureText: controller.seePassword.value,
                      labelText: 'Contraseña',
                      suffixIcon: IconButton(
                          onPressed: () {
                            if (controller.seePassword.value) {
                              controller.seePassword.value = false;
                            } else {
                              controller.seePassword.value = true;
                            }
                          },
                          icon: Icon(controller.seePassword.value
                              ? Icons.visibility_off_outlined
                              : Icons.remove_red_eye_outlined )),
                      prefixIcon: const Icon(Icons.lock_outline_rounded),
                      textEditingController: controller.password),
                  const SizedBox(
                    height: 22,
                  ),
                  controller.isFetching.value
                      ? const CircularProgressIndicator()
                      : CustomButton(
                          'ENTRAR',
                          () async => await controller.fetchLogin(),
                          ColorPalette.PRIMARY,
                          withShadow: false),
                  const SizedBox(
                    height: 6,
                  ),
                  Text(
                    userStorageController.packageInfo.value.version,
                    style: const TextStyle(
                        color: Colors.grey, fontSize: 9, letterSpacing: 2),
                  ),
                ],
              ),
            )),
          ),
        ),
      );
}
