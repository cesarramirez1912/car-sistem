import 'package:car_system/colors.dart';
import 'package:car_system/common/money_format.dart';
import 'package:car_system/controllers/dash_controller.dart';
import 'package:car_system/responsive.dart';
import 'package:car_system/views/dash/chart_bar_secondary_view.dart';
import 'package:car_system/widgets/menu_drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

List<String> months = [
  'Enero',
  'Febrero',
  'Marzo',
  'Abril',
  'Mayo',
  'Junio',
  'Julio',
  'Agosto',
  'Septiembre',
  'Octubre',
  'Noviembre',
  'Diciembre'
];

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
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 20),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'En abierto cobrado',
                                        style: TextStyle(
                                          color: ColorPalette.GRAY_TITLE,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        MoneyFormat().formatCommaToDot(
                                                controller.totalMes.value
                                                        .pagoGuaranies ??
                                                    0) +
                                            ' +',
                                        style: const TextStyle(
                                          letterSpacing: -1.2,
                                          fontSize: 18,
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
                                          fontSize: 18,
                                          height: 1.2,
                                          fontWeight: FontWeight.bold,
                                          color: ColorPalette.BLACK_TITLE,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 18,
                                      ),
                                      const Text(
                                        'Este mes',
                                        style: TextStyle(
                                          color: ColorPalette.GRAY_TITLE,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 20),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Negocios cerrados',
                                        style: TextStyle(
                                          color: ColorPalette.GRAY_TITLE,
                                        ),
                                      ),
                                      Text(
                                        controller.totalVendidoMes.value
                                                    .count ==
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
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      const Text(
                                        'Este mes',
                                        style: TextStyle(
                                          color: ColorPalette.GRAY_TITLE,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Cuotas del mes',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: ColorPalette.BLACK_TITLE,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 200,
                                  child: CircularPercentIndicator(
                                    radius: 180.0,
                                    lineWidth: 30.0,
                                    percent: (((controller.totalCuotaPago?.value
                                                .totalPagado ??
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
                                          months[controller.monthInt - 1],
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
                                  'Cuotas por mes',
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
                                        ColorPalette.GRAY_LIGTH300, 'Cuotas'),
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
        drawer: Obx(() => CustomMenuDrawer()));
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
