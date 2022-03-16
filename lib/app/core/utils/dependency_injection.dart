import 'package:car_system/app/data/providers/local/local_auth.dart';
import 'package:car_system/app/data/providers/remote/authentication_api.dart';
import 'package:car_system/app/data/providers/remote/clients_api.dart';
import 'package:car_system/app/data/providers/remote/cuotes_month_api.dart';
import 'package:car_system/app/data/providers/remote/dash_api.dart';
import 'package:car_system/app/data/providers/remote/essencial_vehicle_api.dart';
import 'package:car_system/app/data/providers/remote/login_api.dart';
import 'package:car_system/app/data/providers/remote/sells_api.dart';
import 'package:car_system/app/data/repositories/local/local_auth_repository.dart';
import 'package:car_system/app/data/repositories/remote/authentication_repository.dart';
import 'package:car_system/app/data/repositories/remote/clients_repository.dart';
import 'package:car_system/app/data/repositories/remote/cuotes_month_repository.dart';
import 'package:car_system/app/data/repositories/remote/essencial_vehicle_repository.dart';
import 'package:car_system/app/data/repositories/remote/login_repository.dart';
import 'package:car_system/app/data/repositories/remote/sells_repository.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../controllers/user_storage_controller.dart';
import '../../data/repositories/remote/dash_repository.dart';

class DependencyInjection {
  static Future<void> init() async {
    await GetStorage.init();
    Get.put(UserStorageController());
    Get.put(GetStorage());
    Get.put(Dio());

    //providers
    Get.put(AuthenticationApi());
    Get.put(LocalAuth());
    Get.put(LoginApi());
    Get.put(DashApi());
    Get.put(SellsApi());
    Get.put(ClientsApi());
    Get.put(CuotesMonthApi());
    Get.put(EssencialVehicleApi());

    //repositories
    Get.put(LocalAuthRepository());
    Get.put(AuthenticationRepository());
    Get.put(LoginRepository());
    Get.put(DashRepository());
    Get.put(SellsRepository());
    Get.put(ClientsRepository());
    Get.put(CuotesMonthRepository());
    Get.put(EssencialVehiclesRepository());
  }
}
