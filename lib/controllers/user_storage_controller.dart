import 'package:car_system/app/data/repositories/remote/authentication_repository.dart';
import 'package:car_system/route_manager.dart';
import 'package:car_system/widgets/snack_bars/snack_bar_error.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../app/data/models/static_model.dart';
import '../app/data/models/user_model.dart';

class UserStorageController extends GetxController {
  Rx<PackageInfo> packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
  ).obs;
  Rx<User>? user = User().obs;

  @override
  void onInit() async {
    // TODO: implement onInit
    packageInfo.value = await PackageInfo.fromPlatform();
   // await initStorage();
    //user?.value = restoreModel();
    print('le seteo');
    // if (user?.value.idColaborador != null) {
    //   await fetchUserInformation();
    // }
    super.onInit();
  }

  // @override
  // onReady(){
  //   print('ready');
  // }
  //
  // Future<void> initStorage() async {
  //   await GetStorage.init();
  // }
  //
  // Future<void> fetchUserInformation() async {
  //   try {
  //     List<User> _listUser = await _authenticationRepository
  //         .fetchUserInformation(user!.value.idColaborador);
  //     await storePriceModel(_listUser.first);
  //     if (_listUser.first.dias < Static.DAYS_PERMIT_APP_USE ||
  //         _listUser.first.activo == 0) {
  //       Get.offAndToNamed(RouterManager.LOGIN);
  //       CustomSnackBarError('Porfavor contactar al soporte.');
  //     }
  //   } catch (e) {
  //     String? message = '';
  //     if (e is DioError) {
  //       if (e.response?.statusCode == 500) {
  //         message = e.response?.data['message'];
  //       } else {
  //         message = e.message;
  //       }
  //       CustomSnackBarError(message ?? 'error');
  //     }
  //   }
  // }

  Future<void> storePriceModel(User _user) async {
    user?.value = _user;
  }

}
