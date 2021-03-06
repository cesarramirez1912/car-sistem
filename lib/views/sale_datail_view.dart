import 'package:car_system/common/money_format.dart';
import 'package:car_system/controllers/sale_detail_controller.dart';
import 'package:car_system/controllers/sells_from_collaborator_controller.dart';
import 'package:car_system/models/register_client_model.dart';
import 'package:car_system/models/sale_collaborator_model.dart';
import 'package:car_system/models/vehicle.dart';
import 'package:car_system/widgets/client_body.dart';
import 'package:car_system/widgets/spacing.dart';
import 'package:car_system/widgets/title.dart';
import 'package:car_system/widgets/vehicle_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../colors.dart';
import '../responsive.dart';
import '../route_manager.dart';
import '../widgets/button.dart';

class SaleDetailView extends StatelessWidget {
  SaleDetailController controller = Get.put(SaleDetailController());
  SellsFromCollaboratorController sellsController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Responsive(
      tablet: Center(
        child: Container(
            alignment: Alignment.center,
            width: 900,
            child: principal()),
      ),
      desktop: Center(
        child: Container(
            alignment: Alignment.center,
            width: 900,
            child: principal()),
      ),
      mobile: principal(),
    );
  }

  Widget principal() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalles de la venta'),
      ),
      body: SingleChildScrollView(
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                CustomSpacing(),
                                CustomTitle('Precio negociado'),
                                CustomSpacing(),
                                const Divider(
                                  height: 2,
                                  color: Colors.grey,
                                ),
                                CustomSpacing(),
                                price(controller.saleCollaborator.value),
                                CustomSpacing(),
                                controller.saleCollaborator.value
                                                .contadoGuaranies !=
                                            null ||
                                        controller.saleCollaborator.value
                                                .contadoDolares !=
                                            null
                                    ? Container()
                                    : conditionalButton()
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                CustomSpacing(),
                                CustomTitle('Vehiculo'),
                                CustomSpacing(),
                                const Divider(
                                  height: 2,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                          ),
                          VehicleDetails(
                              Vehicle.fromJson(
                                  controller.saleCollaborator.value.toJson()),
                              withImage: false,
                              withPrice: false)
                        ],
                      ),
                    ),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            CustomSpacing(),
                            CustomTitle('Cliente'),
                            CustomSpacing(),
                            const Divider(
                              height: 2,
                              color: Colors.grey,
                            ),
                            CustomSpacing(),
                            ClientBody(ClientModel.fromJson(
                                controller.saleCollaborator.value.toJson()))
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget price(SaleCollaboratorModel sale) {
    return sale.contadoGuaranies != null || sale.contadoDolares != null
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _custTitle('Contado'),
              _custTitle(
                  sale.contadoDolares != null
                      ? MoneyFormat().formatCommaToDot(sale.contadoDolares,
                          isGuaranies: false)
                      : MoneyFormat().formatCommaToDot(sale.contadoGuaranies),
                  size: 20,
                  fontWeight: FontWeight.bold),
            ],
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              custTitle('Entrega'),
              sale.entradaDolares != null || sale.entradaGuaranies != null
                  ? suBtitle(
                      sale.entradaDolares != null
                          ? MoneyFormat().formatCommaToDot(sale.entradaDolares,
                              isGuaranies: false)
                          : MoneyFormat()
                              .formatCommaToDot(sale.entradaGuaranies),
                    )
                  : suBtitle('Sin entrega'),
              custTitle('Cuotas'),
              suBtitle(sale.cantidadCuotas.toString() +
                  ' x ' +
                  (sale.cuotaDolares != null
                      ? MoneyFormat().formatCommaToDot(sale.cuotaDolares,
                          isGuaranies: false)
                      : MoneyFormat().formatCommaToDot(sale.cuotaGuaranies))),
              custTitle('Refuerzos'),
              suBtitle(
                (sale.cantidadRefuerzos != 0
                    ? sale.cantidadRefuerzos.toString() +
                        ' x ' +
                        (sale.refuerzoDolares != null
                            ? MoneyFormat().formatCommaToDot(
                                sale.refuerzoDolares,
                                isGuaranies: false)
                            : MoneyFormat()
                                .formatCommaToDot(sale.refuerzoGuaranies))
                    : 'Sin refuerzos'),
              ),
            ],
          );
  }

  Widget conditionalButton() {
    return Column(children: [
      const Divider(
        height: 2,
        color: Colors.grey,
      ),
      CustomSpacing(height: 8),
      CustomButton('FECHAS', () {
        sellsController
            .queryListRefuerzos(controller.saleCollaborator.value.idVenta);
        sellsController
            .queryListCuotes(controller.saleCollaborator.value.idVenta);
        Get.toNamed(RouterManager.SELLS_DETAILS_CUOTES, parameters: {
          'idVenta': controller.saleCollaborator.value.idVenta.toString()
        });
      }, ColorPalette.GREEN),
    ]);
  }

  Widget _custTitle(text,
      {double size = 15, FontWeight fontWeight = FontWeight.w500}) {
    return CustomTitle(text, fontWeight: fontWeight, fontSize: size);
  }
}
