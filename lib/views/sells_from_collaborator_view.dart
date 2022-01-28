import 'package:car_system/colors.dart';
import 'package:car_system/common/date_format.dart';
import 'package:car_system/common/money_format.dart';
import 'package:car_system/controllers/sells_from_collaborator_controller.dart';
import 'package:car_system/models/sale_collaborator_model.dart';
import 'package:car_system/route_manager.dart';
import 'package:car_system/widgets/button.dart';
import 'package:car_system/widgets/search_dropdown.dart';
import 'package:car_system/widgets/spacing.dart';
import 'package:car_system/widgets/title.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class SellsFromCollaboratorView extends StatelessWidget {
  SellsFromCollaboratorController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            alignment: Alignment.topLeft,
            margin: const EdgeInsets.only(right: 10, left: 10, bottom: 10),
            decoration: const BoxDecoration(
                color: Color.fromRGBO(248, 248, 248, 1),
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                )),
            child: TextFormField(
              autofocus: false,
              onChanged: (text) {
                controller.salesAux.value = controller.sales
                    .where((p0) =>
                        p0.modelo!.contains(text.toUpperCase()) ||
                        p0.cliente!.contains(text.toUpperCase()) ||
                        p0.marca!.contains(text.toUpperCase()))
                    .toList();
              },
              decoration: const InputDecoration(
                hintText: 'Cliente, marca o modelo',
                border: InputBorder.none,
                suffixIcon: Icon(Icons.search),
              ),
            ),
          ),
        ),
        title: const Text('Mis ventas'),
      ),
      body: RefreshIndicator(
        onRefresh: () => controller.requestSales(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Obx(
            () => Column(
              children: [
                CustomDropDowSearch(controller.listString.value, '',
                    iconData: Icons.filter_alt_outlined, onChanged: (value) {
                  controller.textString.value = value;
                  controller.filterList();
                }, selectedItem: controller.textString.value),
                CustomSpacing(height: 8),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ...controller.salesAux.map(
                          (e) => Card(
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  CustomTitle('CLIENTE', fontSize: 15),
                                  CustomTitle(e.cliente.toString(),
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600),
                                  CustomTitle('VEHICULO', fontSize: 15),
                                  CustomTitle(
                                      e.marca.toString() +
                                          ' - ' +
                                          e.modelo.toString(),
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600),
                                  CustomTitle('FECHA Y HORA DE VENTA',
                                      fontSize: 15),
                                  CustomTitle(
                                      DateFormatBr().formatBrWithTime(
                                          e.fechaVenta.toString()),
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600),
                                  const Divider(
                                    color: Colors.grey,
                                  ),
                                  render(e, controller),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget render(
    SaleCollaboratorModel e, SellsFromCollaboratorController controller) {
  if (e.contadoGuaranies != null || e.contadoDolares != null) {
    String precioFormat = '';
    if (e.contadoDolares != null) {
      precioFormat =
          MoneyFormat().formatCommaToDot(e.contadoDolares, isGuaranies: false);
    } else {
      precioFormat = MoneyFormat().formatCommaToDot(e.contadoGuaranies);
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTitle('PRECIO VENDIDO', fontSize: 15),
        CustomTitle(precioFormat, fontSize: 13, fontWeight: FontWeight.w600),
      ],
    );
  } else {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          color: Colors.white,
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTitle('CUOTAS', fontSize: 14),
                    CustomTitle('TOTAL: ' + e.cantidadCuotas,
                        fontSize: 13, fontWeight: FontWeight.w600),
                    CustomTitle('PAGADOS: ' + e.cantidadCuotasPagadas,
                        fontSize: 13, fontWeight: FontWeight.w600),
                    CustomTitle(
                        'FALTANTES: ' +
                            (int.parse(e.cantidadCuotas) -
                                    int.parse(e.cantidadCuotasPagadas))
                                .toString(),
                        fontSize: 13,
                        fontWeight: FontWeight.w600),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTitle('REFUERZOS', fontSize: 14),
                    CustomTitle('TOTAL: ' + e.cantidadRefuerzos,
                        fontSize: 13, fontWeight: FontWeight.w600),
                    CustomTitle('PAGADOS: ' + e.cantidadRefuerzosPagados,
                        fontSize: 13, fontWeight: FontWeight.w600),
                    CustomTitle(
                        'FALTANTES: ' +
                            (int.parse(e.cantidadRefuerzos) -
                                    int.parse(e.cantidadRefuerzosPagados))
                                .toString(),
                        fontSize: 13,
                        fontWeight: FontWeight.w600),
                  ],
                ),
              )
            ],
          ),
        ),
        CustomSpacing(height: 8),
        (int.parse(e.cantidadCuotas) - int.parse(e.cantidadCuotasPagadas)) >
                    0 ||
                (int.parse(e.cantidadRefuerzos) -
                        int.parse(e.cantidadRefuerzosPagados)) >
                    0
            ? const Divider(
                color: Colors.grey,
              )
            : Container(),
        CustomSpacing(height: 8),
        (int.parse(e.cantidadCuotas) - int.parse(e.cantidadCuotasPagadas)) >
                    0 ||
                (int.parse(e.cantidadRefuerzos) -
                        int.parse(e.cantidadRefuerzosPagados)) >
                    0
            ? CustomButton('PAGAR CUOTA O REFUERZO', () {
                controller.queryListRefuerzos(e.idVenta);
                controller.queryListCuotes(e.idVenta);
                Get.toNamed(RouterManager.SELLS_DETAILS_CUOTES);
              }, ColorPalette.GREEN)
            : Container()
      ],
    );
  }
}
