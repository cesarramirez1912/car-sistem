import 'package:car_system/views/register_client_view.dart';
import 'package:car_system/views/list_vehicles_view.dart';
import 'package:car_system/views/login_view.dart';
import 'package:car_system/views/register_vehicle_view.dart';
import 'package:car_system/views/sell/dates_venc_view.dart';
import 'package:car_system/views/sell/sell_vehicle_view.dart';
import 'package:car_system/views/vehicle_detail_view.dart';
import 'package:get/get.dart';

import 'all_binding.dart';

class RouterManager {
  static const String LOGIN = '/login';
  static const String REGISTER_CLIENT = '/register_client';
  static const String HOME = '/home';
  static const String VEHICLE_DETAIL = '/vehicle_detail';
  static const String REGISTER= '/register_vehicle';
  static const String SEL_VEHICLE= '/sel_vehicle';
  static const String DATES_VEN= '/dates_venc';

  static List<GetPage> getRoutes() => [
    GetPage(name: LOGIN, page: () => LoginView(), binding: AllBinding()),
    GetPage(name: REGISTER_CLIENT, page: () => RegisterClientView(), binding: AllBinding()),
    GetPage(name: HOME, page: () => ListVehiclesView(), binding: AllBinding()),
    GetPage(name: VEHICLE_DETAIL, page: () => VehicleDetailView(), binding: AllBinding()),
    GetPage(name: REGISTER, page: () => const RegisterVehicleView(), binding: AllBinding()),
    GetPage(name: SEL_VEHICLE, page: () => SellVehicleView(), binding: AllBinding()),
    GetPage(name: DATES_VEN, page: () => DatesVencView()),
  ];
}