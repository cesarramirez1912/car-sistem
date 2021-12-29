import 'package:car_system/colors.dart';
import 'package:car_system/controllers/login_controller.dart';
import 'package:car_system/widgets/button.dart';
import 'package:car_system/widgets/input.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginView extends GetView<LoginController> {
  @override
  Widget build(context) => Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 45),
          child: Center(
            child: SingleChildScrollView(
                child: Obx(()=>
                   Column(
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
                  CustomInput(
                      labelText: 'Celular',
                      prefixIcon: Icon(Icons.phone_android),
                      textEditingController: controller.phone),
                  const SizedBox(
                    height: 6,
                  ),
                  CustomInput(
                      labelText: 'Contraseña',
                      prefixIcon: Icon(Icons.lock_outline_rounded),
                      textEditingController: controller.password),
                  const SizedBox(
                    height: 22,
                  ),
                  controller.isFetching.value
                      ? const CircularProgressIndicator()
                      : CustomButton(
                          'ENTRAR',
                          () async => await controller.fetchLogin(),
                          ColorPalette.PRIMARY,withShadow: false)
              ],
            ),
                )),
          ),
        ),
      );
}
