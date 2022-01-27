import 'package:car_system/colors.dart';
import 'package:car_system/repositories/essencial_vehicle_repository.dart';
import 'package:car_system/rest.dart';
import 'package:car_system/widgets/button.dart';
import 'package:car_system/widgets/input.dart';
import 'package:car_system/widgets/input_login.dart';
import 'package:car_system/widgets/search_dropdown.dart';
import 'package:car_system/widgets/snack_bars/snack_bar_error.dart';
import 'package:car_system/widgets/snack_bars/snack_bar_success.dart';
import 'package:car_system/widgets/spacing.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterEssencialView extends StatelessWidget {
  RegisterEssencialController registerEssencialController =
      Get.put(RegisterEssencialController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registros'),
      ),
      body: Obx(
        () => Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Form(
            key: registerEssencialController.formKey,
            child: Column(
              children: [
                CustomSpacing(),
                CustomDropDowSearch(registerEssencialController.listInformation,
                    'Selecionar informacion',
                    onSaved: (text) =>
                        registerEssencialController.text.value = text,
                    isRequired: true),
                CustomSpacing(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                        child: CustomInput('Tipear dato', 'Nuevo dato',
                            textEditingController:
                                registerEssencialController.textEditNuevoDato)),
                    Container(
                      padding: const EdgeInsets.only(bottom: 16, left: 5),
                      child: CustomButton('', () {
                        if (registerEssencialController
                            .textEditNuevoDato.text.isNotEmpty) {
                          registerEssencialController.listValues.add(
                              registerEssencialController
                                  .textEditNuevoDato.text);
                          registerEssencialController.textEditNuevoDato.clear();
                        }
                      }, ColorPalette.SECUNDARY, iconData: Icons.add),
                    )
                  ],
                ),
                CustomSpacing(),
                Expanded(
                  child: ListView.builder(
                    itemCount:
                        registerEssencialController.listValues.value.length,
                    itemBuilder: (context, index) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(registerEssencialController.listValues[index]),
                          IconButton(
                            icon: const Icon(
                              Icons.remove,
                              color: Colors.red,
                            ),
                            onPressed: () => registerEssencialController
                                .listValues
                                .removeAt(index),
                          )
                        ],
                      );
                    },
                  ),
                ),
                CustomButton(
                    'REGISTRAR NUEVOS DATOS',
                    () async => await registerEssencialController
                        .openAndCloseLoadingDialog(),
                    ColorPalette.GREEN)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RegisterEssencialController extends GetxController {
  EssencialVehicleRepository essencialVehicleRepository =
      EssencialVehicleRepository();

  TextEditingController textEditNuevoDato = TextEditingController();

  List<String> listInformation = [
    'MARCAS',
    'MODELOS',
    'COMBUSTIBLES',
    'COLORES',
    'MOTORES',
    'CAMBIOS'
  ];

  RxList<String> listValues = <String>[].obs;
  final formKey = GlobalKey<FormState>();

  RxString text = ''.obs;

  Future<bool> verifyInformation() async {
    if (formKey.currentState == null) {
      return false;
    } else if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      if (listValues.isEmpty) {
        CustomSnackBarError('Agrega nuevo dato para poder enviar.');
        return false;
      } else {
        return true;
      }
    } else {
      return false;
    }
  }

  Future<String> sendInformations() async {
    var url = '';
    switch (text.value) {
      case 'MARCAS':
        url = Rest.BRANDS + '/brand=';
        break;
      case 'MODELOS':
        url = Rest.MODELS;
        break;
      case 'COMBUSTIBLES':
        url = Rest.FUELS + '/fuel=';
        break;
      case 'COLORES':
        url = Rest.COLORS + '/color=';
        break;
      case 'MOTORES':
        url = Rest.MOTORS + '/motor=';
        break;
      case 'CAMBIOS':
        url = Rest.GEARS + '/gear=';
        break;
    }
    var listAux = [...listValues.value];
    for (var st in listAux) {
      var responseee =
          await essencialVehicleRepository.postInformations(url + st.toUpperCase());
      if (responseee == 'ok') {
        listValues.removeWhere((element) => element == st);
      }
    }
    return 'ok';
  }

  Future<void> openAndCloseLoadingDialog() async {
    Get.dialog(
      Center(
        child: Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 5),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Padding(
                  padding:
                      EdgeInsets.only(top: 15, bottom: 30, left: 8, right: 8),
                  child: CircularProgressIndicator(),
                ),
                Flexible(
                  child: Text(
                    'Registrando aguarde...',
                    style: TextStyle(fontSize: 16),
                    overflow: TextOverflow.clip,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      barrierDismissible: false,
    );
    bool res = await verifyInformation();
    if (res) {
      var resss = await sendInformations();
      print(resss);
      CustomSnackBarSuccess('Registrado todos los datos');
    }

    Get.back();
  }
}
