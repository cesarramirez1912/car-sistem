import 'package:car_system/app/data/models/cuote_detail_model.dart';
import 'package:car_system/app/data/models/refuerzo_detail_model.dart';
import 'package:car_system/app/data/models/sale_collaborator_model.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import '../../../../rest.dart';
import '../../models/deudor_model.dart';

class CuotesMonthApi{
  final Dio _dio = Get.find<Dio>();

  Future<List<DeudorModel>> requestMonthDeudoresMonthYear(
      int? idCompany, int? month, int? year) async {
    final Response response = await _dio.get(Rest.DEUDORES_CUOTA + '${idCompany}/mes=${month}/ano=${year}');
    return (response.data['response'] as List).map((e) => DeudorModel.fromJson(e)).toList();
  }

  Future<List<DeudorModel>> requestMonthDeudoresCompany(
      int? idCompany) async {
    final Response response = await _dio.get(Rest.DEUDORES_CUOTA + '${idCompany}');
    return (response.data['response'] as List).map((e) => DeudorModel.fromJson(e)).toList();
  }

  Future<List<DeudorModel>> requestDeudoresMonthRefuerzo(
      int? idCompany, int? month, int? year) async {
    final Response response = await _dio.get(
        Rest.DEUDORES_REFUERZO + '${idCompany}/mes=${month}/ano=${year}');
    return (response.data['response'] as List).map((e) => DeudorModel.fromJson(e)).toList();
  }

  Future<List<DeudorModel>> requestDeudoresRefuerzo(int? idCompany) async {
    final Response response = await _dio.get(
        Rest.DEUDORES_REFUERZO + idCompany.toString());
    return (response.data['response'] as List).map((e) =>
        DeudorModel.fromJson(e)).toList();
  }
}