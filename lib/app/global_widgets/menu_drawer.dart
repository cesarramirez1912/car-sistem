import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../core/theme/colors.dart';
import '../core/utils/user_storage_controller.dart';
import '../data/enums/roles.dart';
import '../modules/cuote_month/cuotes_month_controller.dart';
import '../modules/deudor/deudor_controller.dart';
import '../routes/app_routes.dart';

Widget CustomMenuDrawer() {
  UserStorageController controller = Get.find();
  DeudorController deudorController = Get.find();
  CuotesMonthController cuotesMonthController = Get.find();
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
      title: const Text('Ventas'),
      onTap: () => Get.toNamed(AppRoutes.NEGOCIOS_VIEW),
    ),
    ListTile(
      title: const Text('Clientes'),
      onTap: () => Get.toNamed(AppRoutes.CLIENTS_VIEW),
    ),
    ListTile(
      title: const Text('Vehiculos'),
      onTap: () => Get.toNamed(AppRoutes.VEHICLES),
    ),
    ListTile(
      title: const Text('Cuotas por mes'),
      onTap: () => Get.toNamed(AppRoutes.CUOTES_MONTH),
      trailing: rounderNotification(
          cuotesMonthController.listDeudoresAgrupadoCuota.length +
              cuotesMonthController.listDeudoresAgrupadoRefuerzo.length),
    ),
    ListTile(
      title: const Text('Registrar vehiculo'),
      onTap: () => Get.toNamed(AppRoutes.REGISTER),
    ),
    ListTile(
      title: const Text('Pendientes de pago'),
      onTap: () => Get.toNamed(AppRoutes.DEUDOR_VIEW),
      trailing: rounderNotification(
          deudorController.listDeudoresAgrupadoCuota.length +
              deudorController.listDeudoresAgrupadoRefuerzo.length),
    ),
  ];

  if (controller.user?.value.cargo == Roles.SUPER.name) {
    _defaultItems.add(
      ListTile(
        title: const Text('Registrar informaciones'),
        onTap: () => Get.toNamed(AppRoutes.REGISTER_ESSENCIAL),
      ),
    );
  }

  _defaultItems.add(
    ListTile(
      trailing: const Icon(Icons.exit_to_app),
      title: const Text(
        'Cerrar sesión',
        style: TextStyle(color: Color.fromRGBO(121, 121, 121, 1.0)),
      ),
      onTap: () async {
        //await controller.;
        Get.offAllNamed(AppRoutes.LOGIN);
      },
    ),
  );

  return Drawer(
    child: Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
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
                  controller.user?.value.empresa ?? '-',
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w700),
                ),
                Text(
                  controller.user?.value.colaborador ?? '-',
                  style: const TextStyle(color: Colors.white),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      controller.packageInfo.value.version +
                          "." +
                          controller.user!.value.dias.toString(),
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
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [..._defaultItems],
            ),
          ),
        )
      ],
    ),
  );
}
