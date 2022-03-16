class SellVehicleModel {
  int? idEmpresa;
  int? idSucursal;
  int? idCliente;
  int? idColaborador;
  int? idVehiculoSucursal;
  dynamic? entradaDolares;
  dynamic? entradaGuaranies;
  dynamic? contadoDolares;
  dynamic? contadoGuaranies;
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
        refuerzos!.add(new Refuerzos.fromJson(v));
      });
    }
    if (json['cuotas'] != null) {
      cuotas = <Cuotas>[];
      json['cuotas'].forEach((v) {
        cuotas!.add(new Cuotas.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_empresa'] = this.idEmpresa;
    data['id_sucursal'] = this.idSucursal;
    data['id_cliente'] = this.idCliente;
    data['id_colaborador'] = this.idColaborador;
    data['id_vehiculo_sucursal'] = this.idVehiculoSucursal;
    data['entrada_dolares'] = this.entradaDolares;
    data['entrada_guaranies'] = this.entradaGuaranies;
    data['contado_dolares'] = this.contadoDolares;
    data['contado_guaranies'] = this.contadoGuaranies;
    data['fecha_venta'] = this.fechaVenta;
    if (this.refuerzos != null) {
      data['refuerzos'] = this.refuerzos!.map((v) => v.toJson()).toList();
    }
    if (this.cuotas != null) {
      data['cuotas'] = this.cuotas!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Refuerzos {
  dynamic? refuerzoDolares;
  dynamic? refuerzoGuaranies;
  String? fechaRefuerzo;

  Refuerzos({this.refuerzoDolares, this.refuerzoGuaranies, this.fechaRefuerzo});

  Refuerzos.fromJson(Map<String, dynamic> json) {
    refuerzoDolares = json['refuerzo_dolares'];
    refuerzoGuaranies = json['refuerzo_guaranies'];
    fechaRefuerzo = json['fecha_refuerzo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['refuerzo_dolares'] = this.refuerzoDolares;
    data['refuerzo_guaranies'] = this.refuerzoGuaranies;
    data['fecha_refuerzo'] = this.fechaRefuerzo;
    return data;
  }
}

class Cuotas {
  dynamic? cuotaDolares;
  dynamic? cuotaGuaranies;
  String? fechaCuota;

  Cuotas({this.cuotaDolares, this.cuotaGuaranies, this.fechaCuota});

  Cuotas.fromJson(Map<String, dynamic> json) {
    cuotaDolares = json['cuota_dolares'];
    cuotaGuaranies = json['cuota_guaranies'];
    fechaCuota = json['fecha_cuota'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cuota_dolares'] = this.cuotaDolares;
    data['cuota_guaranies'] = this.cuotaGuaranies;
    data['fecha_cuota'] = this.fechaCuota;
    return data;
  }
}
