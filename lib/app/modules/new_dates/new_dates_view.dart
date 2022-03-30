import 'package:car_system/app/core/theme/colors.dart';
import 'package:car_system/app/global_widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/utils/date_format.dart';
import '../../global_widgets/input.dart';
import '../../global_widgets/responsive.dart';
import '../../global_widgets/search_dropdown.dart';
import '../../global_widgets/spacing.dart';
import '../../global_widgets/textInputContainer.dart';
import '../../global_widgets/title.dart';
import '../../routes/app_routes.dart';
import 'new_dates_controller.dart';

class NewDatesView extends StatelessWidget {
  NewDatesController controller = Get.find();

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
        title: const Text('Generar nuevas fechas'),
      ),
      body: Obx(() => controller.isLoading.value
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(8),
              child: ListView(
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomTitle('CUOTAS'),
                          textInputContainer(
                            'Fecha inicial:',
                            DateFormatBr().formatBrFromString(
                              controller.initialDateCuote.value.toString(),
                            ),
                            onTap: () =>
                                controller.changeInitialDateCuote(context),
                          ),
                          CustomSpacing(),
                          CustomInput('', 'Cantidad cuotas:',
                              textEditingController:
                                  controller.quantCuotesController,
                              onChanged: (value) =>
                                  controller.changeQuantCuotes(value)),
                          CustomInput(
                            '',
                            'Valor cuota:',
                            textEditingController: controller.isDolar.value
                                ? controller.textDolaresCuotas
                                : controller.textGuaraniesCuotas,
                            onChanged: (value) =>
                                controller.changeValueCuote(value),
                          ),
                          CustomTitle('REFUERZOS'),
                          CustomSpacing(height: 10),
                          CustomDropDowSearch(
                            controller.typesCobroMensuales,
                            'ENTRE MESES',
                            iconData: Icons.date_range,
                            selectedItem:
                                controller.typeCobroMensualSelected.value,
                            onChanged: (value) =>
                                controller.changeEntreMeses(value),
                          ),
                          CustomSpacing(height: 7),
                          textInputContainer(
                            'Fecha inicial:',
                            DateFormatBr().formatBrFromString(
                              controller.initialDateRefuerzo.value.toString(),
                            ),
                            onTap: () =>
                                controller.changeInitialDateRefuerzo(context),
                          ),
                          CustomSpacing(),
                          CustomInput('', 'Cantidad Refuerzos:',
                              textEditingController:
                                  controller.quantRefuerzosController,
                              onChanged: (value) =>
                                  controller.changeQuantRefuerzos(value)),
                          CustomInput('', 'Valor refuerzo:',
                              textEditingController: controller.isDolar.value
                                  ? controller.textDolaresRefuerzos
                                  : controller.textGuaraniesRefuerzos,
                              onChanged: (value) =>
                                  controller.changeValueRefuerzo(value)),
                          CustomButton(
                              'VER FECHAS GENERADAS',
                              () => Get.toNamed(AppRoutes.DATES_VEN),
                              ColorPalette.SECUNDARY)
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )),
    );
  }
}
