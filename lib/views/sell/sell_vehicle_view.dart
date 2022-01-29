import 'package:car_system/common/date_format.dart';
import 'package:car_system/common/remove_money_format.dart';
import 'package:car_system/controllers/client_controller.dart';
import 'package:car_system/controllers/list_vehicle_controller.dart';
import 'package:car_system/controllers/sells_from_collaborator_controller.dart';
import 'package:car_system/controllers/user_storage_controller.dart';
import 'package:car_system/controllers/vehicle_detail_controller.dart';
import 'package:car_system/models/cuotes.dart';
import 'package:car_system/models/register_client_model.dart';
import 'package:car_system/responsive.dart';
import 'package:car_system/route_manager.dart';
import 'package:car_system/widgets/button.dart';
import 'package:car_system/widgets/input.dart';
import 'package:car_system/widgets/plan.dart';
import 'package:car_system/widgets/search_dropdown.dart';
import 'package:car_system/widgets/snack_bars/snack_bar_success.dart';
import 'package:car_system/widgets/spacing.dart';
import 'package:car_system/widgets/title.dart';
import 'package:car_system/widgets/vehicle_detail_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:get/get.dart';
import 'package:dropdown_search/dropdown_search.dart';

import '../../colors.dart';

class SellVehicleView extends GetView<VehicleDetailController> {
  ClientController clientController = Get.find();
  UserStorageController userStorageController = Get.find();
  ListVehicleController listVehicleController = Get.find();
  SellsFromCollaboratorController sellsFromCollaboratorController = Get.find();

  @override
  Widget build(BuildContext context) {
    controller.sellVehicleModel.value.idEmpresa =
        userStorageController.user!.value.idEmpresa;
    controller.sellVehicleModel.value.idSucursal =
        userStorageController.user!.value.idSucursal;
    controller.sellVehicleModel.value.idColaborador =
        userStorageController.user!.value.idColaborador;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vender vehiculo'),
      ),
      body: Obx(
        () => Responsive.isMobile(context)
            ? mobile(context)
            : Container(
                alignment: Alignment.center,
                child: SizedBox(
                  width: 700,
                  child: mobile(context),
                ),
              ),
      ),
    );
  }

  Widget mobile(context) {
    return SingleChildScrollView(
      child: Form(
        key: controller.formKey,
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.only(bottom: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomSpacing(),
                    CustomVehicleDetailCard(controller.vehicleSelected.first),
                    CustomSpacing(),
                    const Divider(
                      color: Colors.grey,
                    ),
                    CustomSpacing(height: 10),
                    CustomTitle('CLIENTE'),
                    CustomSpacing(),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: DropdownSearch<ClientModel>(
                            showSearchBox: true,
                            selectedItem: controller.typeClientSelected.value,
                            compareFn: (item, selectedItem) =>
                                item?.idCliente == selectedItem?.idCliente,
                            onChanged: (value) {
                              controller.typeClientSelected.value = value!;
                              controller.sellVehicleModel.value.idCliente =
                                  value.idCliente;
                            },
                            showSelectedItems: true,
                            validator: (u) => u?.idCliente == null
                                ? "CLIENTE OBLIGATORIO PARA LA VENTA"
                                : null,
                            itemAsString: (ClientModel? item) =>
                                item?.cliente ?? '',
                            dropdownBuilder:
                                _customDropDownExampleMultiSelection,
                            showAsSuffixIcons: true,
                            dropdownSearchDecoration: const InputDecoration(
                              prefixIcon: Icon(Icons.person_outline),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              border: OutlineInputBorder(),
                            ),
                            searchFieldProps: TextFieldProps(
                              keyboardType: TextInputType.text,
                              decoration: const InputDecoration(
                                  filled: true,
                                  label: Text('Buscar por nombre')),
                            ),
                            popupItemBuilder: _customPopupItemBuilderExample2,
                            onSaved: (value) => controller.sellVehicleModel
                                .value.idCliente = value?.idCliente,
                            mode: Mode.DIALOG,
                            items: clientController.listClients,
                          ),
                        ),
                        const SizedBox(
                          width: 6,
                        ),
                        CustomButton('', () async {
                          var resId =
                              await Get.toNamed(RouterManager.REGISTER_CLIENT);
                          if (resId != null) {
                            var clientRegister = clientController.listClients
                                .where((cli) => cli.idCliente == resId)
                                .toList()
                                .first;
                            controller.sellVehicleModel.value.idCliente =
                                clientRegister.idCliente;
                            controller.typeClientSelected.value =
                                clientRegister;
                          }
                        }, ColorPalette.SECUNDARY,
                            iconData: Icons.person_add_alt),
                      ],
                    ),
                    CustomSpacing(),
                    const Divider(
                      color: Colors.grey,
                    ),
                    CustomSpacing(),
                    CustomTitle('FILTROS'),
                    CustomSpacing(),
                    CustomDropDowSearch(
                        controller.typesSell, 'ELEGIR TIPO DE VENTA',
                        iconData: controller.typeSellSelected.value == 'CONTADO'
                            ? Icons.money
                            : Icons.credit_card_sharp,
                        selectedItem: controller.typeSellSelected.value,
                        onChanged: (value) {
                      controller.cleanInputsCuotes();
                      if (value == 'CREDITO') {
                        controller.sellVehicleModel.value.contadoGuaranies =
                            null;
                        controller.sellVehicleModel.value.contadoDolares = null;
                      } else {
                        controller.sellVehicleModel.value.entradaGuaranies =
                            null;
                        controller.sellVehicleModel.value.entradaDolares = null;
                        controller.sellVehicleModel.value.cuotas?.clear();
                        controller.sellVehicleModel.value.refuerzos?.clear();
                      }
                      controller.typeSellSelected.value = value;
                    }),
                    CustomSpacing(),
                    CustomDropDowSearch(
                      controller.typesMoney,
                      'ELEGIR TIPO DE MONEDA',
                      iconData: Icons.monetization_on_outlined,
                      selectedItem: controller.typesMoneySelected.value,
                      onChanged: (value) {
                        controller.cleanInputsCuotes();
                        if (value == 'GUARANIES') {
                          controller.cuota.value.cuotaDolares = null;
                        } else {
                          controller.cuota.value.cuotaGuaranies = null;
                        }
                        controller.typesMoneySelected.value = value;
                      },
                    ),
                    CustomSpacing(),
                    CustomTitle('PRECIO FINAL'),
                    CustomSpacing(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: listRender(context),
                    ),
                    CustomButton('FINALIZAR VENTA', () async {
                      await controller.registerSale();
                      await listVehicleController.fetchVehicles();
                      await sellsFromCollaboratorController.requestSales();
                    }, ColorPalette.GREEN)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> listRender(BuildContext context) {
    switch (controller.typeSellSelected.value) {
      case 'CONTADO':
        return [
          CustomInput('', 'PRECIO VENTA ${controller.typesMoneySelected.value}',
              isNumber: true,
              iconData: Icons.price_change_outlined,
              onSaved: (text) => controller.typesMoneySelected == 'GUARANIES'
                  ? {
                      controller.sellVehicleModel.value.contadoGuaranies = text,
                      controller.sellVehicleModel.value.contadoDolares = null
                    }
                  : {
                      controller.sellVehicleModel.value.contadoDolares = text,
                      controller.sellVehicleModel.value.contadoGuaranies = null
                    },
              textEditingController:
                  controller.typesMoneySelected == 'GUARANIES'
                      ? (controller.textContadoGuaranies)
                      : controller.textContadoDolares),
        ];
      case 'CREDITO':
        return [
          CustomPlan(0, controller.cuota.value,
              textRender: controller.typesMoneySelected.value,
              withTitle: false),
          controller.vehicleSelected.first.cantidadCuotas == null ||
                  controller.vehicleSelected.first.cantidadCuotas == 0
              ? Container()
              : expanded(CustomButton(
                  'ELEGIR PLAN',
                  () => Get.defaultDialog(
                          title: 'ELEGIR PLAN ${controller.typesMoneySelected}',
                          content: dialogSelectPlan(),
                          actions: [
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: CustomButton('CANCELAR', () => Get.back(),
                                  ColorPalette.PRIMARY,
                                  edgeInsets: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  fontSize: 12,
                                  isLoading: controller.isLoading.value),
                            ),
                          ]),
                  ColorPalette.YELLOW,
                  iconData: Icons.list,
                  isLoading: controller.isLoading.value)),
          expanded(CustomButton(
              'NUEVO PLAN',
              () => Get.defaultDialog(
                      title: 'NUEVO PLAN ${controller.typesMoneySelected}',
                      content: dialogPlan(),
                      actions: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
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
              isLoading: controller.isLoading.value)),
          CustomSpacing(),
          const Divider(
            color: Colors.grey,
          ),
          CustomSpacing(),
          controller.cuota.value.cantidadCuotas == null ||
                  controller.cuota.value.cantidadCuotas == 0
              ? Container()
              : vencimientosSection(context),
          CustomSpacing(),
          const Divider(
            color: Colors.grey,
          ),
          CustomSpacing()
        ];
      default:
        return [];
    }
  }

  Widget vencimientosSection(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CustomTitle('Fechas vencimiento'),
        Padding(
          padding: const EdgeInsets.only(right: 10, left: 10),
          child: CustomTitle('Cuota', fontSize: 15),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: textInputContainer(
                'Primera cuota en:',
                DateFormatBr().formatBrFromString(
                    controller.firstDateCuoteSelected.value.toString()),
                onTap: () => controller.firstDateCuote(context),
              ),
            ),
            const SizedBox(
              width: 6,
            ),
            Column(
              children: [
                CustomSpacing(height: 7),
                CustomButton('', () {
                  controller.generatedDatesCuotes();
                  Get.toNamed(RouterManager.DATES_VEN,
                      parameters: {'isCuote': 'true'});
                }, ColorPalette.SECUNDARY,
                    iconData: Icons.calendar_today_rounded),
              ],
            )
          ],
        ),
        CustomSpacing(height: 10),
        controller.cuota.value.cantidadRefuerzo == null ||
                controller.cuota.value.cantidadRefuerzo == 0
            ? Container()
            : Padding(
                padding: const EdgeInsets.only(right: 10, left: 10),
                child: CustomTitle('Refuerzo', fontSize: 15),
              ),
        controller.cuota.value.cantidadRefuerzo == null ||
                controller.cuota.value.cantidadRefuerzo == 0
            ? Container()
            : Column(
                children: [
                  CustomSpacing(height: 10),
                  CustomDropDowSearch(
                      controller.typesCobroMensuales, 'ENTRE MESES',
                      iconData: Icons.date_range,
                      selectedItem: controller.typeCobroMensualSelected.value,
                      onChanged: (value) {
                    controller.typeCobroMensualSelected.value = value;
                    controller.generatedDatesRefuerzos();
                  }),
                  CustomSpacing(height: 5),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: textInputContainer(
                          'Primer refuerzo en:',
                          DateFormatBr().formatBrFromString(controller
                              .firstDateRefuerzoSelected.value
                              .toString()),
                          onTap: () => controller.firstDateRefuerzo(context),
                        ),
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      Column(
                        children: [
                          CustomSpacing(height: 7),
                          CustomButton('', () {
                            controller.generatedDatesRefuerzos();
                            Get.toNamed(RouterManager.DATES_VEN,
                                parameters: {'isCuote': 'false'});
                          }, ColorPalette.SECUNDARY,
                              iconData: Icons.calendar_today_rounded),
                        ],
                      )
                    ],
                  )
                ],
              ),
      ],
    );
  }

  Widget textInputContainer(String text, String value, {Function? onTap}) {
    return GestureDetector(
      onTap: () => onTap!(),
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            margin: const EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(4)),
                border: Border.all(color: Colors.grey)),
            child: Text(value, style: TextStyle(fontSize: 16)),
          ),
          Positioned(
            top: 0,
            left: 10,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              color: Colors.white,
              child: Text(
                text,
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget expanded(Widget body) {
    return Row(
      children: [Expanded(child: body)],
    );
  }

  Widget dialogSelectPlan() {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
        child: SizedBox(
          height: 300,
          width: double.maxFinite,
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: controller.vehicleSelected.length,
              itemBuilder: (BuildContext context, int index) {
                Cuota cuota =
                    Cuota.fromJson(controller.vehicleSelected[index].toJson());
                return Column(
                  children: [
                    GestureDetector(
                      onTap: () => controller.selectedPlan(cuota),
                      child: CustomPlan(index, cuota,
                          textRender: controller.typesMoneySelected.value),
                    ),
                    CustomButton(
                        'ELEGIR PLAN N° ${(index + 1).toString()}',
                        () => controller.selectedPlan(cuota),
                        ColorPalette.YELLOW),
                    CustomSpacing(),
                  ],
                );
              }),
        ),
      ),
    );
  }

  Widget _customDropDownExampleMultiSelection(
      BuildContext context, ClientModel? itemSelected) {
    MaskedTextController textCiController = MaskedTextController(
        text: itemSelected?.ci?.toString() ?? '', mask: '0.000.000-00');
    if (itemSelected?.idCliente == null) {
      return const ListTile(
        contentPadding: EdgeInsets.all(0),
        title: Text("Ningun cliente seleccionado"),
      );
    }

    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      title: Text(itemSelected?.cliente ?? ''),
      subtitle: Text(
        textCiController.text,
      ),
    );
  }

  Widget _customPopupItemBuilderExample2(
      BuildContext context, ClientModel? item, bool isSelected) {
    MaskedTextController textCiController = MaskedTextController(
        text: item?.ci?.toString() ?? '', mask: '0.000.000-00');
    return ListTile(
      selected: isSelected,
      title: Text(item?.cliente ?? ''),
      subtitle: Text(textCiController.text),
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
                      onSaved: (text) => controller.cuota.value.cantidadCuotas =
                          int.parse(text),
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
                            controller.cuota.value.cantidadRefuerzo =
                                int.parse(text);
                          }
                        },
                        textEditingController:
                            controller.textCantidadRefuerzos),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: renderWidgetsMoneyType(),
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }

  List<Widget> renderWidgetsMoneyType() {
    switch (controller.typesMoneySelected.value) {
      case 'GUARANIES':
        return [
          CustomTitle('Plan guaraníes'),
          CustomSpacing(),
          CustomInput(
            '',
            'Entrada',
            isNumber: true,
            iconData: Icons.price_change_outlined,
            textEditingController: controller.textEntradaGuaranies,
            onSaved: (text) => controller.cuota.value.entradaGuaranies = text,
          ),
          CustomInput(
            '',
            'Cuota',
            isNumber: true,
            validator: (String text) {
              String newString = RemoveMoneyFormat().removeToString(text);
              if (text.isEmpty) return 'Informar cuota mensual.';
              if (newString.isNum) {
                if (double.parse(newString.toString()) == 0.0) {
                  return 'Informar cuota mensual.';
                }
              } else {
                return 'Informar cuota mensual.';
              }
            },
            iconData: Icons.price_change_outlined,
            textEditingController: controller.textCuotaGuaranies,
            onSaved: (text) => controller.cuota.value.cuotaGuaranies = text,
          ),
          CustomInput(
            '',
            'Refuerzo',
            isNumber: true,
            validator: (String text) {
              String newString = RemoveMoneyFormat().removeToString(text);
              if (controller.textCantidadRefuerzos.text.isNotEmpty) {
                if (newString.isNum) {
                  if (double.parse(newString.toString()) == 0.0) {
                    return 'Informar cuota refuerzo.';
                  }
                } else {
                  return 'Informar cuota refuerzo.';
                }
              }
            },
            iconData: Icons.price_change_outlined,
            onSaved: (text) => controller.cuota.value.refuerzoGuaranies = text,
            textEditingController: controller.textRefuezoGuaranies,
          ),
        ];
      case 'DOLARES':
        return [
          CustomTitle('Plan dólares'),
          CustomSpacing(),
          CustomInput('', 'Entrada',
              isNumber: true,
              iconData: Icons.price_change_outlined,
              onSaved: (text) => controller.cuota.value.entradaDolares = text,
              textEditingController: controller.textEntradaDolares),
          CustomInput('', 'Cuota',
              isNumber: true,
              validator: (String text) {
                String newString = RemoveMoneyFormat().removeToString(text);
                if (text.isEmpty) return 'Informar cuota mensual.';
                if (newString.isNum) {
                  if (double.parse(newString.toString()) == 0.0) {
                    return 'Informar cuota mensual.';
                  }
                } else {
                  return 'Informar cuota mensual.';
                }
              },
              iconData: Icons.price_change_outlined,
              onSaved: (text) => controller.cuota.value.cuotaDolares = text,
              textEditingController: controller.textCuotaDolares),
          CustomInput('', 'Refuerzo',
              isNumber: true,
              validator: (String text) {
                String newString = RemoveMoneyFormat().removeToString(text);
                if (controller.textCantidadRefuerzos.text.isNotEmpty) {
                  if (newString.isNum) {
                    if (double.parse(newString.toString()) == 0.0) {
                      return 'Informar cuota refuerzo.';
                    }
                  } else {
                    return 'Informar cuota refuerzo.';
                  }
                }
              },
              iconData: Icons.price_change_outlined,
              onSaved: (text) => controller.cuota.value.refuerzoDolares = text,
              textEditingController: controller.textRefuezoDolares),
        ];
      default:
        return [];
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

  String? validatorPriceSelGuaranies(String text) {
    if (text.length < 5) {
      return 'Campo obligatorio.';
    }
    return null;
  }
}
