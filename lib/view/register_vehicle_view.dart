import 'dart:async';

import 'package:car_system/colors.dart';
import 'package:car_system/common/money_format.dart';
import 'package:car_system/controllers/client_controller.dart';
import 'package:car_system/controllers/essencial_vehicle_controller.dart';
import 'package:car_system/models/essencial_vehicle_models/brand.dart';
import 'package:car_system/models/essencial_vehicle_models/model.dart';
import 'package:car_system/view/buildCity.dart';
import 'package:car_system/view/buildFood.dart';
import 'package:car_system/widgets/button.dart';
import 'package:car_system/widgets/input.dart';
import 'package:car_system/widgets/spacing.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
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
                    CustomSpacing(),
                     dropDowSearch(
                       controller.listStringBrand,
                       'Marca',
                       onSaved: (text) =>
                       controller.createVehicle.value.marca = text,
                     ),
                    CustomSpacing(),
                    dropDowSearch(controller.listStringModel, 'Modelo', onSaved: (text) =>
                    controller.createVehicle.value.modelo = text,),
                    CustomSpacing(),
                    dropDowSearch(
                        controller.listStringFuel, 'Tipo combustible', onSaved: (text) =>
                    controller.createVehicle.value.combustible = text),
                    CustomSpacing(),
                    dropDowSearch(controller.listStringColor, 'Color', onSaved: (text) =>
                controller.createVehicle.value.color = text,),
                    CustomSpacing(),
                    dropDowSearch(controller.listStringMotor, 'Motor', onSaved: (text) =>
                    controller.createVehicle.value.motor = text,),
                    CustomSpacing(),
                    CustomInput('', 'Ano',       iconData:Icons.calendar_today,
                        onSaved: (text) =>
                            controller.createVehicle.value.ano = text,
                        isLoading: controller.isLoading.value,
                        validator: validatorTreeCaracteressAndNull,
                        isPhone: true),
                    CustomInput(
                        '', 'Tipo de cambio',       iconData:Icons.calendar_view_day_outlined,
                        onSaved: (text) =>
                            controller.createVehicle.value.cambio = text,
                        isLoading: controller.isLoading.value,
                        validator: validatorTreeCaracteressAndNull,
                        isPhone: true),
                    CustomInput(
                        '', 'Numero de chapa',       iconData:Icons.confirmation_num_outlined,
                        onSaved: (text) =>
                            controller.createVehicle.value.chapa = text,
                        isLoading: controller.isLoading.value,
                        validator: validatorTreeCaracteressAndNull,
                        isPhone: true),
                    CustomInput('', 'Numero de chassis',
                        iconData:Icons.confirmation_num_outlined,
                        onSaved: (text) =>
                            controller.createVehicle.value.chassis = text,
                        isLoading: controller.isLoading.value,
                        validator: validatorTreeCaracteressAndNull,
                        isPhone: true),
                    CustomInput('', 'Costo vehiculo guaranies',
                         iconData: Icons.price_change_outlined,
                        onSaved: (text) => controller
                            .createVehicle.value.costoGuaranies = text,
                        isLoading: controller.isLoading.value,
                        validator: validatorTreeCaracteressAndNull,
                        isPhone: true),
                    CustomInput('', 'Costo vehiculo dolares',
                        iconData: Icons.price_change_outlined,
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

  Widget layout(
      FutureOr<Iterable<Brand>> Function(TextEditingValue) optionsBuilder) {
    return Autocomplete<Brand>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        return controller.listBrand
            .where((Brand brand) => brand.marca
                .toLowerCase()
                .startsWith(textEditingValue.text.toLowerCase()))
            .toList();
      },
      displayStringForOption: (Brand option) => option.marca,
      fieldViewBuilder: (BuildContext context,
          TextEditingController fieldTextEditingController,
          FocusNode fieldFocusNode,
          VoidCallback onFieldSubmitted) {
        return TextField(
          controller: fieldTextEditingController,
          focusNode: fieldFocusNode,
          style: const TextStyle(fontWeight: FontWeight.bold),
        );
      },
      onSelected: (Brand brand) {
        print('Selected: ${brand.marca}');
      },
      optionsViewBuilder: (BuildContext context,
          AutocompleteOnSelected<Brand> onSelected, Iterable<Brand> options) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            child: Container(
              width: 300,
              color: Colors.teal,
              child: ListView.builder(
                itemCount: options.length,
                itemBuilder: (BuildContext context, int index) {
                  final Brand option = options.elementAt(index);

                  return GestureDetector(
                    onTap: () {
                      onSelected(option);
                    },
                    child: ListTile(
                      title: Text(option.marca,
                          style: const TextStyle(color: Colors.white)),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  Widget dropDowSearch(List<String> list, String label, {IconData? iconData,Function? onSaved,bool isRequired = true}) {
    return DropdownSearch<String>(
      showSearchBox: true,
      showSelectedItems: true,
      showAsSuffixIcons: true,
      dropdownSearchDecoration: const InputDecoration(
        prefixIcon: Icon(Icons.car_rental),
        contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
        border: OutlineInputBorder(
        ),
      ),
      searchFieldProps: TextFieldProps(
        decoration: const InputDecoration(
          filled: true,
          label: Text('Buscar')
        ),
      ),
      validator: (value)=> isRequired ? ( value == null ?  'Campo obligatorio.' : null ): null,
      onSaved: (value) => isRequired ? onSaved != null? onSaved(value) ?? true : true : false,
      mode: Mode.DIALOG,
      items: list,
      label: label,
    );
  }

  Widget layout4() {
    return DropdownSearch<Brand>(
      validator: (u) => u?.marca ?? "user field is required ",
      onFind: (String? filter) => getData(filter!),
      dropdownSearchDecoration: const InputDecoration(
        labelText: "Marca",
        contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
        border: OutlineInputBorder(),
      ),
      searchFieldProps: TextFieldProps(
        decoration: InputDecoration(
          suffixIcon: IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () => controller.textBrandController.clear(),
          ),
        ),
      ),
      onChanged: print,
      dropdownBuilder: (BuildContext context, Brand? brand) {
        return ListTile(
          title: Text(brand?.marca ?? 's'),
        );
      },
      popupItemBuilder: (BuildContext context, Brand? item, bool isSelected) {
        return ListTile(
          selected: isSelected,
          title: Text(item?.marca ?? 'si'),
        );
      },
      showSearchBox: true,
    );
  }

  Future<List<Brand>> getData(String filter) async {
    List<Brand> newList = [];
    if (filter.isEmpty) {
      return controller.listBrand;
    } else {
      newList.addAll(controller.listBrand
          .where(
              (item) => item.marca.toUpperCase().contains(filter.toUpperCase()))
          .toList());
      return newList;
    }
  }

  Widget layout3() {
    return LayoutBuilder(builder: (context, constraints) {
      return DropdownSearch<Brand>(
        validator: (v) => v == null ? "required field" : null,
        dropdownSearchDecoration: const InputDecoration(
          hintText: "Select a country",
          labelText: "Menu mode with helper *",
          helperText: 'positionCallback example usage',
          contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
          border: OutlineInputBorder(),
        ),
        showSearchBox: true,
        mode: Mode.DIALOG,
        showSelectedItems: false,
        items: controller.listBrand,
        onChanged: print,
        positionCallback: (popupButtonObject, overlay) {
          final decorationBox = _findBorderBox(popupButtonObject);

          double translateOffset = 0;
          if (decorationBox != null) {
            translateOffset =
                decorationBox.size.height - popupButtonObject.size.height;
          }

          // Get the render object of the overlay used in `Navigator` / `MaterialApp`, i.e. screen size reference
          final RenderBox overlay =
              Overlay.of(context)!.context.findRenderObject() as RenderBox;
          // Calculate the show-up area for the dropdown using button's size & position based on the `overlay` used as the coordinate space.
          return RelativeRect.fromSize(
            Rect.fromPoints(
              popupButtonObject
                  .localToGlobal(popupButtonObject.size.bottomLeft(Offset.zero),
                      ancestor: overlay)
                  .translate(0, translateOffset),
              popupButtonObject.localToGlobal(
                  popupButtonObject.size.bottomRight(Offset.zero),
                  ancestor: overlay),
            ),
            Size(overlay.size.width, overlay.size.height),
          );
        },
      );
    });
  }

  RenderBox? _findBorderBox(RenderBox box) {
    RenderBox? borderBox;

    box.visitChildren((child) {
      if (child is RenderCustomPaint) {
        borderBox = child;
      }

      final box = _findBorderBox(child as RenderBox);
      if (box != null) {
        borderBox = box;
      }
    });

    return borderBox;
  }

  Widget layout2() {
    return LayoutBuilder(builder: (context, constraints) {
      return RawAutocomplete<Model>(
        textEditingController: controller.textModelController,
        focusNode: FocusNode(onKey: (node, event) {
          if (event.isKeyPressed(LogicalKeyboardKey.enter)) {
            print('aca entro');
            // Do something
            // Next 2 line needed If you don't want to update the text field with new line.
            node.unfocus();
          }
          return KeyEventResult.values.first;
        }),
        optionsBuilder: (TextEditingValue textEditingValue) {
          return controller.listModel
              .where((Model model) => model.modelo
                  .toLowerCase()
                  .startsWith(textEditingValue.text.toLowerCase()))
              .toList();
        },
        displayStringForOption: (Model option) => option.modelo,
        fieldViewBuilder: (BuildContext context,
            TextEditingController fieldTextEditingController,
            FocusNode fieldFocusNode,
            VoidCallback onFieldSubmitted) {
          return TextField(
            controller: controller.textModelController,
            focusNode: fieldFocusNode,
            style: const TextStyle(fontWeight: FontWeight.bold),
          );
        },
        onSelected: (Model model) {
          print('Selected: ${model.modelo}');
        },
        optionsViewBuilder: (BuildContext context,
            AutocompleteOnSelected<Model> onSelected, Iterable<Model> options) {
          return Align(
            alignment: Alignment.topLeft,
            child: Material(
              shape: const RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(4.0)),
              ),
              child: Container(
                color: Colors.grey[200],
                height: 52.0 * options.length,
                width: constraints.biggest.width,
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: false,
                  itemCount: options.length,
                  itemBuilder: (BuildContext context, int index) {
                    final Model option = options.elementAt(index);

                    return GestureDetector(
                      onTap: () {
                        onSelected(option);
                      },
                      child: ListTile(
                        title: Text(option.modelo,
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500)),
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        },
      );
    });
  }
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
