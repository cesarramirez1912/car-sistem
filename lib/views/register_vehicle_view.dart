import 'package:car_system/colors.dart';
import 'package:car_system/common/remove_money_format.dart';
import 'package:car_system/controllers/essencial_vehicle_controller.dart';
import 'package:car_system/models/essencial_vehicle_models/brand.dart';
import 'package:car_system/models/essencial_vehicle_models/model.dart';
import 'package:car_system/responsive.dart';
import 'package:car_system/route_manager.dart';
import 'package:car_system/widgets/button.dart';
import 'package:car_system/widgets/dialog_fetch.dart';
import 'package:car_system/widgets/input.dart';
import 'package:car_system/widgets/plan.dart';
import 'package:car_system/widgets/search_dropdown.dart';
import 'package:car_system/widgets/snack_bars/snack_bar_success.dart';
import 'package:car_system/widgets/spacing.dart';
import 'package:car_system/widgets/title.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
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
              () => Responsive(
                mobile: mobile(),
                tablet: tablet(),
                desktop: tablet(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget tablet() {
    return Container(
      alignment: Alignment.center,
      child: Container(
        width: 770,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomSpacing(),
            CustomTitle('Datos vehiculo'),
            CustomSpacing(),
            Wrap(
              children: [
                ...cardSection()
                    .where((element) =>
                        element.toString() !=
                        const SizedBox(height: 16.0).toString())
                    .toList()
                    .map(
                      (e) => Container(
                        margin: EdgeInsets.all(4),
                        width: 220,
                        height: 90,
                        child: e,
                      ),
                    ),
              ],
            ),
            CustomTitle('Precios'),
            ...pricesSection(),
            CustomTitle('Planes de financiación'),
            ...financSection(),
            CustomSpacing(),
          ],
        ),
      ),
    );
  }

  Widget mobile() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomSpacing(),
        CustomTitle('Datos vehiculo'),
        ...cardSection(),
        CustomTitle('Precios'),
        ...pricesSection(),
        CustomTitle('Planes de financiación'),
        ...financSection(),
        CustomSpacing(),
      ],
    );
  }

  List<Widget> financSection() {
    return [
      ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: controller.listCuota.length,
          itemBuilder: (BuildContext context, int index) {
            return CustomPlan(index, controller.listCuota[index],
                onPressed: () => controller.listCuota.removeAt(index));
          }),
      CustomSpacing(),
      Row(
        children: [
          Expanded(
            child: CustomButton(
                'AGREGAR PLAN',
                () => Get.defaultDialog(
                        title: 'Nuevo plan',
                        content: dialogPlan(),
                        actions: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomButton(
                                  'REGISTRAR PLAN',
                                  controller.registerCuota,
                                  ColorPalette.SECUNDARY,
                                  edgeInsets: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  fontSize: 12,
                                  isLoading: controller.isLoading.value),
                              const SizedBox(
                                width: 10,
                              ),
                              CustomButton('CANCELAR', () => Get.back(),
                                  ColorPalette.PRIMARY,
                                  edgeInsets: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  fontSize: 12,
                                  isLoading: controller.isLoading.value),
                            ],
                          ),
                        ]),
                ColorPalette.SECUNDARY,
                iconData: Icons.post_add,
                isLoading: controller.isLoading.value),
          ),
        ],
      ),
      CustomSpacing(),
      Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          CustomButton('REGISTRAR VEHICULO', () async {
            CustomDialogFetch(() async {
              await controller.registerVehicle();
            }, text: 'REGISTRANDO VEHICULO')
                .then((value) async {
              CustomSnackBarSuccess('VEHICULO REGISTRADO CON EXITO!');
              await Future.delayed(const Duration(seconds: 1));
              Get.offAllNamed(RouterManager.HOME);
            });
          }, ColorPalette.GREEN, isLoading: controller.isLoading.value),
          const SizedBox(
            width: 10,
          ),
          CustomButton('CANCELAR', () => Get.back(), ColorPalette.PRIMARY,
              isLoading: controller.isLoading.value),
        ],
      ),
    ];
  }

  List<Widget> pricesSection() {
    return [
      Padding(
        padding:
            const EdgeInsets.only(right: 10, left: 10, top: 10, bottom: 10),
        child: CustomTitle('Precio venta', fontSize: 15),
      ),
      CustomInput('', 'Precio para venta en guaraníes',
          textEditingController: controller.textGuaraniesVenta,
          iconData: Icons.price_change_outlined,
          onSaved: (text) =>
              controller.createVehicle.value.contadoGuaranies = text,
          isLoading: controller.isLoading.value,
          validator: validatorPriceSelDinero,
          onChanged: (text) {
            if (text.toString().length < 4) {
              controller.textGuaraniesVenta.text = '0';
            }
          },
          isNumber: true),
      CustomInput('', 'Precio para venta en dólares',
          iconData: Icons.price_change_outlined,
          textEditingController: controller.textDolaresVenta,
          validator: validatorPriceSelDinero,
          onSaved: (text) =>
              controller.createVehicle.value.contadoDolares = text,
          isLoading: controller.isLoading.value,
          isNumber: true),
      Padding(
        padding: const EdgeInsets.only(right: 10, left: 10, bottom: 10),
        child: CustomTitle('Precio costo', fontSize: 15),
      ),
      CustomInput('', 'Costo vehiculo en guaraníes',
          textEditingController: controller.textGuaraniesCosto,
          iconData: Icons.price_change_outlined,
          onChanged: (text) {
            if (text.toString().length < 4) {
              controller.textGuaraniesCosto.text = '0';
            }
          },
          onSaved: (text) =>
              controller.createVehicle.value.costoGuaranies = text,
          isLoading: controller.isLoading.value,
          validator: validatorTreeCaracteressAndNull,
          isNumber: true),
      CustomInput('', 'Costo vehiculo en dólares',
          iconData: Icons.price_change_outlined,
          textEditingController: controller.textDolaresCosto,
          onSaved: (text) => controller.createVehicle.value.costoDolares = text,
          isLoading: controller.isLoading.value,
          isNumber: true),
    ];
  }

  List<Widget> cardSection() {
    return [
      CustomSpacing(),
      DropdownSearch<Brand>(
        label: 'Marca',
        showSearchBox: true,
        compareFn: (item, selectedItem) =>
            item?.idMarca == selectedItem?.idMarca,
        onChanged: (value) {
          controller.brandSelected.value = value!;
          controller.listModelAux.clear();
          controller.listModelAux.value = controller.listModel
              .where((el) => el.idMarca == value.idMarca)
              .toList();
          if (controller.listModelAux.isEmpty) {
            controller.modelSelected.value = Model();
          } else {
            controller.modelSelected.value = controller.listModelAux.first;
          }
        },
        showSelectedItems: true,
        selectedItem: controller.brandSelected.value,
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
        items: controller.listBrand,
      ),
      CustomSpacing(),
      DropdownSearch<Model>(
        label: 'Modelo',
        showSearchBox: true,
        compareFn: (item, selectedItem) =>
            item?.idModelo == selectedItem?.idModelo,
        onChanged: (value) {
          controller.modelSelected.value = value!;
        },
        onSaved: (item) =>
            controller.createVehicle.value.idModelo = item?.idModelo,
        selectedItem: controller.modelSelected.value,
        showSelectedItems: true,
        validator: (u) => u?.idModelo == null ? "MODELO OBLIGATORIO" : null,
        itemAsString: (Model? item) => item?.modelo ?? '',
        showAsSuffixIcons: true,
        dropdownSearchDecoration: const InputDecoration(
          prefixIcon: Icon(Icons.person_outline),
          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          border: OutlineInputBorder(),
        ),
        searchFieldProps: TextFieldProps(
          keyboardType: TextInputType.text,
          decoration: const InputDecoration(
              filled: true, label: Text('Buscar por modelo')),
        ),
        mode: Mode.DIALOG,
        items: controller.listModelAux,
      ),
      CustomSpacing(),
      CustomDropDowSearch(controller.listStringFuel, 'Tipo combustible',
          onSaved: (text) => controller.createVehicle.value.combustible = text),
      CustomSpacing(),
      CustomDropDowSearch(
        controller.listStringColor,
        'Color',
        onSaved: (text) => controller.createVehicle.value.color = text,
      ),
      CustomSpacing(),
      CustomDropDowSearch(
        controller.listStringMotor,
        'Motor',
        onSaved: (text) => controller.createVehicle.value.motor = text,
      ),
      CustomSpacing(),
      CustomDropDowSearch(
        controller.listStringCambio,
        'Tipo de cambio',
        onSaved: (text) => controller.createVehicle.value.cambio = text,
      ),
      CustomSpacing(),
      CustomInput('', 'Año',
          iconData: Icons.directions_car_outlined,
          onSaved: (text) => controller.createVehicle.value.ano = text,
          isLoading: controller.isLoading.value,
          validator: validatorTreeCaracteressAndNull,
          isNumber: true),
      CustomInput(
        '',
        'Numero de chapa',
        textEditingController: controller.textNumeroChapa,
        onChanged: (text) {
          if (text.length == 4) {
            bool found = text.contains(RegExp(r'[0-9]'));
            if (found) {
              controller.textNumeroChapa.updateMask('***-000');
            } else {
              controller.textNumeroChapa.updateMask('****-000');
            }
          }
        },
        iconData: Icons.directions_car_outlined,
        onSaved: (text) => controller.createVehicle.value.chapa = text,
        isLoading: controller.isLoading.value,
      ),
      CustomInput(
        '',
        'Numero de chassis',
        iconData: Icons.directions_car_outlined,
        onSaved: (text) => controller.createVehicle.value.chassis = text,
        isLoading: controller.isLoading.value,
      ),
    ];
  }

  Widget dialogPlan() {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(4),
            ),
            border: Border.all(width: 1, color: Colors.grey)),
        child: SizedBox(
          height: 300,
          child: SingleChildScrollView(
            child: Form(
              key: controller.formKeyDialog,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomSpacing(),
                  CustomTitle('Cant. Cuotas | Refuerzos'),
                  CustomSpacing(),
                  CustomInput(
                    '',
                    'Cantidad cuotas',
                    isNumber: true,
                    onSaved: (text) =>
                        controller.cuota.value.cantidadCuotas = text,
                    validator: (String text) {
                      if (text.isEmpty) {
                        return 'Campo obligatorio.';
                      } else {
                        if (double.parse(text.toString()) == 0.0) {
                          return 'Cantidad debe de ser minimo 1';
                        }
                      }
                    },
                    onChanged: controller.sumTotal,
                    textEditingController: controller.textCantidadCuotas,
                  ),
                  CustomInput('', 'Cantidad refuerzos',
                      onChanged: controller.sumTotal,
                      validator: validatorRefuerzo,
                      isNumber: true, onSaved: (text) {
                    if (text == '') {
                      controller.cuota.value.cantidadRefuerzo = null;
                    } else {
                      controller.cuota.value.cantidadRefuerzo = text;
                    }
                  }, textEditingController: controller.textCantidadRefuerzos),
                  CustomTitle('Plan guaraníes'),
                  CustomSpacing(),
                  CustomInput(
                    '',
                    'Entrada',
                    isNumber: true,
                    iconData: Icons.price_change_outlined,
                    textEditingController: controller.textEntradaGuaranies,
                    onChanged: (text) {
                      if (text.toString().length < 4) {
                        controller.textEntradaGuaranies.updateValue(0);
                      }
                    },
                    onSaved: (text) =>
                        controller.cuota.value.entradaGuaranies = text,
                  ),
                  CustomInput(
                    '',
                    'Cuota',
                    isNumber: true,
                    validator: validatorCuoteDinero,
                    iconData: Icons.price_change_outlined,
                    textEditingController: controller.textCuotaGuaranies,
                    onSaved: (text) =>
                        controller.cuota.value.cuotaGuaranies = text,
                    onChanged: (text) {
                      if (text.toString().length < 4) {
                        controller.textCuotaGuaranies.updateValue(0);
                      }
                    },
                  ),
                  CustomInput(
                    '',
                    'Refuerzo',
                    isNumber: true,
                    iconData: Icons.price_change_outlined,
                    validator: validatorRefuerzoDinero,
                    onChanged: (text) {
                      if (text.toString().length < 4) {
                        controller.textRefuezoGuaranies.updateValue(0);
                      }
                    },
                    onSaved: (text) =>
                        controller.cuota.value.refuerzoGuaranies = text,
                    textEditingController: controller.textRefuezoGuaranies,
                  ),
                  CustomTitle('Plan dólares'),
                  CustomSpacing(),
                  CustomInput('', 'Entrada',
                      isNumber: true,
                      iconData: Icons.price_change_outlined,
                      onSaved: (text) =>
                          controller.cuota.value.entradaDolares = text,
                      textEditingController: controller.textEntradaDolares),
                  CustomInput('', 'Cuota',
                      isNumber: true,
                      iconData: Icons.price_change_outlined,
                      validator: validatorCuoteDinero,
                      onSaved: (text) =>
                          controller.cuota.value.cuotaDolares = text,
                      textEditingController: controller.textCuotaDolares),
                  CustomInput('', 'Refuerzo',
                      isNumber: true,
                      validator: validatorRefuerzoDinero,
                      iconData: Icons.price_change_outlined,
                      onSaved: (text) =>
                          controller.cuota.value.refuerzoDolares = text,
                      textEditingController: controller.textRefuezoDolares),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String? validatorRefuerzoDinero(String text) {
    double refuerzoGuaraniesDouble = RemoveMoneyFormat()
        .removeToDouble(controller.textRefuezoGuaranies.text);
    double refuerzoDolaresDouble =
        RemoveMoneyFormat().removeToDouble(controller.textRefuezoDolares.text);
    if (controller.textCantidadRefuerzos.text.isEmpty) {
      return null;
    } else {
      if (refuerzoGuaraniesDouble == 0.0 && refuerzoDolaresDouble < 1) {
        return 'Campo obligatorio.';
      } else {
        return null;
      }
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

  String? validatorRefuerzo(String text) {
    double refuerzoGuaraniesDouble = RemoveMoneyFormat()
        .removeToDouble(controller.textRefuezoGuaranies.text);
    double refuerzoDolarDouble =
        RemoveMoneyFormat().removeToDouble(controller.textRefuezoDolares.text);
    if (text.isEmpty) {
      if (refuerzoGuaraniesDouble > 0) {
        return 'Obligatorio (Refuerzo G\$).';
      } else if (refuerzoDolarDouble > 0.0) {
        return 'Obligatorio (Refuerzo U\$).';
      } else {
        return null;
      }
    } else {
      if (double.parse(text.toString()) == 0.0) {
        return 'Cantidad debe de ser minimo 1';
      } else {
        return null;
      }
    }
  }

  String? validatorCuoteDinero(String text) {
    double cuotaGuaraniesDouble =
        RemoveMoneyFormat().removeToDouble(controller.textCuotaGuaranies.text);
    double cuotaDolaresDouble =
        RemoveMoneyFormat().removeToDouble(controller.textCuotaDolares.text);

    if (controller.textCantidadCuotas.value.text.isNotEmpty) {
      if (cuotaGuaraniesDouble > 0.0) {
        return null;
      }
      if (cuotaGuaraniesDouble == 0.0 && cuotaDolaresDouble < 1) {
        return 'Campo obligatorio.';
      }
      return null;
    } else {
      return 'Campo obligatorio.';
    }
  }

  String? validatorPriceSelDinero(String text) {
    double guaraniesVentaDouble =
        RemoveMoneyFormat().removeToDouble(controller.textGuaraniesVenta.text);
    double dolaresVentaDouble =
        RemoveMoneyFormat().removeToDouble(controller.textDolaresVenta.text);
    if (dolaresVentaDouble > 1) {
      return null;
    }
    if (dolaresVentaDouble == 0.0 && guaraniesVentaDouble == 0.0) {
      return 'Campo obligatorio.';
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
        const SizedBox(
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
}
