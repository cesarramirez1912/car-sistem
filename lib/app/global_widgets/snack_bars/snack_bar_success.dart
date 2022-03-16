import 'package:car_system/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

SnackbarController CustomSnackBarSuccess(String message) {
  return Get.snackbar("SUCCESS!", message,colorText: Colors.white,
      instantInit: false,
      duration: const Duration(seconds: 2),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: ColorPalette.GREEN);
}
