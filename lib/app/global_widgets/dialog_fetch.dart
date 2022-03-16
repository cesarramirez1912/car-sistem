import 'package:car_system/app/global_widgets/snack_bars/snack_bar_error.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> CustomDialogFetch(Function request,
    {String? text = 'Cargando datos'}) async {
  Get.dialog(
    Center(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 5),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding:
                    EdgeInsets.only(top: 15, bottom: 30, left: 8, right: 8),
                child: CircularProgressIndicator(),
              ),
              Flexible(
                child: Text(
                  text!,
                  style: TextStyle(fontSize: 16),
                  overflow: TextOverflow.clip,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
    barrierDismissible: false,
  );

  try {
    await request();
  } catch (e) {
    CustomSnackBarError(e.toString());
  } finally {
    Get.back();
  }
}
