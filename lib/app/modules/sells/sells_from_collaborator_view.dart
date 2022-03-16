import 'package:car_system/app/routes/app_routes.dart';
import '../../core/theme/colors.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../core/utils/date_format.dart';
import '../../core/utils/money_format.dart';
import '../../data/models/sale_collaborator_model.dart';
import '../../global_widgets/button.dart';
import '../../global_widgets/responsive.dart';
import '../../global_widgets/search_dropdown.dart';
import '../../global_widgets/search_input.dart';
import '../../global_widgets/spacing.dart';
import '../../global_widgets/title.dart';
import 'sells_from_collaborator_controller.dart';

class SellsFromCollaboratorView extends GetView<SellsFromCollaboratorController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: CustomSearchInput(
            hintText: 'Cliente, marca o modelo',
            onClean: () => controller.salesAux.value = controller.sales,
            controller: TextEditingController(),
            onChanged: (text) {
              controller.salesAux.value = controller.sales
                  .where((p0) =>
                      p0.modelo!.contains(text.toUpperCase()) ||
                      p0.cliente!.contains(text.toUpperCase()) ||
                      p0.marca!.contains(text.toUpperCase()))
                  .toList();
            },
          ),
        ),
        title: const Text('Mis ventas'),
      ),
      body: RefreshIndicator(
        onRefresh: () => controller.requestSales(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Obx(
            () => Responsive(
                mobile: mobile(), tablet: tablet(900), desktop: tablet(1100)),
          ),
        ),
      ),
    );
  }

  Widget tablet(double width) {
    return principalRender(
      Expanded(
        child: Container(
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            child: SizedBox(
              width: width,
              child: Center(
                child: Wrap(
                  children: [
                    ...controller.salesAux.map((e) =>
                        SizedBox(width: 350, height: 400, child: cardSell(e)))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget mobile() {
    return principalRender(
      Expanded(
        child: SingleChildScrollView(
          child: Column(
            children: [...controller.salesAux.map((e) => cardSell(e))],
          ),
        ),
      ),
    );
  }

  Widget principalRender(Widget body) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        CustomDropDowSearch(controller.listString.value, '',
            iconData: Icons.filter_alt_outlined, onChanged: (value) {
          controller.textString.value = value;
          controller.filterList();
        }, selectedItem: controller.textString.value),
        CustomSpacing(height: 8),
        body
      ],
    );
  }

  Widget cardSell(SaleCollaboratorModel e) {
    return GestureDetector(
      onTap: () => Get.toNamed(AppRoutes.CLIENT_DETAIL_VIEW,
          parameters:  e.toJson().map((key, value) => MapEntry(key, value.toString()))),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomTitle('CLIENTE', fontSize: 15),
              CustomTitle(e.cliente.toString(),
                  fontSize: 13, fontWeight: FontWeight.w600),
              CustomTitle('VEHICULO', fontSize: 15),
              CustomTitle(e.marca.toString() + ' - ' + e.modelo.toString(),
                  fontSize: 13, fontWeight: FontWeight.w600),
              e.contadoGuaranies == null && e.contadoDolares == null
                  ? CustomTitle('ENTREGA', fontSize: 15)
                  : Container(),
              e.contadoGuaranies == null && e.contadoDolares == null
                  ? CustomTitle(
                      e.entradaDolares == null && e.entradaGuaranies == null
                          ? '0'
                          : e.entradaGuaranies == null
                              ? MoneyFormat().formatCommaToDot(e.entradaDolares,
                                  isGuaranies: false)
                              : MoneyFormat()
                                  .formatCommaToDot(e.entradaGuaranies),
                      fontSize: 13,
                      fontWeight: FontWeight.w600)
                  : Container(),
              CustomTitle('FECHA Y HORA DE VENTA', fontSize: 15),
              CustomTitle(
                  DateFormatBr().formatBrWithTime(e.fechaVenta.toString()),
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
                Get.toNamed(AppRoutes.SELLS_DETAILS_CUOTES);
              }, ColorPalette.GREEN)
            : Container()
      ],
    );
  }
}
