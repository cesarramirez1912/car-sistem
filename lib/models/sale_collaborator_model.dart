class SaleCollaboratorModel {
  int? idVenta;
  int? idEmpresa;
  int? idSucursal;
  int? idCliente;
  String? cliente;
  int? idVehiculoSucursal;
  dynamic? chapa;
  dynamic? chassis;
  String? combustible;
  String? color;
  String? motor;
  String? ano;
  String? cambio;
  String? marca;
  String? modelo;
  dynamic? entradaGuaranies;
  dynamic? entradaDolares;
  dynamic? contadoGuaranies;
  dynamic? contadoDolares;
  String? fechaVenta;
  int? idColaborador;
  String? colaborador;
  dynamic? cantidadCuotas;
  dynamic? cantidadCuotasPagadas;
  dynamic? cantidadRefuerzos;
  dynamic? cantidadRefuerzosPagados;

  SaleCollaboratorModel(
      {this.idVenta,
        this.idEmpresa,
        this.idSucursal,
        this.idCliente,
        this.cliente,
        this.idVehiculoSucursal,
        this.chapa,
        this.chassis,
        this.combustible,
        this.color,
        this.motor,
        this.ano,
        this.cambio,
        this.marca,
        this.modelo,
        this.entradaGuaranies,
        this.entradaDolares,
        this.contadoGuaranies,
        this.contadoDolares,
        this.fechaVenta,
        this.idColaborador,
        this.colaborador,
        this.cantidadCuotas,
        this.cantidadCuotasPagadas,
        this.cantidadRefuerzos,
        this.cantidadRefuerzosPagados
      });

  SaleCollaboratorModel.fromJson(Map<String, dynamic> json) {
    idVenta = json['id_venta'];
    idEmpresa = json['id_empresa'];
    idSucursal = json['id_sucursal'];
    idCliente = json['id_cliente'];
    cliente = json['cliente'];
    idVehiculoSucursal = json['id_vehiculo_sucursal'];
    chapa = json['chapa'];
    chassis = json['chassis'];
    combustible = json['combustible'];
    color = json['color'];
    motor = json['motor'];
    ano = json['ano'];
    cambio = json['cambio'];
    marca = json['marca'];
    modelo = json['modelo'];
    entradaGuaranies = json['entrada_guaranies'];
    entradaDolares = json['entrada_dolares'];
    contadoGuaranies = json['contado_guaranies'];
    contadoDolares = json['contado_dolares'];
    fechaVenta = json['fecha_venta'];
    idColaborador = json['id_colaborador'];
    colaborador = json['colaborador'];
    cantidadCuotas = json['cantidad_cuotas'];
    cantidadCuotasPagadas = json['cantidad_cuotas_pagadas'];
    cantidadRefuerzos = json['cantidad_refuerzos'];
    cantidadRefuerzosPagados = json['cantidad_refuerzos_pagados'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_venta'] = this.idVenta;
    data['id_empresa'] = this.idEmpresa;
    data['id_sucursal'] = this.idSucursal;
    data['id_cliente'] = this.idCliente;
    data['cliente'] = this.cliente;
    data['id_vehiculo_sucursal'] = this.idVehiculoSucursal;
    data['chapa'] = this.chapa;
    data['chassis'] = this.chassis;
    data['combustible'] = this.combustible;
    data['color'] = this.color;
    data['motor'] = this.motor;
    data['ano'] = this.ano;
    data['cambio'] = this.cambio;
    data['marca'] = this.marca;
    data['modelo'] = this.modelo;
    data['entrada_guaranies'] = this.entradaGuaranies;
    data['entrada_dolares'] = this.entradaDolares;
    data['contado_guaranies'] = this.contadoGuaranies;
    data['contado_dolares'] = this.contadoDolares;
    data['fecha_venta'] = this.fechaVenta;
    data['id_colaborador'] = this.idColaborador;
    data['colaborador'] = this.colaborador;
    data['cantidad_cuotas'] = this.cantidadCuotas;
    data['cantidad_cuotas_pagadas'] = this.cantidadCuotasPagadas;
    data['cantidad_refuerzos'] = this.cantidadRefuerzos;
    data['cantidad_refuerzos_pagados'] = this.cantidadRefuerzosPagados;
    return data;
  }
}