import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/colors.dart';
import '../../../data/models/cuotes.dart';
import '../../../global_widgets/button.dart';
import '../../../global_widgets/dialog_confirm.dart';
import '../../../global_widgets/plan.dart';
import '../../../global_widgets/spacing.dart';
import '../../vehicle_detail/vehicle_detail_controller.dart';

Future selectPlanDialog(VehicleDetailController controller, context) {
  return CustomDialogConfirm(
    context,
    actions: [
      Padding(
        padding: const EdgeInsets.all(10),
        child: CustomButton('CANCELAR', () => Get.back(), ColorPalette.PRIMARY,
            edgeInsets: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            fontSize: 12,
            isLoading: controller.isLoading.value),
      ),
    ],
    body: ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: controller.vehicleSelected.length,
      itemBuilder: (BuildContext context, int index) {
        Cuota cuota =
            Cuota.fromJson(controller.vehicleSelected[index].toJson());
        return Column(
          children: [
            GestureDetector(
              onTap: () => controller.selectedPlan(cuota),
              child: CustomPlan(index, cuota,
                  textRender: controller.typesMoneySelected.value.name),
            ),
            CustomButton('ELEGIR PLAN N° ${(index + 1).toString()}',
                () => controller.selectedPlan(cuota), ColorPalette.YELLOW),
            CustomSpacing(),
          ],
        );
      },
    ),
  );
}
