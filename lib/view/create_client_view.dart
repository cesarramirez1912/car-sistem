import 'package:car_system/controllers/client_controller.dart';
import 'package:car_system/route_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterClientView extends GetView<ClientController> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Catastro Cliente'),
        ),
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                inputField('','Nombre completo',Icons.perm_identity),
                inputField('','CI',Icons.wysiwyg),
                inputField('','Ciudad',Icons.location_city_outlined),
                inputField('','Barrio',Icons.location_city_outlined),
                inputField('','Direccion',Icons.location_city_outlined),
                inputField('','Celular',Icons.phone_android),
                inputField('','Profesion',Icons.work_outline),
                SizedBox(height: 20,),
                Row(
                  children: [   ElevatedButton(
                    child: const Text('Guardar'),
                    onPressed: () =>Get.toNamed(RouterManager.LOGIN),
                    style:  ElevatedButton.styleFrom(
                        primary: Colors.green,
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        textStyle: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold)),
                  ),
                    SizedBox(width: 10,),
                    ElevatedButton(
                      child: const Text('Cancelar'),
                      onPressed: () {},
                      style:  ElevatedButton.styleFrom(
                          primary: Colors.red,
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                          textStyle: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold)),
                    ),],
                )

              ],
            )
    ),);
  }
}

Widget inputField(String? hintText,String? labelText,IconData iconData) {
  return TextFormField(
    autovalidateMode: AutovalidateMode.always,
    decoration: InputDecoration(
      icon:  Icon(iconData),
      hintText: hintText,
      labelText: labelText,
    ),
  );
}

