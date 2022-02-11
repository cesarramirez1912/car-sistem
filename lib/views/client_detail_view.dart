import 'package:car_system/controllers/client_controller.dart';
import 'package:car_system/controllers/client_detail_controller.dart';
import 'package:car_system/controllers/sells_from_collaborator_controller.dart';
import 'package:car_system/widgets/client_body.dart';
import 'package:car_system/widgets/spacing.dart';
import 'package:car_system/widgets/title.dart';
import 'package:car_system/widgets/vehicle_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClientDetailView extends StatelessWidget {
  ClientController clientController = Get.find<ClientController>();
  SellsFromCollaboratorController sellsFromCollaboratorController = Get.find();

  @override
  Widget build(BuildContext context) {
    ClientDetailController controller = Get.put(ClientDetailController(
        listClients: clientController.listClients,
        sales: sellsFromCollaboratorController.sales));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalles de la venta'),
      ),
      body: SingleChildScrollView(
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            CustomSpacing(),
                            CustomTitle('Cliente'),
                            CustomSpacing(),
                            const Divider(
                              height: 2,
                              color: Colors.grey,
                            ),
                            CustomSpacing(),
                            ClientBody(controller.clientModel.value)
                          ],
                        ),
                      ),
                    ),
                    Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                CustomSpacing(),
                                CustomTitle('Vehiculo'),
                                CustomSpacing(),
                                const Divider(
                                  height: 2,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                          ),
                          if (controller.vehicle != null)
                            VehicleDetails(controller.vehicle!.value,
                                withImage: false)
                          else
                            Container(),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
