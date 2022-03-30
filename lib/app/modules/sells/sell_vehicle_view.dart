import 'package:car_system/app/data/enums/types_moneys.dart';
import 'package:car_system/app/data/enums/types_sells.dart';
import 'package:car_system/app/modules/sells/local_widget/plan_dialog_widget.dart';
import 'package:car_system/app/modules/sells/sells_from_collaborator_controller.dart';
import 'package:car_system/app/routes/app_routes.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:get/get.dart';
import '../../core/theme/colors.dart';
import '../../core/utils/date_format.dart';
import '../../core/utils/remove_money_format.dart';
import '../../core/utils/user_storage_controller.dart';
import '../../data/models/register_client_model.dart';
import '../../global_widgets/button.dart';
import '../../global_widgets/dialog_fetch.dart';
import '../../global_widgets/input.dart';
import '../../global_widgets/plan.dart';
import '../../global_widgets/responsive.dart';
import '../../global_widgets/search_dropdown.dart';
import '../../global_widgets/snack_bars/snack_bar_success.dart';
import '../../global_widgets/spacing.dart';
import '../../global_widgets/textInputContainer.dart';
import '../../global_widgets/title.dart';
import '../../global_widgets/vehicle_detail_card.dart';
import '../client/client_controller.dart';
import '../list_vehicles/list_vehicle_controller.dart';
import 'package:flutter/material.dart';

import '../vehicle_detail/vehicle_detail_controller.dart';
import 'local_widget/select_plan_dialog_widget.dart';

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
    return Responsive(
        mobile: principal(context),
        tablet: Center(
          child: Container(
              alignment: Alignment.center,
              width: 900,
              child: principal(context)),
        ),
        desktop: Center(
          child: Container(
              alignment: Alignment.center,
              width: 900,
              child: principal(context)),
        ));
  }

  Widget principal(context) {
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
                            validator: (u) {
                              if (u?.idCliente == null) {
                                return "CLIENTE OBLIGATORIO PARA LA VENTA";
                              } else {
                                return null;
                              }
                            },
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
                              await Get.toNamed(AppRoutes.REGISTER_CLIENT);
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
                    CustomTitle('FECHA'),
                    textInputContainer(
                      'Fecha de venta:',
                      DateFormatBr().formatBrFromString(
                          controller.dateFromSell.value.toString()),
                      onTap: () => controller.changeDateFromSell(context),
                    ),
                    CustomSpacing(),
                    const Divider(
                      color: Colors.grey,
                    ),
                    CustomSpacing(),
                    CustomTitle('FILTROS'),
                    CustomSpacing(),
                    CustomDropDowSearch(
                        controller.listTypesSells(), 'ELEGIR TIPO DE VENTA',
                        iconData: controller.typeSellSelected.value ==
                                TypesSells.CONTADO
                            ? Icons.money
                            : Icons.credit_card_sharp,
                        selectedItem: controller.typeSellSelected.value.name,
                        onChanged: (value) {
                      controller.cleanInputsCuotes();
                      if (value == TypesSells.FINANCIADO) {
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
                      controller.typeSellSelected.value = TypesSells.values
                          .firstWhere((e) => e.name.toString() == value);
                    }),
                    CustomSpacing(),
                    CustomDropDowSearch(
                      controller.listTypesMoney(),
                      'ELEGIR TIPO DE MONEDA',
                      iconData: Icons.monetization_on_outlined,
                      selectedItem: controller.typesMoneySelected.value.name,
                      onChanged: (value) {
                        controller.cleanInputsCuotes();
                        if (value == TypesMoneys.GUARANIES) {
                          controller.datesVencController.changeIsDolar(false);
                          controller.cuota.value.cuotaDolares = null;
                        } else {
                          controller.datesVencController.changeIsDolar(true);
                          controller.cuota.value.cuotaGuaranies = null;
                        }
                        controller.typesMoneySelected.value = TypesMoneys.values
                            .firstWhere((e) => e.name.toString() == value);
                      },
                    ),
                    CustomSpacing(),
                    CustomTitle('PRECIO FINAL'),
                    CustomSpacing(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: listRender(context),
                    ),
                    conditionalRenderButton()
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget conditionalRenderButton() {
    double _contadoGuaranies = RemoveMoneyFormat()
        .removeToDouble(controller.textContadoGuaranies.text);
    double _contadoDolares =
        RemoveMoneyFormat().removeToDouble(controller.textContadoDolares.text);

    bool returnButton = controller.conditionalPlan();
    if (controller.typeSellSelected.value == TypesSells.CONTADO) {
      if (controller.typesMoneySelected.value == TypesMoneys.DOLARES) {
        if (_contadoDolares > 0.0) {
          returnButton = true;
        }
      } else {
        if (_contadoGuaranies > 0.0) {
          returnButton = true;
        }
      }
    }

    if (controller.typeClientSelected.value.idCliente == null) {
      returnButton = false;
    }

    return returnButton
        ? CustomButton('FINALIZAR VENTA', () async {
            bool res = false;
            CustomDialogFetch(() async {
              res = await controller.registerSale();
            }, text: 'REGISTRANDO NUEVA VENTA')
                .then((value) async {
              if (res) {
                CustomSnackBarSuccess('VENTA REGISTRADA CON EXITO!');
                await Future.delayed(const Duration(seconds: 1));
                Get.offAllNamed(AppRoutes.DASH);
              }
            });
          }, ColorPalette.GREEN)
        : Container();
  }

  List<Widget> listRender(BuildContext context) {
    switch (controller.typeSellSelected.value) {
      case TypesSells.CONTADO:
        return [
          CustomInput(
              '', 'PRECIO VENTA ${controller.typesMoneySelected.value.name}',
              isNumber: true,
              iconData: Icons.price_change_outlined,
              onChanged: (text) {
                if (controller.typesMoneySelected.value ==
                    TypesMoneys.GUARANIES) {
                  if (text.toString().length < 4) {
                    controller.textContadoGuaranies.updateValue(0);
                  }
                }
              },
              validator: (text) {
                double valueDouble = RemoveMoneyFormat().removeToDouble(text);
                if (valueDouble == 0.0) {
                  return 'Campo obligatorio';
                } else {
                  return null;
                }
              },
              onSaved: (text) => controller.typesMoneySelected.value ==
                      TypesMoneys.GUARANIES
                  ? {
                      controller.sellVehicleModel.value.contadoGuaranies = text,
                      controller.sellVehicleModel.value.contadoDolares = null
                    }
                  : {
                      controller.sellVehicleModel.value.contadoDolares = text,
                      controller.sellVehicleModel.value.contadoGuaranies = null
                    },
              textEditingController:
                  controller.typesMoneySelected.value == TypesMoneys.GUARANIES
                      ? (controller.textContadoGuaranies)
                      : controller.textContadoDolares),
        ];
      case TypesSells.FINANCIADO:
        return [
          CustomPlan(0, controller.cuota.value,
              textRender: controller.typesMoneySelected.value.name,
              showTotal: true,
              showDolares:
                  controller.typesMoneySelected.value == TypesMoneys.DOLARES,
              showGuaranies:
                  controller.typesMoneySelected.value == TypesMoneys.GUARANIES,
              withTitle: false),
          (controller.vehicleSelected.first.cantidadCuotas == null ||
                  controller.vehicleSelected.first.cantidadCuotas == 0)
              ? Container()
              : expanded(CustomButton('ELEGIR PLAN', () async {
                  bool? selectPlan =
                      await selectPlanDialog(controller, context);
                }, ColorPalette.YELLOW,
                  iconData: Icons.list, isLoading: controller.isLoading.value)),
          expanded(CustomButton('NUEVO PLAN', () async {
            controller.setCuoteInDialog();
            bool? responseDialog = await dialogPlanSell(controller, context);
          }, ColorPalette.SECUNDARY,
              iconData: Icons.post_add, isLoading: controller.isLoading.value)),
          CustomSpacing(),
          controller.cuota.value.cantidadCuotas == null ||
                  controller.cuota.value.cantidadCuotas == 0
              ? Container()
              : vencimientosSection(context),
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
        const Divider(
          color: Colors.grey,
        ),
        CustomSpacing(),
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
                  controller.datesVencController.changeSelectedIndex(0);
                  Get.toNamed(AppRoutes.DATES_VEN);
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
                            controller.datesVencController.changeSelectedIndex(1);
                            Get.toNamed(AppRoutes.DATES_VEN);
                          }, ColorPalette.SECUNDARY,
                              iconData: Icons.calendar_today_rounded),
                        ],
                      )
                    ],
                  ),
                  CustomSpacing(),
                  const Divider(
                    color: Colors.grey,
                  ),
                  CustomSpacing()
                ],
              ),
      ],
    );
  }

  Widget expanded(Widget body) {
    return Row(
      children: [Expanded(child: body)],
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
