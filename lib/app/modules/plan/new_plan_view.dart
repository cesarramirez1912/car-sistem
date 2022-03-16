import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/utils/remove_money_format.dart';
import '../../global_widgets/input.dart';
import '../../global_widgets/spacing.dart';
import '../../global_widgets/title.dart';
import '../register_vehicle/essencial_vehicle_controller.dart';

class NewPlanView extends StatelessWidget {
  EssencialVehicleController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nuevo plan'),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
          child: Form(
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
                      controller.cuota.value.cantidadCuotas = text,
                  validator: (String text) {
                    if (text.isEmpty) {
                      return 'Campo obligatorio.';
                    } else {
                      if (double.parse(text.toString()) == 0.0) {
                        return 'Cantidad debe de ser minimo 1';
                      }
                    }
                  },
                  onChanged: controller.sumTotal,
                  textEditingController: controller.textCantidadCuotas,
                ),
                CustomInput('', 'Cantidad refuerzos',
                    onChanged: controller.sumTotal,
                    validator: validatorRefuerzo,
                    isNumber: true, onSaved: (text) {
                  if (text == '') {
                    controller.cuota.value.cantidadRefuerzo = null;
                  } else {
                    controller.cuota.value.cantidadRefuerzo = text;
                  }
                }, textEditingController: controller.textCantidadRefuerzos),
                CustomTitle('Plan guaraníes'),
                CustomSpacing(),
                CustomInput(
                  '',
                  'Entrada',
                  isNumber: true,
                  iconData: Icons.price_change_outlined,
                  textEditingController: controller.textEntradaGuaranies,
                  onChanged: (text) {
                    if (text.toString().length < 4) {
                      controller.textEntradaGuaranies.updateValue(0);
                    }
                  },
                  onSaved: (text) =>
                      controller.cuota.value.entradaGuaranies = text,
                ),
                CustomInput(
                  '',
                  'Cuota',
                  isNumber: true,
                  validator: validatorCuoteDinero,
                  iconData: Icons.price_change_outlined,
                  textEditingController: controller.textCuotaGuaranies,
                  onSaved: (text) =>
                      controller.cuota.value.cuotaGuaranies = text,
                  onChanged: (text) {
                    if (text.toString().length < 4) {
                      controller.textCuotaGuaranies.updateValue(0);
                    }
                  },
                ),
                CustomInput(
                  '',
                  'Refuerzo',
                  isNumber: true,
                  iconData: Icons.price_change_outlined,
                  validator: validatorRefuerzoDinero,
                  onChanged: (text) {
                    if (text.toString().length < 4) {
                      controller.textRefuezoGuaranies.updateValue(0);
                    }
                  },
                  onSaved: (text) =>
                      controller.cuota.value.refuerzoGuaranies = text,
                  textEditingController: controller.textRefuezoGuaranies,
                ),
                CustomTitle('Plan dólares'),
                CustomSpacing(),
                CustomInput('', 'Entrada',
                    isNumber: true,
                    iconData: Icons.price_change_outlined,
                    onSaved: (text) =>
                        controller.cuota.value.entradaDolares = text,
                    textEditingController: controller.textEntradaDolares),
                CustomInput('', 'Cuota',
                    isNumber: true,
                    iconData: Icons.price_change_outlined,
                    validator: validatorCuoteDinero,
                    onSaved: (text) =>
                        controller.cuota.value.cuotaDolares = text,
                    textEditingController: controller.textCuotaDolares),
                CustomInput('', 'Refuerzo',
                    isNumber: true,
                    validator: validatorRefuerzoDinero,
                    iconData: Icons.price_change_outlined,
                    onSaved: (text) =>
                        controller.cuota.value.refuerzoDolares = text,
                    textEditingController: controller.textRefuezoDolares),
                CustomSpacing(),
                Obx(() => Text(controller.textTotalGuaraniesString.value.toString()))
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? validatorCuoteDinero(String text) {
    double cuotaGuaraniesDouble =
        RemoveMoneyFormat().removeToDouble(controller.textCuotaGuaranies.text);
    double cuotaDolaresDouble =
        RemoveMoneyFormat().removeToDouble(controller.textCuotaDolares.text);

    if (controller.textCantidadCuotas.value.text.isNotEmpty) {
      if (cuotaGuaraniesDouble > 0.0) {
        return null;
      }
      if (cuotaGuaraniesDouble == 0.0 && cuotaDolaresDouble < 1) {
        return 'Campo obligatorio.';
      }
      return null;
    } else {
      return 'Campo obligatorio.';
    }
  }

  String? validatorRefuerzoDinero(String text) {
    double refuerzoGuaraniesDouble = RemoveMoneyFormat()
        .removeToDouble(controller.textRefuezoGuaranies.text);
    double refuerzoDolaresDouble =
        RemoveMoneyFormat().removeToDouble(controller.textRefuezoDolares.text);
    if (controller.textCantidadRefuerzos.text.isEmpty) {
      return null;
    } else {
      if (refuerzoGuaraniesDouble == 0.0 && refuerzoDolaresDouble < 1) {
        return 'Campo obligatorio.';
      } else {
        return null;
      }
    }
  }

  String? validatorRefuerzo(String text) {
    double refuerzoGuaraniesDouble = RemoveMoneyFormat()
        .removeToDouble(controller.textRefuezoGuaranies.text);
    double refuerzoDolarDouble =
        RemoveMoneyFormat().removeToDouble(controller.textRefuezoDolares.text);
    if (text.isEmpty) {
      if (refuerzoGuaraniesDouble > 0) {
        return 'Obligatorio (Refuerzo G\$).';
      } else if (refuerzoDolarDouble > 0.0) {
        return 'Obligatorio (Refuerzo U\$).';
      } else {
        return null;
      }
    } else {
      if (double.parse(text.toString()) == 0.0) {
        return 'Cantidad debe de ser minimo 1';
      } else {
        return null;
      }
    }
  }
}
