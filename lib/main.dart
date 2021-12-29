import 'package:car_system/colors.dart';
import 'package:car_system/route_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/login',
    theme: ThemeData(
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(color: ColorPalette.PRIMARY,fontSize: 22,fontWeight: FontWeight.w700),
            backgroundColor: Colors.white,
            elevation: 0),
        fontFamily: 'Poppins',
        primaryColor: ColorPalette.PRIMARY),
    getPages: RouterManager.getRoutes(),
  ));
}
