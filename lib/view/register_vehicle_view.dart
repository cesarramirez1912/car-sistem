import 'package:car_system/colors.dart';
import 'package:car_system/common/money_format.dart';
import 'package:car_system/controllers/client_controller.dart';
import 'package:car_system/controllers/essencial_vehicle_controller.dart';
import 'package:car_system/models/essencial_vehicle_models/brand.dart';
import 'package:car_system/widgets/button.dart';
import 'package:car_system/widgets/input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';

class RegisterVehicleView extends GetView<EssencialVehicleController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrar Vehiculo'),
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
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: TypeAheadFormField<Brand>(
                        itemBuilder: (context, suggestion) {
                          return ListTile(
                            leading: Icon(Icons.shopping_cart),
                            title: Text(suggestion.marca),
                            subtitle: Text('\$${suggestion.marca}'),
                          );
                        },
                        textFieldConfiguration: TextFieldConfiguration(
                          controller: controller.typeAheadController,
                          decoration: InputDecoration(
                            labelText: 'Buscar cliente',
                            suffixIcon: IconButton(
                              icon: Icon(Icons.clear),
                              onPressed: () async {
                                print('clean');
                              },
                            ),
                          ),
                        ),
                        suggestionsCallback: (pattern) async {
                          print(pattern);
                          return controller.listBrand
                              .where((item) => item.marca.toUpperCase()
                                  .contains(pattern.toUpperCase()))
                              .toList();
                        },
                        onSuggestionSelected: (Object? suggestion) {
                          print(suggestion);
                        },
                      ),
                    ),
                    CustomInput('', 'Marca', Icons.perm_identity,
                        onSaved: (text) =>
                            controller.registerClientModel?.cliente = text,
                        isLoading: controller.isLoading.value,
                        validator: validatorTreeCaracteressAndNull),
                    CustomInput('', 'Modelo', Icons.wysiwyg,
                        onSaved: (text) =>
                            controller.registerClientModel?.ci = text,
                        isLoading: controller.isLoading.value,
                        validator: validatorTreeCaracteressAndNull,
                        isNumber: true),
                    CustomInput(
                        '', 'Tipo combustible', Icons.location_city_outlined,
                        onSaved: (text) =>
                            controller.registerClientModel?.ciudad = text,
                        isLoading: controller.isLoading.value,
                        validator: validatorTreeCaracteressAndNull),
                    CustomInput('', 'Color', Icons.location_city_outlined,
                        onSaved: (text) =>
                            controller.registerClientModel?.direccion = text,
                        isLoading: controller.isLoading.value),
                    CustomInput('', 'Motor', Icons.phone_android,
                        onSaved: (text) =>
                            controller.registerClientModel?.celular = text,
                        isLoading: controller.isLoading.value,
                        validator: validatorTreeCaracteressAndNull,
                        isPhone: true),
                    CustomInput('', 'Ano', Icons.phone_android,
                        onSaved: (text) =>
                            controller.registerClientModel?.celular = text,
                        isLoading: controller.isLoading.value,
                        validator: validatorTreeCaracteressAndNull,
                        isPhone: true),
                    CustomInput('', 'Tipo de cambio', Icons.phone_android,
                        onSaved: (text) =>
                            controller.registerClientModel?.celular = text,
                        isLoading: controller.isLoading.value,
                        validator: validatorTreeCaracteressAndNull,
                        isPhone: true),
                    CustomInput('', 'Numero de chapa', Icons.phone_android,
                        onSaved: (text) =>
                            controller.registerClientModel?.celular = text,
                        isLoading: controller.isLoading.value,
                        validator: validatorTreeCaracteressAndNull,
                        isPhone: true),
                    CustomInput('', 'Numero de chassis', Icons.phone_android,
                        onSaved: (text) =>
                            controller.registerClientModel?.celular = text,
                        isLoading: controller.isLoading.value,
                        validator: validatorTreeCaracteressAndNull,
                        isPhone: true),
                    CustomInput(
                        '', 'Costo vehiculo guaranies', Icons.phone_android,
                        onSaved: (text) =>
                            controller.registerClientModel?.celular = text,
                        isLoading: controller.isLoading.value,
                        validator: validatorTreeCaracteressAndNull,
                        isPhone: true),
                    CustomInput(
                        '', 'Costo vehiculo dolares', Icons.phone_android,
                        onSaved: (text) =>
                            controller.registerClientModel?.celular = text,
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
                        CustomButton('REGISTRAR', controller.registerVehicle,
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

Widget inputCuote(String labelText, String labelText2) {
  return Row(
    children: [
      SizedBox(
        width: labelText != '' ? 40 : 30,
      ),
      labelText != ''
          ? Flexible(
              flex: 1,
              child: TextFormField(
                autovalidateMode: AutovalidateMode.always,
                decoration: InputDecoration(
                  labelText: labelText,
                ),
              ),
            )
          : Container(),
      SizedBox(
        width: 10,
      ),
      Flexible(
        flex: 3,
        child: TextFormField(
          autovalidateMode: AutovalidateMode.always,
          decoration: InputDecoration(
            labelText: labelText2,
          ),
        ),
      )
    ],
  );
}
