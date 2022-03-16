import 'package:car_system/app/modules/login/local_widgets/input_login.dart';
import '../../core/theme/colors.dart';
import '../../global_widgets/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../global_widgets/button.dart';
import 'login_controller.dart';

class LoginView extends GetView<LoginController> {
  @override
  Widget build(context) => Scaffold(
          body: Responsive(
        desktop: Center(
          child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(20),
              width: 600,
              child: principal(context)),
        ),
        mobile: principal(context),
        tablet: Center(
          child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(20),
              width: 600,
              child: principal(context)),
        ),
      ));

  Widget principal(context) {
    return Container(
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
                            : Icons.remove_red_eye_outlined)),
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
                  controller.userStorageController.packageInfo.value.version,
                  style: const TextStyle(
                      color: Colors.grey, fontSize: 9, letterSpacing: 2),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
