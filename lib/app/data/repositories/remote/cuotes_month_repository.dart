import 'package:car_system/app/data/providers/remote/cuotes_month_api.dart';
import 'package:get/get.dart';
import '../../models/deudor_model.dart';

class CuotesMonthRepository {
  final CuotesMonthApi _cuotesMonthApi = Get.find<CuotesMonthApi>();

  Future<List<DeudorModel>> requestMonthDeudoresMonthYear(
          int? idCompany, int? month, int? year) =>
      _cuotesMonthApi.requestMonthDeudoresMonthYear(idCompany, month, year);

  Future<List<DeudorModel>> requestMonthDeudoresCompany(
      int? idCompany) =>
      _cuotesMonthApi.requestMonthDeudoresCompany(idCompany);


  Future<List<DeudorModel>> requestDeudoresMonthRefuerzo(
          int? idCompany, int? month, int? year) =>
      _cuotesMonthApi.requestDeudoresMonthRefuerzo(idCompany, month, year);

  Future<List<DeudorModel>> requestDeudoresRefuerzo(int? idCompany) => _cuotesMonthApi.requestDeudoresRefuerzo(idCompany);
}
