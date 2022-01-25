import 'package:car_system/colors.dart';
import 'package:car_system/controllers/client_controller.dart';
import 'package:car_system/controllers/list_vehicle_controller.dart';
import 'package:car_system/controllers/sells_from_collaborator_controller.dart';
import 'package:car_system/controllers/user_controller.dart';
import 'package:car_system/route_manager.dart';
import 'package:car_system/widgets/vehicle_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListVehiclesView extends GetView<ListVehicleController> {
  UserController userController = Get.put(UserController());
  ClientController clientController = Get.put(ClientController());
  SellsFromCollaboratorController sellsFromCollaboratorController =
      Get.put(SellsFromCollaboratorController());

  @override
  Widget build(context) {
    sellsFromCollaboratorController.setUser(userController.user);
    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            alignment: Alignment.topLeft,
            margin: const EdgeInsets.only(right: 10, left: 10, bottom: 10),
            decoration: const BoxDecoration(
                color: Color.fromRGBO(248, 248, 248, 1),
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                )),
            child: TextFormField(
              autofocus: false,
              onChanged: (text) => controller.searchText(text),
              controller: controller.searchTextController,
              decoration: const InputDecoration(
                hintText: 'Buscar por marca o modelo',
                border: InputBorder.none,
                suffixIcon: Icon(Icons.search),
              ),
            ),
          ),
        ),
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
                return GestureDetector(
                  onTap: () =>
                      Get.toNamed(RouterManager.VEHICLE_DETAIL, parameters: {
                    'idVehiculoSucursal':
                        controller.vehicles[index].idVehiculoSucursal.toString()
                  }),
                  child: Card(
                    child: VehicleDetails(controller.vehicles[index]),
                  ),
                );
              },
            ),
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: ColorPalette.PRIMARY,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    controller.user?.empresa ?? '-',
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w700),
                  ),
                  Text(
                    controller.user?.colaborador ?? '-',
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
            ListTile(
              title: const Text('Inicio'),
              onTap: () => Get.back(),
            ),
            ListTile(
              title: const Text('Mis ventas'),
              onTap: () => Get.toNamed(RouterManager.SELLS_FROM_COLLABORATOR),
            ),
            ListTile(
              title: const Text('Registrar vehiculo'),
              onTap: () => Get.toNamed(RouterManager.REGISTER),
            ),

          ],
        ),
      ),
    );
  }
}
