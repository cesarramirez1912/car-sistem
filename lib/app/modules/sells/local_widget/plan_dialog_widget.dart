import 'package:car_system/app/data/enums/types_moneys.dart';
import 'package:car_system/app/global_widgets/dialog_confirm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/colors.dart';
import '../../../core/utils/remove_money_format.dart';
import '../../../global_widgets/button.dart';
import '../../../global_widgets/input.dart';
import '../../../global_widgets/spacing.dart';
import '../../../global_widgets/title.dart';
import '../../vehicle_detail/vehicle_detail_controller.dart';
import 'render_money_type_widget.dart';

Future dialogPlanSell(VehicleDetailController controller, context) {
  Widget _actions() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        CustomButton(
            'REGISTRAR PLAN', controller.registerCuota, ColorPalette.SECUNDARY,
            edgeInsets: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            fontSize: 12,
            isLoading: controller.isLoading.value),
        const SizedBox(
          width: 10,
        ),
        CustomButton('CANCELAR', () => Get.back(), ColorPalette.PRIMARY,
            edgeInsets: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            fontSize: 12,
            isLoading: controller.isLoading.value),
      ],
    );
  }

  return CustomDialogConfirm(
    context,
    actions: [_actions()],
    body: Form(
      key: controller.formKeyDialog,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CustomSpacing(),
          CustomTitle('Cant. Cuotas | Refuerzos'),
          CustomSpacing(),
          CustomInput(
            '',
            'Cantidad cuotas',
            isNumber: true,
            onSaved: (text) =>
                controller.cuota.value.cantidadCuotas = int.parse(text),
            validator: (String text) {
              if (text.isEmpty) {
                return 'Campo obligatorio.';
              } else {
                if (double.parse(text.toString()) == 0.0) {
                  return 'Cantidad debe de ser minimo 1';
                }
              }
            },
            textEditingController: controller.textCantidadCuotas,
          ),
          CustomInput('', 'Cantidad refuerzos',
              validator: (String text) {
                double moneyValue = 0.0;
                if (controller.typesMoneySelected.value ==
                    TypesMoneys.DOLARES) {
                  moneyValue = RemoveMoneyFormat()
                      .removeToDouble(controller.textRefuezoDolares.text);
                } else {
                  moneyValue = RemoveMoneyFormat()
                      .removeToDouble(controller.textRefuezoGuaranies.text);
                }
                if (text.isEmpty) {
                  if (moneyValue > 0.0) {
                    return 'Campo obligatorio';
                  } else {
                    return null;
                  }
                }
                if (double.parse(text.toString()) == 0.0) {
                  return 'Cantidad debe de ser minimo 1';
                }
              },
              isNumber: true,
              onSaved: (text) {
                if (text == '') {
                  controller.cuota.value.cantidadRefuerzo = null;
                } else {
                  controller.cuota.value.cantidadRefuerzo = int.parse(text);
                }
              },
              textEditingController: controller.textCantidadRefuerzos),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: renderWidgetsMoneyType(controller),
          ),
        ],
      ),
    ),
  );
}
