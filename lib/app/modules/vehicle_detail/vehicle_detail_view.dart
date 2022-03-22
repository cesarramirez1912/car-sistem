import '../../core/theme/colors.dart';
import '../../global_widgets/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/models/cuotes.dart';
import '../../global_widgets/button.dart';
import '../../global_widgets/plan.dart';
import '../../global_widgets/title.dart';
import '../../global_widgets/vehicle_details.dart';
import '../../routes/app_routes.dart';
import 'vehicle_detail_controller.dart';

class VehicleDetailView extends GetView<VehicleDetailController> {
  const VehicleDetailView({Key? key}) : super(key: key);

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
        title: const Text('Detalles'),
      ),
      body: Obx(() => Responsive(
            desktop: desktop(context),
            tablet: tablet(context),
            mobile: mobile(context),
          )),
    );
  }

  Widget desktop(context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(20),
        width: 1100,
        child: rowTabletDesktop(context),
      ),
    );
  }

  Widget tablet(context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(20),
        width: 750,
        child: rowTabletDesktop(context),
      ),
    );
  }

  Widget rowTabletDesktop(context) {
    return Row(
      children: [
        Flexible(
          child: SingleChildScrollView(
            child: Column(
              children: [
                VehicleDetails(controller.vehicles.first, heithImage: 320),
                eliminarButton(context),
                venderButton(),
              ],
            ),
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        Flexible(
          child: ListView.builder(
            controller: ScrollController(),
            itemCount: controller.vehicles.value.length,
            itemBuilder: (BuildContext context, int index) {
              Cuota cuota = Cuota.fromJson(controller.vehicles[index].toJson());
              if (cuota.cantidadCuotas != null) {
                return CustomPlan(
                  index,
                  cuota,
                  onPressed: () async => await controller.deletePlan(
                      context, cuota.idCuota!, index + 1),
                  showTotal: true,
                );
              } else {
                return Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(bottom: 10),
                    child: const Text('Sin planes para este vehiculo.'));
              }
            },
          ),
        ),
      ],
    );
  }

  Widget mobile(context) {
    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.only(bottom: 5),
        child: Column(
          children: [
            VehicleDetails(controller.vehicles.first),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Divider(
                    color: Colors.grey,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTitle('PLANES DE FINANCIACIÓN'),
                  const SizedBox(
                    height: 10,
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller.vehicles.value.length,
                        itemBuilder: (BuildContext context, int index) {
                          Cuota cuota = Cuota.fromJson(
                              controller.vehicles[index].toJson());
                          if (cuota.cantidadCuotas != null) {
                            return CustomPlan(index, cuota,
                                onPressed: () async =>
                                    await controller.deletePlan(
                                        context, cuota.idCuota!, index + 1),
                                showTotal: true);
                          } else {
                            return Container(
                                alignment: Alignment.center,
                                margin: const EdgeInsets.only(bottom: 10),
                                child: const Text(
                                    'Sin planes para este vehiculo.'));
                          }
                        },
                      ),
                      eliminarButton(context),
                      venderButton()
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget eliminarButton(BuildContext context) =>
      CustomButton('ELIMINAR VEHICULO', () {
        controller.deleteVehicle(context);
      }, ColorPalette.PRIMARY);

  Widget venderButton() => CustomButton('VENDER VEHICULO', () {
        controller.seletVehicleToSel();
        Get.toNamed(AppRoutes.SEL_VEHICLE);
      }, ColorPalette.GREEN);
}
