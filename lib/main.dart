import 'package:car_system/bindings/dash_binding.dart';
import 'package:car_system/colors.dart';
import 'package:car_system/controllers/user_storage_controller.dart';
import 'package:car_system/models/static_model.dart';
import 'package:car_system/route_manager.dart';
import 'package:car_system/widgets/menu_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  UserStorageController userStorageController =
      Get.put(UserStorageController());
  await userStorageController.initStorage();
  runApp(
    GetMaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''),
        Locale('es', ''),
      ],
      smartManagement: SmartManagement.keepFactory,
      debugShowCheckedModeBanner: false,
      initialRoute: userStorageController.restoreModel().idColaborador ==
                  null ||
              userStorageController.restoreModel().dias <
                  Static.DAYS_PERMIT_APP_USE ||
              userStorageController.restoreModel().activo == 0
          ? RouterManager.LOGIN
          : (userStorageController.restoreModel().cargo == Roles.ADMIN.name ||
                  userStorageController.restoreModel().cargo == Roles.SUPER.name
              ? RouterManager.DASH
              : RouterManager.VEHICLES),
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
