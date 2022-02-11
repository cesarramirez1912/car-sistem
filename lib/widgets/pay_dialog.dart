import 'package:car_system/colors.dart';
import 'package:car_system/common/money_format.dart';
import 'package:car_system/common/remove_money_format.dart';
import 'package:car_system/widgets/button.dart';
import 'package:car_system/widgets/input.dart';
import 'package:car_system/widgets/spacing.dart';
import 'package:car_system/widgets/title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:get/get.dart';

Future payDialog(controller, int? id, int? idVenta,
    {required String fecha,
    required dynamic faltanteGuaranies,
    required dynamic pagoGuaranies,
    required dynamic faltanteDolares,
    required dynamic pagoDolares,
    required bool isCuote}) {
  print(pagoDolares);
  print(faltanteDolares);
  MoneyMaskedTextController textGuaraniesCosto = MoneyMaskedTextController(
      leftSymbol: 'G\$ ', precision: 0, decimalSeparator: '');
  MoneyMaskedTextController textDolaresCosto =
      MoneyMaskedTextController(leftSymbol: 'U\$ ');

  if (faltanteGuaranies != null) {
    textGuaraniesCosto.text = faltanteGuaranies.toString();
  }
  if (faltanteDolares != null) {
    textDolaresCosto.text = faltanteDolares.toStringAsFixed(2);
  }
  String? validatorCuoteDinero(String text) {
    double cuotaGuaraniesDouble =
        RemoveMoneyFormat().removeToDouble(textGuaraniesCosto.text);
    double cuotaDolaresDouble =
        RemoveMoneyFormat().removeToDouble(textDolaresCosto.text);

    if (faltanteGuaranies != null && faltanteDolares == null) {
      if (cuotaGuaraniesDouble > 0.0) {
        return null;
      } else {
        return 'Campo obligatorio.';
      }
    }
    if (faltanteDolares != null && faltanteGuaranies == null) {
      if (cuotaDolaresDouble > 0.0) {
        return null;
      } else {
        return 'Campo obligatorio.';
      }
    }
    return null;
  }

  Widget dialogPlan(controller, fecha, faltanteGuaranies, faltanteDolares,
      pagoGuaranies, pagoDolares) {
    return SingleChildScrollView(
      child: Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
          child: Obx(
            () => controller.isLoadingRequest.value
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CircularProgressIndicator(),
                      CustomSpacing(height: 6),
                      const Text('Pagando...')
                    ],
                  )
                : Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomTitle('FECHA'),
                      CustomTitle(fecha,
                          fontWeight: FontWeight.w500, fontSize: 15),
                      CustomTitle('TOTAL'),
                      CustomTitle(
                          faltanteGuaranies != null
                              ? MoneyFormat()
                                  .formatCommaToDot(faltanteGuaranies)
                              : MoneyFormat().formatCommaToDot(faltanteDolares,
                                  isGuaranies: false),
                          fontWeight: FontWeight.w500,
                          fontSize: 15),
                      CustomTitle('TOTAL A PAGAR'),
                      CustomSpacing(height: 6),
                      CustomInput('', 'Total a pagar',
                          onChanged: (text) {
                            double valorPagar =
                                RemoveMoneyFormat().removeToDouble(text);
                            if (faltanteGuaranies != null) {
                              if (valorPagar > faltanteGuaranies) {
                                textGuaraniesCosto.updateValue(
                                    double.parse(faltanteGuaranies.toString()));
                              }
                              if (text.toString().length < 4) {
                                textGuaraniesCosto.updateValue(0);
                              }
                            } else {
                              if (valorPagar > faltanteDolares) {
                                textDolaresCosto.updateValue(
                                    double.parse(faltanteDolares.toString()));
                              }
                            }
                          },
                          validator: (text) => validatorCuoteDinero(text),
                          textEditingController: faltanteGuaranies != null
                              ? textGuaraniesCosto
                              : textDolaresCosto),
                    ],
                  ),
          )),
    );
  }

  return Get.defaultDialog(
      title: 'PAGAR ${isCuote ? 'CUOTA' : 'REFUERZO'}',
      content: dialogPlan(controller, fecha, faltanteGuaranies, faltanteDolares,
          pagoGuaranies, pagoDolares),
      actions: [
        Obx(
          () => controller.isLoadingRequest.value
              ? const SizedBox()
              : Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomButton(
                        '     PAGAR     ',
                        () async => await controller.postPago(
                            faltanteDolares != null
                                ? (RemoveMoneyFormat().removeToDouble(
                                            textDolaresCosto.text) +
                                        pagoDolares)
                                    .toString()
                                : null,
                            faltanteGuaranies != null
                                ? (pagoGuaranies +
                                        RemoveMoneyFormat().removeToDouble(
                                            textGuaraniesCosto.text))
                                    .toString()
                                : null,
                            id,
                            idVenta,
                            isCuote: isCuote),
                        ColorPalette.GREEN,
                        edgeInsets: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        fontSize: 12,
                        isLoading: controller.isLoadingRequest.value),
                    const SizedBox(
                      width: 10,
                    ),
                    CustomButton(
                        'CANCELAR', () => Get.back(), ColorPalette.PRIMARY,
                        edgeInsets: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        fontSize: 12,
                        isLoading: controller.isLoadingRequest.value),
                  ],
                ),
        )
      ]);
}
