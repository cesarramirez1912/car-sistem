import 'package:car_system/controllers/list_vehicle_controller.dart';
import 'package:car_system/models/vehicle.dart';
import 'package:car_system/route_manager.dart';
import 'package:car_system/widgets/vehicle_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListVehiclesView extends GetView<ListVehicleController> {
  @override
  Widget build(context) => Scaffold(
        appBar: AppBar(
          title: const Text('Vehiculos'),
        ),
        body: Obx(
          () => RefreshIndicator(
            onRefresh: () async => await controller.fetchVehicles(),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: ListView.builder(
                itemCount: controller.vehicles.length,
                itemBuilder: (BuildContext context, int index) {
                  Vehicle _vehicle = controller.vehicles[index];
                  return GestureDetector(
                    onTap: () => Get.toNamed(RouterManager.VEHICLE_DETAIL,parameters: {'id':_vehicle.idVehiculoSucursal.toString()}),
                    child: Card(
                      child: VehicleDetails(_vehicle),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      );
}
