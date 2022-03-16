import 'package:car_system/app/data/repositories/remote/essencial_vehicle_repository.dart';
import '../../core/theme/colors.dart';
import 'package:car_system/rest.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/models/essencial_vehicle_models/brand.dart';
import '../../data/models/essencial_vehicle_models/category.dart';
import '../../global_widgets/button.dart';
import '../../global_widgets/dialog_fetch.dart';
import '../../global_widgets/input.dart';
import '../../global_widgets/search_dropdown.dart';
import '../../global_widgets/snack_bars/snack_bar_error.dart';
import '../../global_widgets/snack_bars/snack_bar_success.dart';
import '../../global_widgets/spacing.dart';

class RegisterEssencialView extends StatelessWidget {
  RegisterEssencialController registerEssencialController =
      Get.put(RegisterEssencialController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registros'),
      ),
      body: Obx(
        () => Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Form(
            key: registerEssencialController.formKey,
            child: Column(
              children: [
                registerEssencialController.text.value == 'MODELOS'
                    ? renderModelo()
                    : Container(),
                CustomSpacing(),
                CustomDropDowSearch(registerEssencialController.listInformation,
                    'Selecionar informacion',
                    onChanged: (text) =>
                        registerEssencialController.text.value = text,
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
                    () async => await CustomDialogFetch(() async {
                          bool res = await registerEssencialController
                              .verifyInformation();
                          if (res) {
                            var resss = await registerEssencialController
                                .sendInformations();
                            CustomSnackBarSuccess('Registrado todos los datos');
                          }
                        }, text: 'Registrando nuevos datos'),
                    ColorPalette.GREEN)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget renderModelo() {
    return Column(
      children: [
        CustomSpacing(),
        DropdownSearch<Category>(
          label: 'Categoria',
          showSearchBox: true,
          compareFn: (item, selectedItem) =>
              item?.idCategoria == selectedItem?.idCategoria,
          onChanged: (value) =>
              registerEssencialController.categorySelected.value = value!,
          onSaved: (value) =>
              registerEssencialController.categorySelected.value = value!,
          showSelectedItems: true,
          selectedItem: registerEssencialController.categorySelected.value,
          validator: (u) =>
              u?.idCategoria == null ? "CATEGORIA OBLICATORIA" : null,
          itemAsString: (Category? item) => item?.categoria ?? '',
          showAsSuffixIcons: true,
          dropdownSearchDecoration: const InputDecoration(
            prefixIcon: Icon(Icons.person_outline),
            contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            border: OutlineInputBorder(),
          ),
          searchFieldProps: TextFieldProps(
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
                filled: true, label: Text('Buscar por marca')),
          ),
          mode: Mode.DIALOG,
          items: registerEssencialController.listCategories,
        ),
        CustomSpacing(),
        DropdownSearch<Brand>(
          label: 'Marca',
          showSearchBox: true,
          compareFn: (item, selectedItem) =>
              item?.idMarca == selectedItem?.idMarca,
          onChanged: (value) =>
              registerEssencialController.brandSelected.value = value!,
          onSaved: (value) =>
              registerEssencialController.brandSelected.value = value!,
          showSelectedItems: true,
          selectedItem: registerEssencialController.brandSelected.value,
          validator: (u) => u?.idMarca == null ? "MARCA OBLIGATORIO" : null,
          itemAsString: (Brand? item) => item?.marca ?? '',
          showAsSuffixIcons: true,
          dropdownSearchDecoration: const InputDecoration(
            prefixIcon: Icon(Icons.person_outline),
            contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            border: OutlineInputBorder(),
          ),
          searchFieldProps: TextFieldProps(
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
                filled: true, label: Text('Buscar por marca')),
          ),
          mode: Mode.DIALOG,
          items: registerEssencialController.listBrands,
        ),
      ],
    );
  }
}

class RegisterEssencialController extends GetxController {
  final EssencialVehiclesRepository essencialVehicleRepository = Get.find();

  TextEditingController textEditNuevoDato = TextEditingController();

  RxList<Brand> listBrands = <Brand>[].obs;
  Rx<Brand> brandSelected = Brand().obs;

  RxList<Category> listCategories = <Category>[].obs;
  Rx<Category> categorySelected = Category().obs;

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
      Map<String, dynamic> model = {};
      if (text.value == 'MODELOS') {
        model = {
          "modelo": st.toUpperCase(),
          "id_marca": brandSelected.value.idMarca,
          "id_categoria": categorySelected.value.idCategoria
        };
        var responseee =
            await essencialVehicleRepository.postInformations(url, model);
        if (responseee == 'ok') {
          listValues.removeWhere((element) => element == st);
        }
      } else {
        var responseee = await essencialVehicleRepository.postInformations(
            url + st.toUpperCase(), model);
        if (responseee == 'ok') {
          listValues.removeWhere((element) => element == st);
        }
      }
    }
    return 'ok';
  }

  @override
  void onReady() async {
    // TODO: implement onReady
    await CustomDialogFetch(() async {
      Future responseee = essencialVehicleRepository
          .fetchVehicleInformation(<Brand>[], Rest.BRANDS, Brand.fromJson);
      Future responseCategoria = essencialVehicleRepository
          .fetchVehicleInformation(
              <Category>[], Rest.CATEGORIES, Category.fromJson,
              return2arrays: false);

      List<dynamic> listAwait =
          await Future.wait([responseee, responseCategoria]);
      listBrands.value = listAwait[0][0];
      brandSelected.value = listBrands.first;
      listCategories.value = listAwait[1][0];
      categorySelected.value = listCategories.first;
    });
    super.onReady();
  }
}
