import '../app/data/models/cuotes.dart';

class CreateVehicle {
  CreateVehicle({
    this.idEmpresa,
    this.idSucursal,
    this.idModelo,
    this.combustible,
    this.color,
    this.motor,
    this.ano,
    this.cambio,
    this.chapa,
    this.chassis,
    this.costoGuaranies,
    this.costoDolares,
    this.contadoGuaranies,
    this.contadoDolares,
    this.cuotas,
  });

  int? idEmpresa;
  int? idSucursal;
  int? idModelo;
  String? combustible;
  String? color;
  String? motor;
  String? ano;
  String? cambio;
  String? chapa;
  String? chassis;
  dynamic? costoGuaranies;
  dynamic? costoDolares;
  dynamic? contadoGuaranies;
  dynamic? contadoDolares;
  List<Cuota>? cuotas;

  CreateVehicle.fromJson(Map<String, dynamic> json) {
    idEmpresa = json['id_empresa'];
    idSucursal = json['id_sucursal'];
    idModelo = json['id_modelo'];
    combustible = json['combustible'];
    color = json['color'];
    motor = json['motor'];
    ano = json['ano'];
    cambio = json['cambio'];
    chapa = json['chapa'];
    chassis = json['chassis'];
    costoGuaranies = json['costo_guaranies'];
    costoDolares = json['costo_dolares'];
    contadoGuaranies = json['contado_guaranies'];
    contadoDolares = json['contado_dolares'];
    cuotas = List.from(json['cuotas']).map((e) => Cuota.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id_empresa'] = idEmpresa;
    _data['id_sucursal'] = idSucursal;
    _data['id_modelo'] = idModelo;
    _data['combustible'] = combustible;
    _data['color'] = color;
    _data['motor'] = motor;
    _data['ano'] = ano;
    _data['cambio'] = cambio;
    _data['chapa'] = chapa;
    _data['chassis'] = chassis;
    _data['costo_guaranies'] = costoGuaranies;
    _data['costo_dolares'] = costoDolares;
    _data['contado_guaranies'] = contadoGuaranies;
    _data['contado_dolares'] = contadoDolares;
    _data['cuotas'] = cuotas?.map((e) => e.toJson()).toList();
    return _data;
  }
}
