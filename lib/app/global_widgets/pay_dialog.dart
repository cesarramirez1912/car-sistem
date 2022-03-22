import 'package:car_system/app/global_widgets/button.dart';
import 'package:car_system/app/global_widgets/input.dart';
import 'package:car_system/app/global_widgets/spacing.dart';
import 'package:car_system/app/global_widgets/textInputContainer.dart';
import 'package:car_system/app/global_widgets/title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:get/get.dart';
import '../core/theme/colors.dart';
import '../core/utils/date_format.dart';
import '../core/utils/money_format.dart';
import '../core/utils/remove_money_format.dart';

Future payDialog(controller, int? id, int? idVenta,
    {required String fecha,
    required dynamic faltanteGuaranies,
    required dynamic pagoGuaranies,
    required dynamic faltanteDolares,
    required dynamic pagoDolares,
    required bool isCuote,
    required BuildContext context}) {
  MoneyMaskedTextController textGuaraniesCosto = MoneyMaskedTextController(
      leftSymbol: 'G\$ ', precision: 0, decimalSeparator: '');
  MoneyMaskedTextController textDolaresCosto =
      MoneyMaskedTextController(leftSymbol: 'U\$ ');

  final int days = DateFormatBr()
      .getDaysBetweenDates(
          end: DateTime.now(), start: DateFormatBr().formatBrToUs(fecha))
      .length;
  int porcentaje = 0;

  if (days >= 30) {
    porcentaje = 3;
  }

  if (faltanteGuaranies != null) {
    textGuaraniesCosto.text =
        ((faltanteGuaranies * (porcentaje / 100)) + faltanteGuaranies)
            .toStringAsFixed(0);
  }
  if (faltanteDolares != null) {
    textDolaresCosto.text =
        ((faltanteDolares * (porcentaje / 100)) + faltanteDolares)
            .toStringAsFixed(2);
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

  List<Widget> atrasoRender(int days) {
    return <Widget>[
      CustomTitle('ATRASO'),
      CustomTitle(days.toString() + " - ${days == 1 ? 'dias' : 'dias'}",
          fontWeight: FontWeight.w500, fontSize: 15),
      CustomTitle('POCENTAJE DE ATRASO'),
      CustomTitle('$porcentaje %', fontWeight: FontWeight.w500, fontSize: 15),
    ];
  }

  bool isPending(faltanteGuaranies, faltanteDolares) {
    if (faltanteGuaranies != null) {
      if (faltanteGuaranies <= 0) {
        return false;
      } else {
        return true;
      }
    } else {
      if (faltanteDolares <= 0) {
        return false;
      } else {
        return true;
      }
    }
  }

  Widget dialogPlan(controller, fecha, faltanteGuaranies, faltanteDolares,
      pagoGuaranies, pagoDolares) {
    controller.changeInitialDateCuoteRefuerzo(fecha);
    return SingleChildScrollView(
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
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CustomTitle('FECHA ' + (isCuote ? 'CUOTA' : 'REFUERZO')),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: textInputContainer(
                          'fecha',
                          DateFormatBr().formatBrFromString(
                              controller.fechaCuotaRefuerzo.value.toString()),
                          onTap: () =>
                              controller.changeFechaCuotaRefuerzo(context),
                        ),
                      ),
                    ],
                  ),
                  ...atrasoRender(days),
                  CustomTitle(isCuote ? 'CUOTA' : 'REFUERZO'),
                  CustomTitle(
                      faltanteGuaranies != null
                          ? MoneyFormat().formatCommaToDot(faltanteGuaranies)
                          : MoneyFormat().formatCommaToDot(faltanteDolares,
                              isGuaranies: false),
                      fontWeight: FontWeight.w500,
                      fontSize: 15),
                  CustomTitle('FECHA DE PAGO'),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: textInputContainer(
                          'fecha',
                          DateFormatBr().formatBrFromString(
                              controller.fechaPago.value.toString()),
                          onTap: () => controller.changeFechaPago(context),
                        ),
                      ),
                    ],
                  ),
                  CustomTitle('TOTAL A PAGAR'),
                  CustomSpacing(height: 6),
                  CustomInput('', 'Total a pagar',
                      onChanged: (text) {
                        double valorPagar =
                            RemoveMoneyFormat().removeToDouble(text);
                        if (faltanteGuaranies != null) {
                          if (valorPagar > faltanteGuaranies) {
                            // textGuaraniesCosto.updateValue(
                            //     double.parse(faltanteGuaranies.toString()));
                          }
                          if (text.toString().length < 4) {
                            textGuaraniesCosto.updateValue(0);
                          }
                        } else {
                          if (valorPagar > faltanteDolares) {
                            // textDolaresCosto.updateValue(
                            //     double.parse(faltanteDolares.toString()));
                          }
                        }
                      },
                      isLoading: !isPending(faltanteGuaranies, faltanteDolares),
                      validator: (text) => validatorCuoteDinero(text),
                      textEditingController: faltanteGuaranies != null
                          ? textGuaraniesCosto
                          : textDolaresCosto)
                ],
              ),
      ),
    );
  }

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("PAGAR ${isCuote ? 'CUOTA' : 'REFUERZO'}"),
    content: dialogPlan(controller, fecha, faltanteGuaranies, faltanteDolares,
        pagoGuaranies, pagoDolares),
    actions: [
      Obx(() => controller.isLoadingRequest.value
          ? const SizedBox()
          : isPending(faltanteGuaranies, faltanteDolares)
              ? Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                )
              : Container())
    ],
  );

  // show the dialog
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );

  return Get.defaultDialog(
      title: 'PAGAR ${isCuote ? 'CUOTA' : 'REFUERZO'}',
      content: dialogPlan(controller, fecha, faltanteGuaranies, faltanteDolares,
          pagoGuaranies, pagoDolares),
      actions: [
        Obx(() => controller.isLoadingRequest.value
            ? const SizedBox()
            : Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
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
              ))
      ]);
}
