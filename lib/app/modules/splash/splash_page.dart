import 'package:car_system/app/modules/splash/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../responsive.dart';
import '../../core/theme/colors.dart';


class SplashPage extends GetView<SplashController> {
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
                  height: 22,
                ),
                Text(
                  controller.version.value.version,
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
