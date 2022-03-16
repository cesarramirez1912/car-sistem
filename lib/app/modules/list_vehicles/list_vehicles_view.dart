import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/user_storage_controller.dart';
import '../../data/enums/roles.dart';
import '../../global_widgets/menu_drawer.dart';
import '../../global_widgets/responsive.dart';
import '../../global_widgets/search_input.dart';
import '../../global_widgets/vehicle_details.dart';
import '../../routes/app_routes.dart';
import 'list_vehicle_controller.dart';

class ListVehiclesView extends StatelessWidget {
  ListVehicleController controller = Get.find();
  UserStorageController userStorageController = Get.find();

  @override
  Widget build(context) {
    return Responsive(
      mobile: principal(context),
      tablet: Center(
        child: Container(
            alignment: Alignment.center,
            width: 900,
            child: principal(context)),
      ),
      desktop: Center(
        child: Container(
            alignment: Alignment.center,
            width: 900,
            child: principal(context)),
      ),
    );
  }

  Widget principal(context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Responsive.isTablet(context) || Responsive.isDesktop(context)
              ? IconButton(
              onPressed: () async {
                controller.isLoading.value = true;
                await controller.fetchVehicles();
                controller.isLoading.value = false;
              },
              icon: const Icon(Icons.refresh))
              : Container(),
        ],
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
          onRefresh: () async {
            var fetchaVehicles = await controller.fetchVehicles();
          },
          child: controller.isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : Responsive(
                  tablet: tablet(),
                  desktop: desktop(),
                  mobile: mobile(),
                ),
        ),
      ),
      drawer: userStorageController.user?.value.cargo == Roles.VENDEDOR.name
          ? Obx(() => CustomMenuDrawer())
          : null,
    );
  }

  Widget mobile() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ListView.builder(
        itemCount: controller.vehicles.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () => Get.toNamed(AppRoutes.VEHICLE_DETAIL, parameters: {
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
                      onTap: () => Get.toNamed(AppRoutes.VEHICLE_DETAIL,
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
                      onTap: () => Get.toNamed(AppRoutes.VEHICLE_DETAIL,
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
