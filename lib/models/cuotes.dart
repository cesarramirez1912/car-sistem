class Cuota {
  Cuota({
    this.cantidadCuotas,
    this.cuotaGuaranies,
    this.cuotaDolares,
    this.idVehiculoSucursal,
    this.cantidadRefuerzo,
    this.refuerzoGuaranies,
    this.refuerzoDolares,
    this.entradaGuaranies,
    this.entradaDolares,
  });

  dynamic? cantidadCuotas;
  dynamic? cuotaGuaranies;
  dynamic? cuotaDolares;
  int? idVehiculoSucursal;
  dynamic? cantidadRefuerzo;
  dynamic? refuerzoGuaranies;
  dynamic? refuerzoDolares;
  dynamic? entradaGuaranies;
  dynamic? entradaDolares;

  Cuota.fromJson(Map<String, dynamic> json) {
    cantidadCuotas = json['cantidad_cuotas'];
    cuotaGuaranies = json['cuota_guaranies'];
    cuotaDolares = json['cuota_dolares'];
    idVehiculoSucursal = json['id_vehiculo_sucursal'];
    cantidadRefuerzo = json['cantidad_refuerzo'];
    refuerzoGuaranies = json['refuerzo_guaranies'];
    refuerzoDolares = json['refuerzo_dolares'];
    entradaGuaranies = json['entrada_guaranies'];
    entradaDolares = json['entrada_dolares'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['cantidad_cuotas'] = cantidadCuotas;
    _data['cuota_guaranies'] = cuotaGuaranies;
    _data['cuota_dolares'] = cuotaDolares;
    _data['id_vehiculo_sucursal'] = idVehiculoSucursal;
    _data['cantidad_refuerzo'] = cantidadRefuerzo;
    _data['refuerzo_guaranies'] = refuerzoGuaranies;
    _data['refuerzo_dolares'] = refuerzoDolares;
    _data['entrada_guaranies'] = entradaGuaranies;
    _data['entrada_dolares'] = entradaDolares;
    return _data;
  }
}
