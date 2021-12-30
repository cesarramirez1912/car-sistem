import 'package:car_system/controllers/vehicle_detail_controller.dart';
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
        () => Column(
          children: [
            Text(controller.vehicles.first.motor)
          ],
        ),
      ),
    );
  }
}
