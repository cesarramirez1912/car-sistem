import 'package:car_system/colors.dart';
import 'package:car_system/controllers/user_storage_controller.dart';
import 'package:car_system/models/static_model.dart';
import 'package:car_system/route_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  UserStorageController userStorageController =
      Get.put(UserStorageController());
  await userStorageController.initStorage();
  runApp(
    GetMaterialApp(
      localizationsDelegates: const [GlobalMaterialLocalizations.delegate],
      supportedLocales: const [
        Locale('es'),
      ],
      debugShowCheckedModeBanner: false,
      initialRoute:
          userStorageController.restoreModel().idColaborador == null ||
                  userStorageController.restoreModel().dias <
                      Static.DAYS_PERMIT_APP_USE ||
                  userStorageController.restoreModel().activo == 0
              ? RouterManager.LOGIN
              : RouterManager.HOME,
      theme: ThemeData(
          appBarTheme: const AppBarTheme(
              iconTheme: IconThemeData(
                color: ColorPalette.PRIMARY, //change your color here
              ),
              titleTextStyle: TextStyle(
                  color: ColorPalette.PRIMARY,
                  fontSize: 22,
                  fontWeight: FontWeight.w700),
              backgroundColor: Colors.white,
              elevation: 0),
          fontFamily: 'Poppins',
          primaryColor: ColorPalette.PRIMARY),
      getPages: RouterManager.getRoutes(),
    ),
  );
}
