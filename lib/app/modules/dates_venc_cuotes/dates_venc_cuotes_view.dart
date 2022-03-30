import 'package:car_system/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/theme/colors.dart';
import '../../core/utils/date_format.dart';
import '../../global_widgets/cuote_refuerzo/iscuote_render.dart';
import '../../global_widgets/cuote_refuerzo/isrefuerzo_render.dart';
import '../../global_widgets/dialog.dart';
import '../../global_widgets/pay_dialog.dart';
import '../../global_widgets/responsive.dart';
import '../../global_widgets/spacing.dart';
import '../../global_widgets/textInputContainer.dart';
import '../sells/sells_from_collaborator_controller.dart';

class DatesVencCuotesView extends StatelessWidget {
  SellsFromCollaboratorController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    controller.filterCuoteOrRefuerzo();
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
    PageController pageController =
        PageController(initialPage: controller.selectedIndex.value);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fechas'),
        actions: [
          IconButton(
              onPressed: () => Get.toNamed(AppRoutes.EDIT_DATES),
              icon: Stack(
                children: const [
                  Icon(Icons.calendar_today_outlined),
                  Positioned.fill(
                    bottom: -5,
                    child: Align(
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.fiber_new_outlined,
                        size: 18,
                      ),
                    ),
                  )
                ],
              ),),
        ],
      ),
      body: SizedBox.expand(
        child: PageView(
          controller: pageController,
          onPageChanged: (index) => controller.selectedIndex.value = index,
          children: <Widget>[
            RefreshIndicator(
              onRefresh: () async => await controller.requestSales(),
              child: scroll(
                child: Cuotes(context),
              ),
            ),
            RefreshIndicator(
              onRefresh: () async => await controller.requestSales(),
              child: scroll(
                child: Refuerzos(context),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: const Icon(Icons.pending_outlined),
              label: 'Cuotas ${controller.listaCuotes.length.toString()}',
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.pending_outlined),
              label: 'Refuerzos ${controller.listaRefuerzos.length.toString()}',
            ),
          ],
          currentIndex: controller.selectedIndex.value,
          selectedItemColor: ColorPalette.PRIMARY,
          onTap: (index) {
            pageController.animateToPage(index,
                duration: const Duration(milliseconds: 350),
                curve: Curves.easeOut);
            controller.selectedIndex.value = index;
          },
        ),
      ),
    );
  }

  Widget scroll({required Widget child}) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [child],
      ),
    );
  }

  Widget Cuotes(context) {
    return Obx(
      () => controller.isLoading.value
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : isCuote(
              controller.listaCuotes,
              (selected) async {
                if (((selected.cuotaDolares ?? 0) -
                            (selected.pagoDolares ?? 0)) !=
                        0 ||
                    ((selected.cuotaGuaranies ?? 0) -
                            (selected.pagoGuaranies ?? 0)) !=
                        0) {
                  await payDialog(
                      controller, selected.idCuotaVenta, selected.idVenta,
                      fecha: DateFormatBr()
                          .formatBrFromString(selected.fechaCuota.toString()),
                      faltanteDolares: selected.cuotaDolares != null
                          ? ((selected.cuotaDolares ?? 0) -
                              (selected.pagoDolares ?? 0))
                          : null,
                      faltanteGuaranies: selected.cuotaGuaranies != null
                          ? ((selected.cuotaGuaranies ?? 0) -
                              (selected.pagoGuaranies ?? 0))
                          : null,
                      pagoGuaranies: (selected.pagoGuaranies ?? 0),
                      pagoDolares: (selected.pagoDolares ?? 0),
                      isCuote: true,
                      context: context);
                }
              },
              onEditDate: (i) async {
                controller.fechaPagoCuota.value = DateFormatBr()
                    .formatLocalFromString(
                        controller.listaCuotes[i].fechaCuota!);
                bool? resDialog = await dialogEditFecha(context, i);
                if (resDialog != null) {
                  if (resDialog) {
                    if (controller.fechaPagoCuota.value !=
                        DateFormatBr().formatLocalFromString(
                            controller.listaCuotes[i].fechaCuota!)) {
                      // CustomDialogFetch((i) async => print(i));
                    }
                  }
                }
              },
            ),
    );
  }

  Future dialogEditFecha(context, i) {
    return CustomDialog(
      context,
      body: Obx(
        () => Container(
          child: textInputContainer(
            'Fecha de venta:',
            DateFormatBr()
                .formatBrFromString(controller.fechaPagoCuota.value.toString()),
            onTap: () => controller.changeFechaCuota(context, i),
          ),
        ),
      ),
    );
  }

  Widget Refuerzos(context) {
    return Obx(
      () => controller.isLoading.value
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : isRefuerzo(controller.listaRefuerzos, (selected) async {
              if (((selected.refuerzoDolares ?? 0) -
                          (selected.pagoDolares ?? 0)) !=
                      0 ||
                  ((selected.refuerzoGuaranies ?? 0) -
                          (selected.pagoGuaranies ?? 0)) !=
                      0) {
                await payDialog(
                    controller, selected.idRefuerzoVenta, selected.idVenta,
                    fecha: DateFormatBr()
                        .formatBrFromString(selected.fechaRefuerzo.toString()),
                    faltanteDolares: selected.refuerzoDolares != null
                        ? ((selected.refuerzoDolares ?? 0) -
                            (selected.pagoDolares ?? 0))
                        : null,
                    faltanteGuaranies: selected.refuerzoGuaranies != null
                        ? ((selected.refuerzoGuaranies ?? 0) -
                            (selected.pagoGuaranies ?? 0))
                        : null,
                    pagoGuaranies: (selected.pagoGuaranies ?? 0),
                    pagoDolares: (selected.pagoDolares ?? 0),
                    isCuote: false,
                    context: context);
              }
            }),
    );
  }

  List<Widget> sectionTotal() {
    if (controller.isCuote.value) {
      return [
        Text(
          'Total Financiado: ' + controller.financiadoTotalStr.value,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        CustomSpacing(height: 6),
        Text(
          'Total Cuota: ' + controller.totalVentaCuotaStr.value,
        ),
        Text(
          'Cuota Pagado: ' + controller.totalPagadoCuotaStr.value,
          style: const TextStyle(color: ColorPalette.GREEN),
        ),
        Text(
          'Cuota Faltante: ' + controller.totalCuotaFaltanteStr.value,
          style: const TextStyle(color: ColorPalette.PRIMARY),
        )
      ];
    } else {
      return [
        Text(
          'Total Financiado: ' + controller.financiadoTotalStr.value,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        CustomSpacing(height: 6),
        Text('Total Refuerzo: ' + controller.totalVentaRefuerzoStr.value),
        Text(
          'Refuerzo Pagado: ' + controller.totalPagadoRefuerzoStr.value,
          style: const TextStyle(color: ColorPalette.GREEN),
        ),
        Text('Refuerzo faltante: ' + controller.totalRefuerzoFaltanteStr.value,
            style: const TextStyle(color: ColorPalette.PRIMARY))
      ];
    }
  }

  List<DataColumn> dataColumn() {
    return const <DataColumn>[
      DataColumn(
        label: Text(
          'Cuota / Venc.',
          softWrap: true,
          maxLines: 3,
          overflow: TextOverflow.visible,
        ),
      ),
      DataColumn(
        label: Text('Pago / Fecha'),
      ),
      DataColumn(
        label: Text('Pendiente'),
      ),
    ];
  }
}
