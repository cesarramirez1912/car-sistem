import 'package:car_system/app/modules/dash/chart_bar_secondary_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../../core/theme/colors.dart';
import '../../core/utils/money_format.dart';
import '../../core/utils/months.dart';
import '../../global_widgets/menu_drawer.dart';
import '../../global_widgets/responsive.dart';
import 'dash_controller.dart';


class DashView extends GetView<DashController> {
  @override
  Widget build(BuildContext context) {
    return Responsive(
      mobile: principal(context),
      tablet: Center(
        child: Container(
            alignment: Alignment.center, width: 900, child: principal(context)),
      ),
      desktop: Center(
        child: Container(
            alignment: Alignment.center, width: 900, child: principal(context)),
      ),
    );
  }

  Widget principal(context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Dashboard'),
          actions: [
            Responsive.isTablet(context) || Responsive.isDesktop(context)
                ? IconButton(
                    onPressed: () async {
                      controller.isLoading.value = true;
                      await controller.requestTotalMes();
                      controller.isLoading.value = false;
                    },
                    icon: const Icon(Icons.refresh))
                : Container(),
          ],
        ),
        body: Obx(
          () => controller.isLoading.value
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : RefreshIndicator(
                  onRefresh: () => controller.requestTotalMes(),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: [
                              Expanded(
                                child: cardRow(
                                    textHeader: 'Total Venta',
                                    textBottom: 'Este mes',
                                    body: [
                                      Text(
                                        MoneyFormat().formatCommaToDot(
                                                controller.totalVentaMes.value
                                                        .ventaGuaranies ??
                                                    0) +
                                            ' +',
                                        style: const TextStyle(
                                          letterSpacing: -1.2,
                                          fontSize: 26,
                                          height: 1,
                                          fontWeight: FontWeight.bold,
                                          color: ColorPalette.BLACK_TITLE,
                                        ),
                                      ),
                                      Text(
                                        MoneyFormat().formatCommaToDot(
                                            controller.totalVentaMes.value
                                                    .ventaDolares ??
                                                0,
                                            isGuaranies: false),
                                        style: const TextStyle(
                                          letterSpacing: -1.2,
                                          fontSize: 26,
                                          height: 1.2,
                                          fontWeight: FontWeight.bold,
                                          color: ColorPalette.BLACK_TITLE,
                                        ),
                                      ),
                                    ]),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: cardRow(
                                    textHeader: 'Total Cobrado',
                                    textBottom: 'Este mes',
                                    body: [
                                      Text(
                                        MoneyFormat().formatCommaToDot(
                                                controller.totalMes.value
                                                        .pagoGuaranies ??
                                                    0) +
                                            ' +',
                                        style: const TextStyle(
                                          letterSpacing: -1.2,
                                          fontSize: 26,
                                          height: 1,
                                          fontWeight: FontWeight.bold,
                                          color: ColorPalette.BLACK_TITLE,
                                        ),
                                      ),
                                      Text(
                                        MoneyFormat().formatCommaToDot(
                                            controller.totalMes.value
                                                    .pagoDolares ??
                                                0,
                                            isGuaranies: false),
                                        style: const TextStyle(
                                          letterSpacing: -1.2,
                                          fontSize: 26,
                                          height: 1.2,
                                          fontWeight: FontWeight.bold,
                                          color: ColorPalette.BLACK_TITLE,
                                        ),
                                      ),
                                    ]),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                  child: cardRow(
                                      textHeader: 'Negocios cerrados',
                                      textBottom: 'Este mes',
                                      body: [
                                    Text(
                                      controller.totalVendidoMes.value.count ==
                                              null
                                          ? '0'
                                          : controller
                                              .totalVendidoMes.value.count
                                              .toString(),
                                      style: const TextStyle(
                                        letterSpacing: -1.2,
                                        fontSize: 40,
                                        fontWeight: FontWeight.bold,
                                        color: ColorPalette.BLACK_TITLE,
                                      ),
                                    ),
                                  ])),
                            ],
                          ),
                          Card(
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Cuotas del mes: ${controller.totalCuotaPago?.value.totalCuotas}',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        fontSize: 20,
                                        color: ColorPalette.BLACK_TITLE,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 200,
                                    child: CircularPercentIndicator(
                                      radius: 180.0,
                                      lineWidth: 30.0,
                                      percent: (((controller.totalCuotaPago
                                                  ?.value.totalPagado ??
                                              0) /
                                          (controller.totalCuotaPago?.value
                                                  .totalCuotas ??
                                              1))),
                                      animation: true,
                                      center: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                           Months().monthsFromNumber[controller.monthInt - 1],
                                            style: const TextStyle(
                                                color: ColorPalette.BLACK_TITLE,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const Text(
                                            "Cobrados:",
                                            style: TextStyle(
                                                color: ColorPalette.GREEN,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            ((((controller.totalCuotaPago?.value
                                                                    .totalPagado ??
                                                                0) /
                                                            (controller
                                                                    .totalCuotaPago
                                                                    ?.value
                                                                    .totalCuotas ??
                                                                1))) *
                                                        100)
                                                    .toStringAsFixed(2) +
                                                '%',
                                            style: const TextStyle(
                                                color: ColorPalette.GREEN,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      progressColor: ColorPalette.GREEN,
                                      backgroundColor: ColorPalette.GRAY_LIGTH,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Card(
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                children: [
                                  const Text(
                                    'Cuotas + refuerzos por mes',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: ColorPalette.BLACK_TITLE,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 200,
                                    child: BarChartWithSecondaryAxis(
                                        controller.createBars()),
                                  ),
                                  Text(
                                    'Meses - ${controller.year}',
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      _descriptionBar(
                                          ColorPalette.GRAY_LIGTH300, '(Cuotas + refuerzos)'),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      _descriptionBar(
                                          ColorPalette.GREEN, 'Cobrados'),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
        ),
        drawer: Obx(() => CustomMenuDrawer()));
  }

  cardRow({String? textHeader, List<Widget>? body, String? textBottom}) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              textHeader ?? '',
              style: const TextStyle(
                color: ColorPalette.GRAY_TITLE,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ...?body,
            const SizedBox(
              height: 18,
            ),
            Text(
              textBottom ?? '',
              style: const TextStyle(
                color: ColorPalette.GRAY_TITLE,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _descriptionBar(Color color, String text) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2), color: color),
          margin: const EdgeInsets.only(right: 5),
        ),
        Text(text)
      ],
    );
  }
}
