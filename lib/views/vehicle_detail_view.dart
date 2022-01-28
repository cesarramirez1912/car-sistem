import 'package:car_system/colors.dart';
import 'package:car_system/common/money_format.dart';
import 'package:car_system/controllers/vehicle_detail_controller.dart';
import 'package:car_system/models/cuotes.dart';
import 'package:car_system/route_manager.dart';
import 'package:car_system/widgets/button.dart';
import 'package:car_system/widgets/plan.dart';
import 'package:car_system/widgets/title.dart';
import 'package:car_system/widgets/vehicle_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VehicleDetailView extends GetView<VehicleDetailController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalles'),
      ),
      body: Obx(
        () => SingleChildScrollView(
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
                                return CustomPlan(index, cuota);
                              } else {
                                return Container(
                                    alignment: Alignment.center,
                                    margin: const EdgeInsets.only(bottom: 10),
                                    child: const Text(
                                        'Sin planes para este vehiculo.'));
                              }
                            },
                          ),
                          CustomButton('VENDER VEHICULO', () {
                            controller.seletVehicleToSel();
                            Get.toNamed(RouterManager.SEL_VEHICLE);
                          }, ColorPalette.GREEN)
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
