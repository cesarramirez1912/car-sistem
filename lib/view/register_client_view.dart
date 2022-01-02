import 'package:car_system/colors.dart';
import 'package:car_system/common/money_format.dart';
import 'package:car_system/controllers/client_controller.dart';
import 'package:car_system/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterClientView extends GetView<ClientController> {
  @override
  Widget build(BuildContext context) {
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
                    inputField('', 'Nombre', Icons.perm_identity,
                        onSaved: (text) =>
                            controller.registerClientModel?.cliente = text,
                        isLoading: controller.isLoading.value,
                        validator: validatorTreeCaracteressAndNull),
                    inputField('', 'CI', Icons.wysiwyg,
                        onSaved: (text) =>
                            controller.registerClientModel?.ci = text,
                        isLoading: controller.isLoading.value,
                        validator: validatorTreeCaracteressAndNull,isNumber: true),
                    inputField('', 'Ciudad', Icons.location_city_outlined,
                        onSaved: (text) =>
                            controller.registerClientModel?.ciudad = text,
                        isLoading: controller.isLoading.value,
                        validator: validatorTreeCaracteressAndNull),
                    inputField('', 'Dirección', Icons.location_city_outlined,
                        onSaved: (text) =>
                            controller.registerClientModel?.direccion = text,
                        isLoading: controller.isLoading.value),
                    inputField('', 'Celular', Icons.phone_android,
                        onSaved: (text) =>
                            controller.registerClientModel?.celular = text,
                        isLoading: controller.isLoading.value,
                        validator: validatorTreeCaracteressAndNull,isPhone: true),
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
          )),
    );
  }
}

String? validatorTreeCaracteressAndNull(String text) {
  if (text.isEmpty || text == null) {
    return 'Campo obligatorio.';
  } else if (text.length < 3) {
    return 'Campo debe de contener minimo 3 caracteres.';
  }
  return null;
}

Widget inputField(String? hintText, String? labelText, IconData iconData,
    {Function? onSaved,
    Function? validator,
    bool isLoading = false,
    bool isNumber = false,
    bool isPhone = false}) {
  return TextFormField(
    textCapitalization: TextCapitalization.sentences,
    onSaved: (text) => onSaved?.call(text),
    validator: (value) => validator?.call(value),
    enabled: isLoading ? false : true,
    keyboardType: isNumber
        ? TextInputType.number
        : isPhone
            ? TextInputType.phone
            : TextInputType.text,
    autovalidateMode: AutovalidateMode.always,
    decoration: InputDecoration(
      icon: Icon(iconData),
      hintText: hintText,
      labelText: labelText,
    ),
  );
}
