import 'package:car_system/common/money_format.dart';
import 'package:car_system/controllers/vehicle_detail_controller.dart';
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
                      const SizedBox(
                        height: 10,
                      ),
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
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomTitle(
                                      'PLAN N° ${(index + 1).toString()}',
                                      fontSize: 17),
                                  Container(
                                    margin:
                                        const EdgeInsets.symmetric(vertical: 5),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 4, horizontal: 10),
                                    decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(4),
                                        ),
                                        border: Border.all(
                                            width: 1, color: Colors.grey)),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            planText(
                                                'Cant. de cuotas',
                                                MoneyFormat().formatCommaToDot(
                                                    controller.vehicles[index]
                                                        .cantidadCuotas)),
                                            planText(
                                                'Cant. de refuerzos',
                                                MoneyFormat().formatCommaToDot(
                                                    controller.vehicles[index]
                                                        .cantidadRefuerzo)),
                                          ],
                                        ),
                                        CustomTitle('PLAN GUARANIES'),
                                        planText(
                                          'Cuota',
                                          MoneyFormat().formatCommaToDot(
                                            controller
                                                .vehicles[index].cuotaGuaranies,
                                          ),
                                        ),
                                        planText(
                                          'Refuerzo',
                                          MoneyFormat().formatCommaToDot(
                                            controller.vehicles[index]
                                                .refuerzoGuaranies,
                                          ),
                                        ),
                                        CustomTitle('PLAN DOLARES'),
                                        planText(
                                            'Cuota:',
                                            MoneyFormat().formatCommaToDot(
                                                controller.vehicles[index]
                                                    .cuotaDolares)),
                                        planText(
                                          'Refuerzo:',
                                          MoneyFormat().formatCommaToDot(
                                              controller.vehicles[index]
                                                  .refuerzoDolares),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  )
                                ],
                              );
                            },
                          )
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

  Widget planText(String left, String rigth) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            left + ':',
          ),
          Text(
            rigth,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
