import 'package:car_system/colors.dart';
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
          child: Form(
            key: controller.formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                inputField('', 'Nombre', Icons.perm_identity,
                    onSaved: (tes) => print(tes)),
                inputField('', 'CI', Icons.wysiwyg),
                inputField('', 'Ciudad', Icons.location_city_outlined),
                inputField('', 'Direccion', Icons.location_city_outlined),
                inputField('', 'Celular', Icons.phone_android),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomButton('REGISTRAR', controller.registerClient,
                        ColorPalette.GREEN),
                    const SizedBox(
                      width: 10,
                    ),
                    CustomButton(
                        'CANCELAR', () => Get.back(), ColorPalette.PRIMARY),
                  ],
                )
              ],
            ),
          )),
    );
  }
}

Widget inputField(String? hintText, String? labelText, IconData iconData,
    {Function? onSaved}) {
  return TextFormField(
    onSaved: (text) => onSaved!(text),
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Pass Empty';
      }
      return null;
    },
    autovalidateMode: AutovalidateMode.always,
    decoration: InputDecoration(
      icon: Icon(iconData),
      hintText: hintText,
      labelText: labelText,
    ),
  );
}
