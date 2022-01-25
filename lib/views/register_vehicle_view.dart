import 'package:car_system/colors.dart';
import 'package:car_system/controllers/essencial_vehicle_controller.dart';
import 'package:car_system/models/vehicle.dart';
import 'package:car_system/widgets/button.dart';
import 'package:car_system/widgets/input.dart';
import 'package:car_system/widgets/plan.dart';
import 'package:car_system/widgets/search_dropdown.dart';
import 'package:car_system/widgets/spacing.dart';
import 'package:car_system/widgets/title.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterVehicleView extends GetView<EssencialVehicleController> {
  const RegisterVehicleView({Key? key}) : super(key: key);

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
                    CustomSpacing(),
                    CustomTitle('Datos vehiculo'),
                    CustomSpacing(),
                    CustomDropDowSearch(
                      controller.listStringBrand,
                      'Marca',
                      onSaved: (text) =>
                          controller.createVehicle.value.marca = text,
                    ),
                    CustomSpacing(),
                    CustomDropDowSearch(
                      controller.listStringModel,
                      'Modelo',
                      onSaved: (text) =>
                          controller.createVehicle.value.modelo = text,
                    ),
                    CustomSpacing(),
                    CustomDropDowSearch(
                        controller.listStringFuel, 'Tipo combustible',
                        onSaved: (text) =>
                            controller.createVehicle.value.combustible = text),
                    CustomSpacing(),
                    CustomDropDowSearch(
                      controller.listStringColor,
                      'Color',
                      onSaved: (text) =>
                          controller.createVehicle.value.color = text,
                    ),
                    CustomSpacing(),
                    CustomDropDowSearch(
                      controller.listStringMotor,
                      'Motor',
                      onSaved: (text) =>
                          controller.createVehicle.value.motor = text,
                    ),
                    CustomSpacing(),
                    CustomDropDowSearch(
                      controller.listStringCambio,
                      'Tipo de cambio',
                      onSaved: (text) =>
                          controller.createVehicle.value.cambio = text,
                    ),
                    CustomSpacing(),
                    CustomInput('', 'Año',
                        iconData: Icons.directions_car_outlined,
                        onSaved: (text) =>
                            controller.createVehicle.value.ano = text,
                        isLoading: controller.isLoading.value,
                        validator: validatorTreeCaracteressAndNull,
                        isPhone: true),
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
                      isNumber: true,
                      onSaved: (text) =>
                          controller.createVehicle.value.chapa = text,
                      isLoading: controller.isLoading.value,
                    ),
                    CustomInput(
                      '',
                      'Numero de chassis',
                      iconData: Icons.directions_car_outlined,
                      onSaved: (text) =>
                          controller.createVehicle.value.chassis = text,
                      isLoading: controller.isLoading.value,
                    ),
                    CustomTitle('Precios'),
                    Padding(
                      padding: const EdgeInsets.only(
                          right: 10, left: 10, top: 10, bottom: 10),
                      child: CustomTitle('Precio venta', fontSize: 15),
                    ),
                    CustomInput('', 'Precio para venta en guaraníes',
                        textEditingController: controller.textGuaraniesVenta,
                        iconData: Icons.price_change_outlined,
                        onSaved: (text) => controller
                            .createVehicle.value.contadoGuaranies = text,
                        isLoading: controller.isLoading.value,
                        validator: validatorPriceSelGuaranies,
                        isNumber: true),
                    CustomInput('', 'Precio para venta en dólares',
                        iconData: Icons.price_change_outlined,
                        textEditingController: controller.textDolaresVenta,
                        onSaved: (text) => controller
                            .createVehicle.value.contadoDolares = text,
                        isLoading: controller.isLoading.value,
                        isNumber: true),
                    Padding(
                      padding: const EdgeInsets.only(
                          right: 10, left: 10, bottom: 10),
                      child: CustomTitle('Precio costo', fontSize: 15),
                    ),
                    CustomInput('', 'Costo vehiculo en guaraníes',
                        textEditingController: controller.textGuaraniesCosto,
                        iconData: Icons.price_change_outlined,
                        onSaved: (text) => controller
                            .createVehicle.value.costoGuaranies = text,
                        isLoading: controller.isLoading.value,
                        validator: validatorTreeCaracteressAndNull,
                        isNumber: true),
                    CustomInput('', 'Costo vehiculo en dólares',
                        iconData: Icons.price_change_outlined,
                        textEditingController: controller.textDolaresCosto,
                        onSaved: (text) =>
                            controller.createVehicle.value.costoDolares = text,
                        isLoading: controller.isLoading.value,
                        isNumber: true),
                    CustomTitle('Planes de financiacion'),
                    CustomSpacing(),
                    ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: controller.listCuota.length,
                        itemBuilder: (BuildContext context, int index) {
                          return CustomPlan(index, controller.listCuota[index]);
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            CustomButton(
                                                'REGISTRAR PLAN',
                                                controller.registerCuota,
                                                ColorPalette.SECUNDARY,
                                                edgeInsets:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8,
                                                        vertical: 4),
                                                fontSize: 12,
                                                isLoading:
                                                    controller.isLoading.value),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            CustomButton(
                                                'CANCELAR',
                                                () => Get.back(),
                                                ColorPalette.PRIMARY,
                                                edgeInsets:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8,
                                                        vertical: 4),
                                                fontSize: 12,
                                                isLoading:
                                                    controller.isLoading.value),
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
                    ),
                    CustomSpacing(),
                  ],
                ),
              ),
            ),
          )),
    );
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
                      textEditingController: controller.textCantidadCuotas,
                    ),
                    CustomInput('', 'Cantidad refuerzos',
                        validator: (String text) {
                          if (text.isEmpty) return null;
                          if (double.parse(text.toString()) == 0.0) {
                            return 'Cantidad debe de ser minimo 1';
                          }
                        },
                        isNumber: true,
                        onSaved: (text) {
                          if (text == '') {
                            controller.cuota.value.cantidadRefuerzo = null;
                          } else {
                            controller.cuota.value.cantidadRefuerzo = text;
                          }
                        },
                        textEditingController:
                            controller.textCantidadRefuerzos),
                    CustomTitle('Plan guaraníes'),
                    CustomSpacing(),
                    CustomInput(
                      '',
                      'Entrada',

                      iconData: Icons.price_change_outlined,
                      textEditingController: controller.textEntradaGuaranies,
                      onSaved: (text) =>
                          controller.cuota.value.entradaGuaranies = text,
                    ),
                    CustomInput(
                      '',
                      'Cuota',
                      validator: validatorPriceSelGuaranies,
                      iconData: Icons.price_change_outlined,
                      textEditingController: controller.textCuotaGuaranies,
                      onSaved: (text) =>
                          controller.cuota.value.cuotaGuaranies = text,
                    ),
                    CustomInput(
                      '',
                      'Refuerzo',
                      iconData: Icons.price_change_outlined,
                      onSaved: (text) =>
                          controller.cuota.value.refuerzoGuaranies = text,
                      textEditingController: controller.textRefuezoGuaranies,
                    ),
                    CustomTitle('Plan dólares'),
                    CustomSpacing(),
                    CustomInput('', 'Entrada',
                        iconData: Icons.price_change_outlined,
                        onSaved: (text) =>
                            controller.cuota.value.entradaDolares = text,
                        textEditingController: controller.textEntradaDolares),
                    CustomInput('', 'Cuota',
                        iconData: Icons.price_change_outlined,
                        onSaved: (text) =>
                            controller.cuota.value.cuotaDolares = text,
                        textEditingController: controller.textCuotaDolares),
                    CustomInput('', 'Refuerzo',
                        iconData: Icons.price_change_outlined,
                        onSaved: (text) =>
                            controller.cuota.value.refuerzoDolares = text,
                        textEditingController: controller.textRefuezoDolares),

                  ],
                )),
          ),
        ),
      ),
    );
  }

  String? validatorTreeCaracteressAndNull(String text) {
    if (text.isEmpty) {
      return 'Campo obligatorio.';
    } else if (text.length < 3) {
      return 'Campo debe de contener minimo 3 caracteres.';
    }
    return null;
  }

  String? validatorPriceSelGuaranies(String text) {
    if (text.length < 5) {
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
