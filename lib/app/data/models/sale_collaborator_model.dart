class SaleCollaboratorModel {
  int? idVenta;
  int? idEmpresa;
  int? idSucursal;
  int? idCliente;
  String? cliente;
  int? idVehiculoSucursal;
  String? ci;
  dynamic? celular;
  String? ciudad;
  String? direccion;
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
  dynamic? cuotaGuaranies;
  dynamic? cuotaDolares;
  dynamic? refuerzoGuaranies;
  dynamic? refuerzoDolares;
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
        this.cuotaDolares,
        this.cuotaGuaranies,
        this.refuerzoGuaranies,
        this.refuerzoDolares,
      this.fechaVenta,
      this.idColaborador,
      this.colaborador,
      this.cantidadCuotas,
      this.cantidadCuotasPagadas,
      this.cantidadRefuerzos,
      this.cantidadRefuerzosPagados});

  SaleCollaboratorModel.fromJson(Map<dynamic, dynamic> json) {
    idVenta = json['id_venta'];
    idEmpresa = json['id_empresa'];
    idSucursal = json['id_sucursal'];
    idCliente = json['id_cliente'];
    ci = json['ci'];
    celular = json['celular'];
    ciudad = json['ciudad'];
    direccion = json['direccion'];
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
    cuotaGuaranies = json['cuota_guaranies'];
    cuotaDolares = json['cuota_dolares'];
    refuerzoGuaranies = json['refuerzo_guaranies'];
    refuerzoDolares = json['refuerzo_dolares'];
    fechaVenta = json['fecha_venta'];
    idColaborador = json['id_colaborador'];
    colaborador = json['colaborador'];
    cantidadCuotas = json['cantidad_cuotas'];
    cantidadCuotasPagadas = json['cantidad_cuotas_pagadas'];
    cantidadRefuerzos = json['cantidad_refuerzos'];
    cantidadRefuerzosPagados = json['cantidad_refuerzos_pagados'];
  }

  SaleCollaboratorModel.fromMapStringString(Map<dynamic, dynamic> json) {
    idVenta = int.parse(json['id_venta']);
    idEmpresa = int.parse(json['id_empresa']);
    idSucursal = int.parse(json['id_sucursal']);
    idCliente = int.parse(json['id_cliente']);
    ci = verifycationNull(json['ci']);
    celular = verifycationNull(json['celular']);
    ciudad = verifycationNull(json['ciudad']);
    direccion = verifycationNull(json['direccion']);
    cliente = verifycationNull(json['cliente']);
    idVehiculoSucursal = int.parse(json['id_vehiculo_sucursal']);
    chapa = verifycationNull(json['chapa']);
    chassis =verifycationNull(json['chassis']);
    combustible = verifycationNull(json['combustible']);
    color = verifycationNull(json['color']);
    motor = verifycationNull(json['motor']);
    ano = verifycationNull(json['ano']);
    cambio = verifycationNull(json['cambio']);
    marca = verifycationNull(json['marca']);
    modelo = verifycationNull(json['modelo']);
    entradaGuaranies = verifycationDouble(json['entrada_guaranies']);
    entradaDolares = verifycationDouble(json['entrada_dolares']);
    contadoGuaranies = verifycationDouble(json['contado_guaranies']);
    contadoDolares = verifycationDouble(json['contado_dolares']);
    cuotaGuaranies = verifycationDouble(json['cuota_guaranies']);
    cuotaDolares = verifycationDouble(json['cuota_dolares']);
    refuerzoGuaranies = verifycationDouble(json['refuerzo_guaranies']);
    refuerzoDolares = verifycationDouble(json['refuerzo_dolares']);
    fechaVenta = verifycationNull(json['fecha_venta']);
    idColaborador = int.parse(json['id_colaborador']);
    colaborador = verifycationNull(json['colaborador']);
    cantidadCuotas = verifycationInt(json['cantidad_cuotas']);
    cantidadCuotasPagadas = verifycationInt(json['cantidad_cuotas_pagadas']);
    cantidadRefuerzos = verifycationInt(json['cantidad_refuerzos']);
    cantidadRefuerzosPagados = verifycationInt(json['cantidad_refuerzos_pagados']);
  }

  dynamic? verifycationNull(value) {
    if (value != 'null') {
      return value;
    } else {
      return null;
    }
  }

  dynamic? verifycationDouble(value) {
    if (value != 'null') {
      return double.parse(value);
    } else {
      return null;
    }
  }

  dynamic? verifycationInt(value) {
    if (value != 'null') {
      return int.parse(value);
    } else {
      return null;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_venta'] = this.idVenta;
    data['id_empresa'] = this.idEmpresa;
    data['id_sucursal'] = this.idSucursal;
    data['id_cliente'] = this.idCliente;
    data['cliente'] = this.cliente;
    data['ci'] = this.ci;
    data['celular'] = this.celular;
    data['ciudad'] = this.ciudad;
    data['direccion'] = this.direccion;
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
    data['cuota_guaranies'] = this.cuotaGuaranies;
    data['cuota_dolares'] = this.cuotaDolares;
    data['refuerzo_guaranies'] = this.refuerzoGuaranies;
    data['refuerzo_dolares'] = this.refuerzoDolares;
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
