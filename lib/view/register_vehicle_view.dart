import 'dart:async';

import 'package:car_system/colors.dart';
import 'package:car_system/common/money_format.dart';
import 'package:car_system/controllers/client_controller.dart';
import 'package:car_system/controllers/essencial_vehicle_controller.dart';
import 'package:car_system/models/essencial_vehicle_models/brand.dart';
import 'package:car_system/models/essencial_vehicle_models/model.dart';
import 'package:car_system/widgets/button.dart';
import 'package:car_system/widgets/input.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';

class RegisterVehicleView extends GetView<EssencialVehicleController> {
  String? selectedCity;
  String? selectedFood;

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
                    buildCity(controller),
                    buildFood(controller),
                    // CustomAutoComplete(
                    //   (option) => option.marca,
                    //   'marca',
                    //   (textEditingValue) {
                    //     if (textEditingValue.text == '') {
                    //       return const Iterable<Brand>.empty();
                    //     }
                    //     return controller.listBrand.where((Brand option) {
                    //       return option.marca
                    //           .toUpperCase()
                    //           .contains(textEditingValue.text.toUpperCase());
                    //     });
                    //   },
                    // ),
                    // CustomSearch(
                    //     controller.textBrandController,
                    //     (Brand option) => option.marca,
                    //     (pattern) async => controller.listBrand
                    //         .where((item) => item.marca
                    //             .toUpperCase()
                    //             .contains(pattern.toUpperCase()))
                    //         .toList(),
                    //     (suggestion) => controller.textBrandController.text =
                    //         suggestion.marca,
                    //     'Marca',
                    //     onSaved: (value) =>
                    //         controller.createVehicle.value.marca = value),
                    //
                    // CustomSearch(
                    //     controller.textModelController,
                    //     (Model option) => option.modelo,
                    //     (pattern) async => controller.listModel
                    //         .where((item) => item.modelo
                    //             .toUpperCase()
                    //             .contains(pattern.toUpperCase()))
                    //         .toList(),
                    //     (suggestion) => controller.textModelController.text =
                    //         suggestion.modelo,
                    //     'Modelo',
                    //     onSaved: (value) =>
                    //         controller.createVehicle.value.modelo = value),

                    // CustomSearch(
                    //     controller.textFuelController,
                    //     (context, suggestion) => ListTile(
                    //           title: Text(suggestion.combustible),
                    //         ),
                    //     (pattern) async => controller.listFuel
                    //         .where((item) => item.combustible
                    //             .toUpperCase()
                    //             .contains(pattern.toUpperCase()))
                    //         .toList(),
                    //     (suggestion) => controller.textFuelController.text =
                    //         suggestion.combustible,
                    //     'Tipo combustible',
                    //     onSaved: (value) =>
                    //         controller.createVehicle.value.combustible = value),
                    // CustomSearch(
                    //     controller.textColorController,
                    //     (context, suggestion) => ListTile(
                    //           title: Text(suggestion.color),
                    //         ),
                    //     (pattern) async => controller.listColor
                    //         .where((item) => item.color
                    //             .toUpperCase()
                    //             .contains(pattern.toUpperCase()))
                    //         .toList(),
                    //     (suggestion) => controller.textColorController.text =
                    //         suggestion.color,
                    //     'Color',
                    //     onSaved: (value) =>
                    //         controller.createVehicle.value.color = value),
                    // CustomSearch(
                    //     controller.textMotorController,
                    //     (context, suggestion) => ListTile(
                    //           title: Text(suggestion.motor),
                    //         ),
                    //     (pattern) async => controller.listMotor
                    //         .where((item) => item.motor
                    //             .toUpperCase()
                    //             .contains(pattern.toUpperCase()))
                    //         .toList(),
                    //     (suggestion) => controller.textMotorController.text =
                    //         suggestion.motor,
                    //     'Motor',
                    //     onSaved: (value) =>
                    //         controller.createVehicle.value.motor = value),
                    CustomInput('', 'Ano', Icons.calendar_today,
                        onSaved: (text) =>
                            controller.createVehicle.value.ano = text,
                        isLoading: controller.isLoading.value,
                        validator: validatorTreeCaracteressAndNull,
                        isPhone: true),
                    CustomInput(
                        '', 'Tipo de cambio', Icons.format_list_numbered,
                        onSaved: (text) =>
                            controller.createVehicle.value.cambio = text,
                        isLoading: controller.isLoading.value,
                        validator: validatorTreeCaracteressAndNull,
                        isPhone: true),
                    CustomInput(
                        '', 'Numero de chapa', Icons.confirmation_num_outlined,
                        onSaved: (text) =>
                            controller.createVehicle.value.chapa = text,
                        isLoading: controller.isLoading.value,
                        validator: validatorTreeCaracteressAndNull,
                        isPhone: true),
                    CustomInput('', 'Numero de chassis',
                        Icons.confirmation_num_outlined,
                        onSaved: (text) =>
                            controller.createVehicle.value.chassis = text,
                        isLoading: controller.isLoading.value,
                        validator: validatorTreeCaracteressAndNull,
                        isPhone: true),
                    CustomInput('', 'Costo vehiculo guaranies',
                        Icons.price_change_outlined,
                        onSaved: (text) => controller
                            .createVehicle.value.costoGuaranies = text,
                        isLoading: controller.isLoading.value,
                        validator: validatorTreeCaracteressAndNull,
                        isPhone: true),
                    CustomInput('', 'Costo vehiculo dolares',
                        Icons.price_change_outlined,
                        onSaved: (text) =>
                            controller.createVehicle.value.costoDolares = text,
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

  Widget buildCity(EssencialVehicleController controller) =>
      Container(
        child: TypeAheadFormField<String?>(
          textFieldConfiguration: TextFieldConfiguration(
            controller: controller.textBrandController,
            decoration: InputDecoration(
              labelText: 'City',
              border: OutlineInputBorder(),
            ),
          ),
          suggestionsCallback: CityData.getSuggestions,
          itemBuilder: (context, String? suggestion) => ListTile(
            title: Text(suggestion!),
          ),
          onSuggestionSelected: (String? suggestion) =>
              controller.textBrandController.text = suggestion!,
          validator: (value) =>
              value != null && value.isEmpty ? 'Please select a city' : null,
          onSaved: (value) => selectedCity = value,
        ),
      );

  Widget buildFood(EssencialVehicleController controller) =>
      TypeAheadFormField<String?>(
        textFieldConfiguration: TextFieldConfiguration(
          controller: controller.textModelController,
          decoration: InputDecoration(
            labelText: 'Food',
            border: OutlineInputBorder(),
          ),
        ),
        suggestionsCallback: FoodData.getSuggestions,
        itemBuilder: (context, String? suggestion) => ListTile(
          title: Text(suggestion!),
        ),
        onSuggestionSelected: (String? suggestion) =>
            controller.textModelController.text = suggestion!,
        validator: (value) =>
            value != null && value.isEmpty ? 'Please select a food' : null,
        onSaved: (value) => selectedFood = value,
      );
}

// Widget CustomAutoComplete(
//     String Function(dynamic) displayStringForOption,
//     String tes,
//     FutureOr<Iterable<Object>> Function(TextEditingValue) optionsBuilder) {
//   return RawAutocomplete(
//     optionsViewBuilder: (context, fun, obj) {
//       return ListTile(
//         title: Text(obj),
//       );
//     },
//     displayStringForOption: displayStringForOption,
//     optionsBuilder: (TextEditingValue textEditingValue) =>
//         optionsBuilder(textEditingValue),
//   );
// }

Widget CustomSearchTeste(EssencialVehicleController controller) {
  return TypeAheadFormField<Model>(
    itemBuilder: (context, value) => Text(value.modelo),
    validator: (value) => value!.isEmpty ? 'nao pode ser vazio' : null,
    onSaved: (value) => controller.textModelController.text = value!,
    textFieldConfiguration: TextFieldConfiguration(
      focusNode: controller.myFocusNode,
      controller: controller.textModelController,
      decoration: InputDecoration(
        labelText: 'Modelo',
        suffixIcon: IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () => controller.textModelController.text = '',
        ),
      ),
    ),
    suggestionsCallback: (pattern) async => controller.listModel
        .where(
            (item) => item.modelo.toUpperCase().contains(pattern.toUpperCase()))
        .toList(),
    onSuggestionSelected: (suggestion) =>
        controller.textModelController.text = suggestion.modelo,
  );
}

Widget CustomSearchTeste2(EssencialVehicleController controller) {
  return TypeAheadFormField<Brand>(
    itemBuilder: (context, value) => Text(value.marca),
    validator: (value) => value!.isEmpty ? 'nao pode ser vazio' : null,
    onSaved: (value) => controller.textBrandController.text = value!,
    textFieldConfiguration: TextFieldConfiguration(
      controller: controller.textBrandController,
      focusNode: controller.myFocusNode2,
      decoration: InputDecoration(
        labelText: 'MARCA',
        suffixIcon: IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () => controller.textBrandController.text = '',
        ),
      ),
    ),
    suggestionsCallback: (pattern) async => controller.listBrand
        .where(
            (item) => item.marca.toUpperCase().contains(pattern.toUpperCase()))
        .toList(),
    onSuggestionSelected: (suggestion) =>
        controller.textBrandController.text = suggestion.marca,
  );
}

Widget CustomSearch(
    TextEditingController textEditingController,
    Function itemBuilder,
    FutureOr<Iterable<dynamic>> Function(String) suggestionCallback,
    Function onSuggestionSelected,
    String labelText,
    {Function? onSaved}) {
  return TypeAheadFormField<dynamic>(
    itemBuilder: (context, value) => ListTile(
      title: Text(itemBuilder(value)),
    ),
    validator: (value) => value!.isEmpty ? 'nao pode ser vazio' : null,
    onSaved: (value) => onSaved != null ? onSaved(value) : null,
    textFieldConfiguration: TextFieldConfiguration(
      controller: textEditingController,
      decoration: InputDecoration(
        labelText: labelText,
        suffixIcon: IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () => textEditingController.text = '',
        ),
      ),
    ),
    suggestionsCallback: (pattern) async => suggestionCallback(pattern),
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

class CityData {
  static final faker = Faker();

  static final List<String> cities =
      List.generate(20, (index) => faker.address.city());

  static List<String> getSuggestions(String query) =>
      List.of(cities).where((city) {
        final cityLower = city.toLowerCase();
        final queryLower = query.toLowerCase();

        return cityLower.contains(queryLower);
      }).toList();
}

class FoodData {
  static final faker = Faker();

  static final List<String> foods =
      List.generate(20, (index) => faker.food.dish());

  static List<String> getSuggestions(String query) =>
      List.of(foods).where((food) {
        final foodLower = food.toLowerCase();
        final queryLower = query.toLowerCase();

        return foodLower.contains(queryLower);
      }).toList();
}
