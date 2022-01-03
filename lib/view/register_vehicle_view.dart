import 'dart:async';

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
                    CustomSearch(
                        controller.textBrandController,
                        (context, suggestion) => ListTile(
                              title: Text(suggestion.marca),
                            ),
                        (pattern) async => controller.listBrand
                            .where((item) => item.marca
                                .toUpperCase()
                                .contains(pattern.toUpperCase()))
                            .toList(),
                        (suggestion) => controller.textBrandController.text =
                            suggestion.marca,
                        'Marca'),
                    CustomSearch(
                        controller.textModelController,
                            (context, suggestion) => ListTile(
                          title: Text(suggestion.modelo),
                        ),
                            (pattern) async => controller.listModel
                            .where((item) => item.modelo
                            .toUpperCase()
                            .contains(pattern.toUpperCase()))
                            .toList(),
                            (suggestion) => controller.textModelController.text =
                            suggestion.modelo,
                        'Modelo'),

                    CustomSearch(
                        controller.textFuelController,
                            (context, suggestion) => ListTile(
                          title: Text(suggestion.combustible),
                        ),
                            (pattern) async => controller.listFuel
                            .where((item) => item.combustible
                            .toUpperCase()
                            .contains(pattern.toUpperCase()))
                            .toList(),
                            (suggestion) => controller.textFuelController.text =
                            suggestion.combustible,
                        'Tipo combustible'),

                    CustomSearch(
                        controller.textColorController,
                            (context, suggestion) => ListTile(
                          title: Text(suggestion.color),
                        ),
                            (pattern) async => controller.listColor
                            .where((item) => item.color
                            .toUpperCase()
                            .contains(pattern.toUpperCase()))
                            .toList(),
                            (suggestion) => controller.textColorController.text =
                            suggestion.color,
                        'Color'),

                    CustomSearch(
                        controller.textMotorController,
                            (context, suggestion) => ListTile(
                          title: Text(suggestion.motor),
                        ),
                            (pattern) async => controller.listMotor
                            .where((item) => item.motor
                            .toUpperCase()
                            .contains(pattern.toUpperCase()))
                            .toList(),
                            (suggestion) => controller.textMotorController.text =
                            suggestion.motor,
                        'Motor'),


                    CustomInput('', 'Ano', Icons.calendar_today,
                        onSaved: (text) =>
                            controller.registerClientModel?.celular = text,
                        isLoading: controller.isLoading.value,
                        validator: validatorTreeCaracteressAndNull,
                        isPhone: true),

                    CustomInput('', 'Tipo de cambio', Icons.format_list_numbered,
                        onSaved: (text) =>
                            controller.registerClientModel?.celular = text,
                        isLoading: controller.isLoading.value,
                        validator: validatorTreeCaracteressAndNull,
                        isPhone: true),
                    CustomInput('', 'Numero de chapa', Icons.confirmation_num_outlined,
                        onSaved: (text) =>
                            controller.registerClientModel?.celular = text,
                        isLoading: controller.isLoading.value,
                        validator: validatorTreeCaracteressAndNull,
                        isPhone: true),
                    CustomInput('', 'Numero de chassis', Icons.confirmation_num_outlined,
                        onSaved: (text) =>
                            controller.registerClientModel?.celular = text,
                        isLoading: controller.isLoading.value,
                        validator: validatorTreeCaracteressAndNull,
                        isPhone: true),
                    CustomInput(
                        '', 'Costo vehiculo guaranies', Icons.price_change_outlined,
                        onSaved: (text) =>
                            controller.registerClientModel?.celular = text,
                        isLoading: controller.isLoading.value,
                        validator: validatorTreeCaracteressAndNull,
                        isPhone: true),
                    CustomInput(
                        '', 'Costo vehiculo dolares', Icons.price_change_outlined,
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

Widget CustomSearch(
    TextEditingController textEditingController,
    Function buildContext,
    FutureOr<Iterable<dynamic>> Function(String) suggestionCallback,
    Function onSuggestionSelected,
    String labelText) {
  return TypeAheadFormField<dynamic>(
    itemBuilder: (context, sugge) => buildContext(BuildContext, sugge),
    validator: (value) => value!.isEmpty ? 'Selecionar una marca' : null,
// onSaved: (value) => this._selectedCity = value,
    textFieldConfiguration: TextFieldConfiguration(
      controller: textEditingController,
      decoration: InputDecoration(
        labelText: labelText,
        suffixIcon: IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () async {
            textEditingController.text = '';
          },
        ),
      ),
    ),
    suggestionsCallback: (pattern) async {
      return suggestionCallback(pattern);
    },
    onSuggestionSelected: (suggestion) => onSuggestionSelected(suggestion),
  );
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
