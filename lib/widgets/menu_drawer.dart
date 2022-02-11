import 'package:car_system/controllers/deudor_controller.dart';
import 'package:car_system/controllers/list_vehicle_controller.dart';
import 'package:car_system/route_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../colors.dart';

enum Roles { SUPER, ADMIN, VENDEDOR }

Widget CustomMenuDrawer(
    ListVehicleController controller, DeudorController deudorController) {
  Widget rounderNotification(int quantity) {
    return Container(
      width: 30,
      height: 30,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: ColorPalette.PRIMARY,
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Text(
        quantity.toString(),
        style: const TextStyle(color: Colors.white),
      ),
    );
  }

  List<Widget> _defaultItems = [
    ListTile(
      title: const Text('Inicio'),
      onTap: () => Get.back(),
    ),
    ListTile(
      title: const Text('Clientes'),
      onTap: () => Get.toNamed(RouterManager.CLIENTS_VIEW),
    ),
    ListTile(
      title: const Text('Mis ventas'),
      onTap: () => Get.toNamed(RouterManager.SELLS_FROM_COLLABORATOR),
    ),
    ListTile(
      title: const Text('Registrar vehiculo'),
      onTap: () => Get.toNamed(RouterManager.REGISTER),
    ),
    ListTile(
      title: const Text('Pendientes de pago'),
      onTap: () => Get.toNamed(RouterManager.DEUDOR_VIEW),
      trailing: rounderNotification(
          deudorController.listDeudoresAgrupadoCuota.length +
              deudorController.listDeudoresAgrupadoRefuerzo.length),
    ),
  ];

  if (controller.user?.cargo == Roles.SUPER.name) {
    _defaultItems.add(ListTile(
      title: const Text('Registrar informaciones'),
      onTap: () => Get.toNamed(RouterManager.REGISTER_ESSENCIAL),
    ));
  }

  _defaultItems.add(Expanded(
    child: Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ListTile(
          trailing: const Icon(Icons.exit_to_app),
          title: const Text(
            'Cerrar sesión',
            style: TextStyle(color: Color.fromRGBO(121, 121, 121, 1.0)),
          ),
          onTap: () async {
            await controller.userStorageController.deleteStore();
            Get.offAllNamed(RouterManager.LOGIN);
          },
        ),
      ],
    ),
  ));

  return Drawer(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        DrawerHeader(
          decoration: const BoxDecoration(
            color: ColorPalette.PRIMARY,
          ),
          child: Obx(
            () => Column(
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
                Expanded(
                  child: Container(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      controller
                              .userStorageController.packageInfo.value.version +
                          "." +
                          controller.userStorageController.user!.value.dias
                              .toString(),
                      style: const TextStyle(
                          color: Color.fromRGBO(141, 11, 11, 1.0),
                          fontSize: 10),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        ..._defaultItems
      ],
    ),
  );
}
