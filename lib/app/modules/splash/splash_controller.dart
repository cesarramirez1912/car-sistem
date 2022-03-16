import 'package:car_system/app/data/repositories/local/local_auth_repository.dart';
import 'package:car_system/app/data/repositories/remote/authentication_repository.dart';
import 'package:car_system/app/routes/app_routes.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import '../../core/utils/static_model.dart';
import '../../core/utils/user_storage_controller.dart';
import '../../data/models/user_model.dart';
import '../../global_widgets/snack_bars/snack_bar_error.dart';

class SplashController extends GetxController {
  final LocalAuthRepository _localAuthRepository = Get.find();
  final AuthenticationRepository _authenticationRepository = Get.find();
  final UserStorageController _userStorageController = Get.find();

  get version => _userStorageController.packageInfo;

  late User user;

  @override
  onReady() {
    _init();
  }

  _init() async {
    user = await _localAuthRepository.restoremodel;
    if (user.idColaborador != null) {
      await fetchUserInformation();
    } else {
      Get.offNamed(AppRoutes.LOGIN);
    }
  }

  Future<void> fetchUserInformation() async {
    try {
      List<User> _listUser = await _authenticationRepository
          .fetchUserInformation(user.idColaborador);
      await _localAuthRepository.setUser(_listUser.first);
      _userStorageController.storePriceModel(_listUser.first);
      if (_listUser.first.dias < Static.DAYS_PERMIT_APP_USE ||
          _listUser.first.activo == 0) {
        Get.offAndToNamed(AppRoutes.LOGIN);
        CustomSnackBarError('Porfavor contactar al soporte.');
      } else {
        Get.offNamed(AppRoutes.DASH);
      }
    } catch (e) {
      String? message = '';
      if (e is DioError) {
        if (e.response?.statusCode == 500) {
          message = e.response?.data['message'];
        } else {
          message = e.message;
        }
        CustomSnackBarError(message ?? 'error');
      }
    }
  }
}
