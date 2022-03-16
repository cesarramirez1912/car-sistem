import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/theme/colors.dart';

SnackbarController CustomSnackBarError(String message) {
  return Get.snackbar("ERROR", message,
      colorText: Colors.white,
      instantInit: false,
      duration: const Duration(seconds: 2),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: ColorPalette.PRIMARY);
}
