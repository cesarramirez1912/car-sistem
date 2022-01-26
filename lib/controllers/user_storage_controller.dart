import 'package:car_system/models/static_model.dart';
import 'package:car_system/models/user_model.dart';
import 'package:car_system/repositories/user_storage_repository.dart';
import 'package:car_system/route_manager.dart';
import 'package:car_system/widgets/snack_bars/snack_bar_error.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:package_info_plus/package_info_plus.dart';

class UserStorageController extends GetxController {


  UserStorageRepository userStorageRepository = UserStorageRepository();
  Rx<PackageInfo> packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
  ).obs;
  final box = GetStorage();
  Rx<User>? user = User().obs;

  @override
  void onInit() async {
    // TODO: implement onInit
    packageInfo.value = await PackageInfo.fromPlatform();
    await initStorage();
    user?.value = restoreModel();
    if (user?.value.idColaborador != null) {
      await fetchUserInformation();
    }
    super.onInit();
  }

  Future<void> initStorage() async {
    await GetStorage.init();
  }

  Future<void> fetchUserInformation() async {
    List<User> _listUser = await userStorageRepository
        .fetchUserInformation(user!.value.idColaborador);
    storePriceModel(_listUser.first);
    if (_listUser.first.dias < Static.DAYS_PERMIT_APP_USE ||
        _listUser.first.activo == 0) {
      Get.offAndToNamed(RouterManager.LOGIN);
      CustomSnackBarError('Porfavor contactar al soporte.');
    }
  }

  void setUser(User? _user) {
    user?.value = _user!;
  }

  void storePriceModel(User _user) {
    user?.value = _user;
    box.write('userModel', _user.toJson());
  }

  void deleteStore() {
    box.remove('userModel');
  }

  User restoreModel() {
    final map = box.read('userModel') ?? User().toJson();
    return User.fromJson(map);
  }
}
