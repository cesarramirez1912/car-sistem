class Vehicle {
  Vehicle({
    this.idVehiculoSucursal,
    this.idEmpresa,
    this.idSucursal,
    this.chapa,
    this.chassis,
    this.costoGuaranies,
    this.costoDolares,
    this.contadoGuaranies,
    this.contadoDolares,
    this.combustible,
    this.color,
    this.motor,
    this.ano,
    this.cambio,
    this.marca,
    this.modelo,
    this.cantidadCuotas,
    this.cuotaGuaranies,
    this.cuotaDolares,
    this.cantidadRefuerzo,
    this.refuerzoGuaranies,
    this.refuerzoDolares,
    this.entradaGuaranies,
    this.entradaDolares,
  });

  late final int? idVehiculoSucursal;
  late final int? idEmpresa;
  late final int? idSucursal;
  dynamic? chapa;
  dynamic? chassis;
  dynamic costoGuaranies;
  dynamic costoDolares;
  late final dynamic contadoGuaranies;
  dynamic contadoDolares;
  late final String? combustible;
  late final String? color;
  late final String? motor;
  late final String? ano;
  late final String? cambio;
  late final String? marca;
  late final String? modelo;
  late final dynamic? cantidadCuotas;
  dynamic? cuotaGuaranies;
  dynamic? cuotaDolares;
  late final int? cantidadRefuerzo;
  late final dynamic? refuerzoGuaranies;
  late final dynamic? refuerzoDolares;
  late final dynamic? entradaGuaranies;
  late final dynamic? entradaDolares;

  Vehicle.fromJson(Map<String, dynamic> json) {
    idVehiculoSucursal = json['id_vehiculo_sucursal'];
    idEmpresa = json['id_empresa'];
    idSucursal = json['id_sucursal'];
    chapa = json['chapa'];
    chassis = json['chassis'];
    costoGuaranies = json['costo_guaranies'];
    costoDolares = json['costo_dolares'];
    contadoGuaranies = json['contado_guaranies'];
    contadoDolares = json['contado_dolares'];
    combustible = json['combustible'];
    color = json['color'];
    motor = json['motor'];
    ano = json['ano'];
    cambio = json['cambio'];
    marca = json['marca'];
    modelo = json['modelo'];
    cantidadCuotas = json['cantidad_cuotas'];
    cuotaGuaranies = json['cuota_guaranies'];
    cuotaDolares = json['cuota_dolares'];
    cantidadRefuerzo = json['cantidad_refuerzo'];
    refuerzoGuaranies = json['refuerzo_guaranies'];
    refuerzoDolares = json['refuerzo_dolares'];
    entradaGuaranies = json['entrada_guaranies'];
    entradaDolares = json['entrada_dolares'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id_vehiculo_sucursal'] = idVehiculoSucursal;
    _data['id_empresa'] = idEmpresa;
    _data['id_sucursal'] = idSucursal;
    _data['chapa'] = chapa;
    _data['chassis'] = chassis;
    _data['costo_guaranies'] = costoGuaranies;
    _data['costo_dolares'] = costoDolares;
    _data['contado_guaranies'] = contadoGuaranies;
    _data['contado_dolares'] = contadoDolares;
    _data['combustible'] = combustible;
    _data['color'] = color;
    _data['motor'] = motor;
    _data['ano'] = ano;
    _data['cambio'] = cambio;
    _data['marca'] = marca;
    _data['modelo'] = modelo;
    _data['cantidad_cuotas'] = cantidadCuotas;
    _data['cuota_guaranies'] = cuotaGuaranies;
    _data['cuota_dolares'] = cuotaDolares;
    _data['cantidad_refuerzo'] = cantidadRefuerzo;
    _data['refuerzo_guaranies'] = refuerzoGuaranies;
    _data['refuerzo_dolares'] = refuerzoDolares;
    _data['entrada_guaranies'] = entradaGuaranies;
    _data['entrada_dolares'] = entradaDolares;
    return _data;
  }
}
