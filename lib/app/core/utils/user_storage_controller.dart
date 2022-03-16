import 'package:car_system/app/data/models/user_model.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';


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
    super.onInit();
  }


  Future<void> storePriceModel(User _user) async {
    user?.value = _user;
  }

}
