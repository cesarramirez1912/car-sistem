import 'package:car_system/colors.dart';
import 'package:car_system/responsive.dart';
import 'package:car_system/route_manager.dart';
import 'package:car_system/widgets/button.dart';
import 'package:car_system/widgets/plan.dart';
import 'package:car_system/widgets/title.dart';
import 'package:car_system/widgets/vehicle_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/models/cuotes.dart';
import 'vehicle_detail_controller.dart';

class VehicleDetailView extends GetView<VehicleDetailController> {
  @override
  Widget build(BuildContext context) {
    return Responsive(
      mobile: principal(),
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
    );
  }

  Widget principal() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalles'),
      ),
      body: Obx(() => Responsive(
            desktop: desktop(),
            tablet: tablet(),
            mobile: mobile(),
          )),
    );
  }

  Widget desktop() {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(20),
        width: 1100,
        child: Row(
          children: [
            Flexible(
              child: Column(
                children: [
                  VehicleDetails(controller.vehicles.first, heithImage: 320),
                  venderButton()
                ],
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
                  Cuota cuota =
                      Cuota.fromJson(controller.vehicles[index].toJson());
                  if (cuota.cantidadCuotas != null) {
                    return CustomPlan(index, cuota);
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
        ),
      ),
    );
  }

  Widget tablet() {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(20),
        width: 750,
        child: Row(
          children: [
            Flexible(
              child: Column(
                children: [
                  VehicleDetails(controller.vehicles.first, heithImage: 320),
                  venderButton()
                ],
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
                  Cuota cuota =
                      Cuota.fromJson(controller.vehicles[index].toJson());
                  if (cuota.cantidadCuotas != null) {
                    return CustomPlan(
                      index,
                      cuota,
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
        ),
      ),
    );
  }

  Widget mobile() {
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
                            return CustomPlan(index, cuota, showTotal: true);
                          } else {
                            return Container(
                                alignment: Alignment.center,
                                margin: const EdgeInsets.only(bottom: 10),
                                child: const Text(
                                    'Sin planes para este vehiculo.'));
                          }
                        },
                      ),
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

  Widget venderButton() => CustomButton('VENDER VEHICULO', () {
        controller.seletVehicleToSel();
        Get.toNamed(RouterManager.SEL_VEHICLE);
      }, ColorPalette.GREEN);
}
