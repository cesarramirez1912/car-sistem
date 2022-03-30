import 'package:car_system/app/data/models/sale_collaborator_model.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import '../../../../rest.dart';
import '../../../core/utils/user_storage_controller.dart';

class DashApi {
  final Dio _dio = Get.find<Dio>();
  final UserStorageController _user = Get.find();

  Future<List<Total>> requestCobrosMes(
      int? idEmpresa, int month, int year) async {
    final Response response =
        await _dio.get(Rest.COBROS_MES + '$idEmpresa/mes=$month/ano=$year',
            options: Options(
              headers: {'Authorization': 'Bearer: ${_user.user?.value.token}'},
            ));
    return (response.data['response'] as List)
        .map((e) => Total.fromJson(e))
        .toList();
  }

  Future<List<TotalVenta>> requestTotalVentasMes(
      int? idEmpresa, int month, int year) async {
    final Response response =
        await _dio.get(Rest.VENTAS_MES + '$idEmpresa/mes=$month/ano=$year',
            options: Options(
              headers: {'Authorization': 'Bearer: ${_user.user?.value.token}'},
            ));
    return (response.data['response'] as List)
        .map((e) => TotalVenta.fromJson(e))
        .toList();
  }

  Future<List<Count>> requestCount(int? idEmpresa, int month, int year) async {
    final Response response =
        await _dio.get(Rest.COUNT_VENTA_MES + '$idEmpresa/mes=$month/ano=$year',
            options: Options(
              headers: {'Authorization': 'Bearer: ${_user.user?.value.token}'},
            ));
    return (response.data['response'] as List)
        .map((e) => Count.fromJson(e))
        .toList();
  }

  Future<dynamic> requestCountCuotesPagos(
      int? idEmpresa, int? month, int year) async {
    final Response response = await _dio.get(
        Rest.COUNT_CUOTES_PAGOS_MES + '$idEmpresa/mes=$month/ano=$year',
        options: Options(
          headers: {'Authorization': 'Bearer: ${_user.user?.value.token}'},
        ));
    return (response.data['response'] as List)
        .map((e) => CountTotalCuotaPago.fromJson(e))
        .toList();
  }

  Future<dynamic> requestNegocios(int? idEmpresa, int? month, int year) async {
    final Response response =
        await _dio.get(Rest.NEGOCIOS_MES + '$idEmpresa/mes=$month/ano=$year',
            options: Options(
              headers: {'Authorization': 'Bearer: ${_user.user?.value.token}'},
            ));
    return (response.data['response'] as List)
        .map((e) => SaleCollaboratorModel.fromJson(e))
        .toList();
  }
}

class Total {
  dynamic pagoGuaranies;
  dynamic pagoDolares;

  Total({this.pagoGuaranies, this.pagoDolares});

  Total.fromJson(Map<String, dynamic> json) {
    pagoGuaranies = json['pago_guaranies'];
    pagoDolares = json['pago_dolares'];
  }
}

class TotalVenta {
  dynamic ventaGuaranies;
  dynamic ventaDolares;

  TotalVenta({this.ventaGuaranies, this.ventaDolares});

  TotalVenta.fromJson(Map<String, dynamic> json) {
    ventaGuaranies = json['venta_guaranies'];
    ventaDolares = json['venta_dolares'];
  }
}

class Count {
  int? count;

  Count({this.count});

  Count.fromJson(Map<String, dynamic> json) {
    count = int.parse(json['count']);
  }
}

class CountTotalCuotaPago {
  int? mes;
  int? totalCuotas;
  int? totalPagado;

  CountTotalCuotaPago({this.mes, this.totalCuotas, this.totalPagado});

  CountTotalCuotaPago.fromJson(Map<String, dynamic> json) {
    mes = json['mes'];
    totalCuotas = int.parse(json['total_cuotas']);
    totalPagado = int.parse(json['total_pagado']);
  }
}
