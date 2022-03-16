import 'package:car_system/app/modules/client/client_controller.dart';
import '../../../global_widgets/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/colors.dart';
import '../../../global_widgets/button.dart';
import '../../../global_widgets/input.dart';
import '../../../global_widgets/spacing.dart';


class RegisterClientView extends GetView<ClientController> {
  @override
  Widget build(BuildContext context) {
    return Responsive(
      mobile: principal(),
      tablet: Center(
        child: Container(
            alignment: Alignment.center,
            width: 900,
            child: principal()),
      ),
      desktop: Center(
        child: Container(
            alignment: Alignment.center,
            width: 900,
            child: principal()),
      ),
    );
  }

  Widget principal() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrar Cliente'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Form(
            key: controller.formKey,
            child: Obx(
              () => Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomSpacing(),
                  CustomInput('', 'Nombre completo',
                      iconData: Icons.person_outline,
                      onSaved: (text) => controller.clientModel?.cliente = text,
                      isLoading: controller.isLoading.value,
                      validator: validatorTreeCaracteressAndNull),
                  CustomInput('', 'CI',
                      iconData: Icons.badge_outlined,
                      textEditingController: controller.textCiController,
                      onSaved: (text) => controller.clientModel?.ci = text,
                      isLoading: controller.isLoading.value,
                      validator: validatorTreeCaracteressAndNull,
                      isNumber: true),
                  CustomInput('', 'Ciudad',
                      iconData: Icons.location_city_outlined,
                      onSaved: (text) => controller.clientModel?.ciudad = text,
                      isLoading: controller.isLoading.value,
                      validator: validatorTreeCaracteressAndNull),
                  CustomInput('', 'Dirección',
                      iconData: Icons.location_city_outlined,
                      onSaved: (text) =>
                          controller.clientModel?.direccion = text,
                      isLoading: controller.isLoading.value),
                  CustomInput('', 'Celular',
                      iconData: Icons.phone_android_outlined,
                      textEditingController: controller.textPhoneController,
                      onSaved: (text) => controller.clientModel?.celular = text,
                      isLoading: controller.isLoading.value,
                      validator: validatorTreeCaracteressAndNull,
                      isPhone: true),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomButton('REGISTRAR', controller.registerClient,
                          ColorPalette.GREEN,
                          isLoading: controller.isLoading.value),
                      const SizedBox(
                        width: 10,
                      ),
                      CustomButton(
                          'CANCELAR', () => Get.back(), ColorPalette.PRIMARY,
                          isLoading: controller.isLoading.value),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

String? validatorTreeCaracteressAndNull(String text) {
  if (text.isEmpty) {
    return 'Campo obligatorio.';
  } else if (text.length < 3) {
    return 'Campo debe de contener minimo 3 caracteres.';
  }
  return null;
}
