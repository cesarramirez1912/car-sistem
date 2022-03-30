class SellVehicleModel {
  int? idEmpresa;
  int? idSucursal;
  int? idCliente;
  int? idColaborador;
  int? idVehiculoSucursal;
  dynamic entradaDolares;
  dynamic entradaGuaranies;
  dynamic contadoDolares;
  dynamic contadoGuaranies;
  String? fechaVenta;
  List<Refuerzos>? refuerzos;
  List<Cuotas>? cuotas;

  SellVehicleModel(
      {this.idEmpresa,
      this.idSucursal,
      this.idCliente,
      this.idColaborador,
      this.idVehiculoSucursal,
      this.entradaDolares,
      this.contadoDolares,
      this.contadoGuaranies,
      this.fechaVenta,
      this.entradaGuaranies,
      this.refuerzos,
      this.cuotas});

  SellVehicleModel.fromJson(Map<String, dynamic> json) {
    idEmpresa = json['id_empresa'];
    idSucursal = json['id_sucursal'];
    idCliente = json['id_cliente'];
    idColaborador = json['id_colaborador'];
    idVehiculoSucursal = json['id_vehiculo_sucursal'];
    entradaDolares = json['entrada_dolares'];
    entradaGuaranies = json['entrada_guaranies'];
    contadoDolares = json['contado_dolares'];
    contadoGuaranies = json['contado_guaranies'];
    fechaVenta = json['fecha_venta'];
    if (json['refuerzos'] != null) {
      refuerzos = <Refuerzos>[];
      json['refuerzos'].forEach((v) {
        refuerzos!.add(Refuerzos.fromJson(v));
      });
    }
    if (json['cuotas'] != null) {
      cuotas = <Cuotas>[];
      json['cuotas'].forEach((v) {
        cuotas!.add(Cuotas.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_empresa'] = idEmpresa;
    data['id_sucursal'] = idSucursal;
    data['id_cliente'] = idCliente;
    data['id_colaborador'] = idColaborador;
    data['id_vehiculo_sucursal'] = idVehiculoSucursal;
    data['entrada_dolares'] = entradaDolares;
    data['entrada_guaranies'] = entradaGuaranies;
    data['contado_dolares'] = contadoDolares;
    data['contado_guaranies'] = contadoGuaranies;
    data['fecha_venta'] = fechaVenta;
    if (refuerzos != null) {
      data['refuerzos'] = refuerzos!.map((v) => v.toJson()).toList();
    }
    if (cuotas != null) {
      data['cuotas'] = cuotas!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Refuerzos {
  dynamic refuerzoDolares;
  dynamic refuerzoGuaranies;
  String? fechaRefuerzo;

  Refuerzos({this.refuerzoDolares, this.refuerzoGuaranies, this.fechaRefuerzo});

  Refuerzos.fromJson(Map<String, dynamic> json) {
    refuerzoDolares = json['refuerzo_dolares'];
    refuerzoGuaranies = json['refuerzo_guaranies'];
    fechaRefuerzo = json['fecha_refuerzo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['refuerzo_dolares'] = refuerzoDolares;
    data['refuerzo_guaranies'] = refuerzoGuaranies;
    data['fecha_refuerzo'] = fechaRefuerzo;
    return data;
  }
}

class Cuotas {
  dynamic cuotaDolares;
  dynamic cuotaGuaranies;
  String? fechaCuota;

  Cuotas({this.cuotaDolares, this.cuotaGuaranies, this.fechaCuota});

  Cuotas.fromJson(Map<String, dynamic> json) {
    cuotaDolares = json['cuota_dolares'];
    cuotaGuaranies = json['cuota_guaranies'];
    fechaCuota = json['fecha_cuota'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cuota_dolares'] = cuotaDolares;
    data['cuota_guaranies'] = cuotaGuaranies;
    data['fecha_cuota'] = fechaCuota;
    return data;
  }
}
