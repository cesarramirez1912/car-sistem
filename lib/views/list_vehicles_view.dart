import 'package:car_system/controllers/client_controller.dart';
import 'package:car_system/controllers/deudor_controller.dart';
import 'package:car_system/controllers/list_vehicle_controller.dart';
import 'package:car_system/controllers/sells_from_collaborator_controller.dart';
import 'package:car_system/responsive.dart';
import 'package:car_system/route_manager.dart';
import 'package:car_system/widgets/menu_drawer.dart';
import 'package:car_system/widgets/search_input.dart';
import 'package:car_system/widgets/vehicle_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListVehiclesView extends StatelessWidget {
  ListVehicleController controller = Get.put(ListVehicleController());
  ClientController clientController = Get.put(ClientController());
  SellsFromCollaboratorController sellsFromCollaboratorController =
      Get.put(SellsFromCollaboratorController());
  DeudorController deudorController = Get.put(DeudorController());

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: CustomSearchInput(
              hintText: 'Buscar por marca o modelo',
              onChanged: (text) => controller.searchText(text),
              controller: controller.searchTextController,
              onClean: () => controller.searchText('')),
        ),
        title: const Text('Vehiculos'),
      ),
      body: Obx(
        () => RefreshIndicator(
            onRefresh: () async => await controller.fetchVehicles(),
            child: controller.isLoading.value
                ? const Center(child: CircularProgressIndicator())
                : Responsive(
                    tablet: tablet(),
                    desktop: desktop(),
                    mobile: mobile(),
                  )),
      ),
      drawer: Obx(() => CustomMenuDrawer(controller, deudorController)),
    );
  }

  Widget mobile() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ListView.builder(
        itemCount: controller.vehicles.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () => Get.toNamed(RouterManager.VEHICLE_DETAIL, parameters: {
              'idVehiculoSucursal':
                  controller.vehicles[index].idVehiculoSucursal.toString()
            }),
            child: Card(
              child: VehicleDetails(controller.vehicles[index]),
            ),
          );
        },
      ),
    );
  }

  Widget tablet() {
    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        alignment: Alignment.center,
        padding: const EdgeInsets.all(10),
        child: Container(
            alignment: Alignment.center,
            width: 800,
            child: Wrap(
              children: [
                ...controller.vehicles.map(
                  (element) => SizedBox(
                    width: 350,
                    child: GestureDetector(
                      onTap: () => Get.toNamed(RouterManager.VEHICLE_DETAIL,
                          parameters: {
                            'idVehiculoSucursal':
                                element.idVehiculoSucursal.toString()
                          }),
                      child: Card(
                        child: VehicleDetails(element),
                      ),
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }

  Widget desktop() {
    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        alignment: Alignment.center,
        padding: const EdgeInsets.all(10),
        child: Container(
            alignment: Alignment.center,
            width: 1105,
            child: Wrap(
              children: [
                ...controller.vehicles.map(
                  (element) => Container(
                    width: 350,
                    child: GestureDetector(
                      onTap: () => Get.toNamed(RouterManager.VEHICLE_DETAIL,
                          parameters: {
                            'idVehiculoSucursal':
                                element.idVehiculoSucursal.toString()
                          }),
                      child: Card(
                        child: VehicleDetails(element),
                      ),
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }
}
