import 'package:car_system/app/global_widgets/button.dart';
import 'package:car_system/app/global_widgets/title.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/theme/colors.dart';

Future<dynamic> CustomDialogConfirm(BuildContext context,
    {String? text, Widget? body, List<Widget>? actions}) async {
  Widget dialogPlan() {
    return SizedBox(
      width: double.maxFinite,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            body ?? CustomTitle(text ?? 'CONFIRMAR ?'),
          ],
        ),
      ),
    );
  }

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    content: dialogPlan(),
    actions: actions ??
        [
          Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CustomButton(
                'CONFIRMAR',
                () => Get.back(result: true),
                ColorPalette.GREEN,
                edgeInsets:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                fontSize: 12,
              ),
              const SizedBox(
                width: 10,
              ),
              CustomButton(
                'CANCELAR',
                () => Get.back(result: false),
                ColorPalette.PRIMARY,
                edgeInsets:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                fontSize: 12,
              ),
            ],
          )
        ],
  );

  // show the dialog
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
