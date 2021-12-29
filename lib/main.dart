import 'package:car_system/route_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(GetMaterialApp(
    initialRoute: '/login',
    getPages:RouterManager.getRoutes(),
  ));
}
