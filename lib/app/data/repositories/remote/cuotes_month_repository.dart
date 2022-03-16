import 'package:car_system/app/data/providers/remote/cuotes_month_api.dart';
import 'package:get/get.dart';
import '../../models/deudor_model.dart';

class CuotesMonthRepository {
  final CuotesMonthApi _cuotesMonthApi = Get.find<CuotesMonthApi>();

  Future<List<DeudorModel>> requestMonthDeudores(
          int? idCompany, int? month, int? year) =>
      _cuotesMonthApi.requestMonthDeudores(idCompany, month, year);

  Future<List<DeudorModel>> requestDeudoresMonthRefuerzo(
          int? idCompany, int? month, int? year) =>
      _cuotesMonthApi.requestDeudoresMonthRefuerzo(idCompany, month, year);
}
