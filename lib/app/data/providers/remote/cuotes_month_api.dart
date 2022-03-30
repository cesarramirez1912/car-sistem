import 'package:car_system/app/core/utils/user_storage_controller.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import '../../../../rest.dart';
import '../../models/deudor_model.dart';

class CuotesMonthApi {
  final Dio _dio = Get.find<Dio>();
  final UserStorageController _user = Get.find();

  Future<List<DeudorModel>> requestMonthDeudoresMonthYear(
      int? idCompany, int? month, int? year) async {
    final Response response = await _dio.get(
        Rest.DEUDORES_CUOTA + '$idCompany/mes=$month/ano=$year',
        options: Options(
          headers: {'Authorization': 'Bearer: ${_user.user?.value.token}'},
        ));
    return (response.data['response'] as List)
        .map((e) => DeudorModel.fromJson(e))
        .toList();
  }

  Future<List<DeudorModel>> requestMonthDeudoresCompany(int? idCompany) async {
    final Response response =
        await _dio.get(Rest.DEUDORES_CUOTA + '$idCompany',
            options: Options(
              headers: {'Authorization': 'Bearer: ${_user.user?.value.token}'},
            ));
    return (response.data['response'] as List)
        .map((e) => DeudorModel.fromJson(e))
        .toList();
  }

  Future<List<DeudorModel>> requestDeudoresMonthRefuerzo(
      int? idCompany, int? month, int? year) async {
    final Response response = await _dio.get(
        Rest.DEUDORES_REFUERZO + '$idCompany/mes=$month/ano=$year',
        options: Options(
          headers: {'Authorization': 'Bearer: ${_user.user?.value.token}'},
        ));
    return (response.data['response'] as List)
        .map((e) => DeudorModel.fromJson(e))
        .toList();
  }

  Future<List<DeudorModel>> requestDeudoresRefuerzo(int? idCompany) async {
    final Response response =
        await _dio.get(Rest.DEUDORES_REFUERZO + idCompany.toString(),
            options: Options(
              headers: {'Authorization': 'Bearer: ${_user.user?.value.token}'},
            ));
    return (response.data['response'] as List)
        .map((e) => DeudorModel.fromJson(e))
        .toList();
  }
}
