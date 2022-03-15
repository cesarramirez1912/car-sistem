import 'package:car_system/models/deudor_model.dart';
import 'package:car_system/models/sale_collaborator_model.dart';
import 'package:car_system/rest.dart';
import 'package:get/get.dart';

class DashRepository extends GetConnect {
  Future<dynamic> requestCobrosMes(int? idEmpresa, int month, int year) async {
    final response =
        await get(Rest.COBROS_MES + '${idEmpresa}/mes=${month}/ano=${year}');
    return await requestModel(response).then((value) {
      List<Total> _list = [];
      for (var i in response.body['response']) {
        _list.add(Total.fromJson(i));
      }
      return _list;
    });
  }

  Future<dynamic> requestTotalVentasMes(
      int? idEmpresa, int month, int year) async {
    final response =
        await get(Rest.VENTAS_MES + '${idEmpresa}/mes=${month}/ano=${year}');
    return await requestModel(response).then((value) {
      List<TotalVenta> _list = [];
      for (var i in response.body['response']) {
        _list.add(TotalVenta.fromJson(i));
      }
      return _list;
    });
  }

  Future<dynamic> requestCount(int? idEmpresa, int month, int year) async {
    final response = await get(
        Rest.COUNT_VENTA_MES + '${idEmpresa}/mes=${month}/ano=${year}');
    return await requestModel(response).then((value) {
      List<Count> _list = [];
      for (var i in value) {
        _list.add(Count.fromJson(i));
      }
      return _list;
    });
  }

  Future<dynamic> requestCountCuotesPagos(
      int? idEmpresa, int? month, int year) async {
    final response = await get(
        Rest.COUNT_CUOTES_PAGOS_MES + '${idEmpresa}/mes=${month}/ano=${year}');
    return await requestModel(response).then((value) {
      List<CountTotalCuotaPago> _list = [];
      for (var i in value) {
        _list.add(CountTotalCuotaPago.fromJson(i));
      }
      return _list;
    });
  }

  Future<dynamic> requestNegocios(int? idEmpresa, int? month, int year) async {
    final response =
        await get(Rest.NEGOCIOS_MES + '${idEmpresa}/mes=${month}/ano=${year}');
    return await requestModel(response).then((value) {
      List<SaleCollaboratorModel> _list = [];
      for (var i in value) {
        _list.add(SaleCollaboratorModel.fromJson(i));
      }
      return _list;
    });
  }
}

Future requestModel(Response response) async {
  if (response.status.hasError) {
    if (response.body['message'] != '') {
      return Future.error(
          'Ocurrió un error al traer los cobros, intente de nuevo.');
    } else {
      return Future.error(response.body['message']);
    }
  } else {
    return response.body['response'];
  }
}

class Total {
  dynamic? pagoGuaranies;
  dynamic? pagoDolares;

  Total({this.pagoGuaranies, this.pagoDolares});

  Total.fromJson(Map<String, dynamic> json) {
    pagoGuaranies = json['pago_guaranies'];
    pagoDolares = json['pago_dolares'];
  }
}

class TotalVenta {
  dynamic? ventaGuaranies;
  dynamic? ventaDolares;

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
