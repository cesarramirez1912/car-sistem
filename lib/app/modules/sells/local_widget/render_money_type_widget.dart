import 'package:car_system/app/data/enums/types_moneys.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/utils/remove_money_format.dart';
import '../../../global_widgets/input.dart';
import '../../../global_widgets/spacing.dart';
import '../../../global_widgets/title.dart';
import '../../vehicle_detail/vehicle_detail_controller.dart';

List<Widget> renderWidgetsMoneyType(VehicleDetailController controller) {
  switch (controller.typesMoneySelected.value) {
    case TypesMoneys.GUARANIES:
      return [
        CustomTitle('Plan guaraníes'),
        CustomSpacing(),
        CustomInput(
          '',
          'Entrada',
          isNumber: true,
          onChanged: (text) => controller.textEntradaGuaranies
              .updateValue(RemoveMoneyFormat().removeToDouble(text)),
          iconData: Icons.price_change_outlined,
          textEditingController: controller.textEntradaGuaranies,
          onSaved: (text) => controller.cuota.value.entradaGuaranies = text,
        ),
        CustomInput(
          '',
          'Cuota',
          isNumber: true,
          onChanged: (text) => controller.textCuotaGuaranies
              .updateValue(RemoveMoneyFormat().removeToDouble(text)),
          validator: (String text) {
            String newString = RemoveMoneyFormat().removeToString(text);
            if (text.isEmpty) return 'Informar cuota mensual.';
            if (newString.isNum) {
              if (double.parse(newString.toString()) == 0.0) {
                return 'Informar cuota mensual.';
              }
            } else {
              return 'Informar cuota mensual.';
            }
          },
          iconData: Icons.price_change_outlined,
          textEditingController: controller.textCuotaGuaranies,
          onSaved: (text) => controller.cuota.value.cuotaGuaranies = text,
        ),
        CustomInput(
          '',
          'Refuerzo',
          isNumber: true,
          onChanged: (text) => controller.textRefuezoGuaranies
              .updateValue(RemoveMoneyFormat().removeToDouble(text)),
          validator: (String text) {
            String newString = RemoveMoneyFormat().removeToString(text);
            if (controller.textCantidadRefuerzos.text.isNotEmpty) {
              if (newString.isNum) {
                if (double.parse(newString.toString()) == 0.0) {
                  return 'Informar cuota refuerzo.';
                }
              } else {
                return 'Informar cuota refuerzo.';
              }
            }
          },
          iconData: Icons.price_change_outlined,
          onSaved: (text) => controller.cuota.value.refuerzoGuaranies = text,
          textEditingController: controller.textRefuezoGuaranies,
        ),
      ];

    case TypesMoneys.DOLARES:
      return [
        CustomTitle('Plan dólares'),
        CustomSpacing(),
        CustomInput('', 'Entrada',
            isNumber: true,
            iconData: Icons.price_change_outlined,
            onSaved: (text) => controller.cuota.value.entradaDolares = text,
            textEditingController: controller.textEntradaDolares),
        CustomInput('', 'Cuota',
            isNumber: true,
            validator: (String text) {
              String newString = RemoveMoneyFormat().removeToString(text);
              if (text.isEmpty) return 'Informar cuota mensual.';
              if (newString.isNum) {
                if (double.parse(newString.toString()) == 0.0) {
                  return 'Informar cuota mensual.';
                }
              } else {
                return 'Informar cuota mensual.';
              }
            },
            iconData: Icons.price_change_outlined,
            onSaved: (text) => controller.cuota.value.cuotaDolares = text,
            textEditingController: controller.textCuotaDolares),
        CustomInput('', 'Refuerzo',
            isNumber: true,
            validator: (String text) {
              String newString = RemoveMoneyFormat().removeToString(text);
              if (controller.textCantidadRefuerzos.text.isNotEmpty) {
                if (newString.isNum) {
                  if (double.parse(newString.toString()) == 0.0) {
                    return 'Informar cuota refuerzo.';
                  }
                } else {
                  return 'Informar cuota refuerzo.';
                }
              }
            },
            iconData: Icons.price_change_outlined,
            onSaved: (text) => controller.cuota.value.refuerzoDolares = text,
            textEditingController: controller.textRefuezoDolares),
      ];
    default:
      return [];
  }
}
