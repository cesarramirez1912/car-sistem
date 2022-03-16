class DeudorModel {
  int? idCuotaVenta;
  int? cuotaGuaranies;
  dynamic? cuotaDolares;
  dynamic? fechaPago;
  String? fechaCuota;
  int? totalDias;
  int? idEmpresa;
  int? idSucursal;
  int? idRefuerzoVenta;
  int? idVenta;
  dynamic? refuerzoGuaranies;
  int? refuerzoDolares;
  dynamic? pagoGuaranies;
  dynamic? pagoDolares;
  String? fechaRefuerzo;
  int? idVehiculoSucursal;
  dynamic? entradaGuaranies;
  dynamic? entradaDolares;
  String? fechaVenta;
  int? idCliente;
  String? cliente;
  String? celular;
  String? ciudad;
  String? direccion;
  String? ci;
  int? anos;
  int? meses;
  int? dias;
  String? tipoMoroso;
  String? anosMesesDias;

  DeudorModel(
      {this.idCuotaVenta,
      this.cuotaGuaranies,
      this.cuotaDolares,
      this.fechaPago,
      this.fechaCuota,
      this.totalDias,
      this.idEmpresa,
      this.idSucursal,
      this.idRefuerzoVenta,
      this.idVenta,
      this.refuerzoGuaranies,
      this.refuerzoDolares,
      this.pagoGuaranies,
      this.pagoDolares,
      this.fechaRefuerzo,
      this.idVehiculoSucursal,
      this.entradaGuaranies,
      this.entradaDolares,
      this.fechaVenta,
      this.idCliente,
      this.cliente,
      this.celular,
      this.ciudad,
      this.direccion,
      this.ci,
      this.anos,
      this.meses,
      this.dias,
      this.tipoMoroso,
      this.anosMesesDias});

  DeudorModel.fromJson(Map<String, dynamic> json) {
    idCuotaVenta = json['id_cuota_venta'];
    cuotaGuaranies = json['cuota_guaranies'];
    cuotaDolares = json['cuota_dolares'];
    fechaPago = json['fecha_pago'];
    fechaCuota = json['fecha_cuota'];
    totalDias = json['total_dias'];
    idEmpresa = json['id_empresa'];
    idSucursal = json['id_sucursal'];
    idRefuerzoVenta = json['id_refuerzo_venta'];
    idVenta = json['id_venta'];
    refuerzoGuaranies = json['refuerzo_guaranies'];
    refuerzoDolares = json['refuerzo_dolares'];
    pagoGuaranies = json['pago_guaranies'];
    pagoDolares = json['pago_dolares'];
    fechaRefuerzo = json['fecha_refuerzo'];
    idVehiculoSucursal = json['id_vehiculo_sucursal'];
    entradaGuaranies = json['entrada_guaranies'];
    entradaDolares = json['entrada_dolares'];
    fechaVenta = json['fecha_venta'];
    idCliente = json['id_cliente'];
    cliente = json['cliente'];
    celular = json['celular'];
    ciudad = json['ciudad'];
    direccion = json['direccion'];
    ci = json['ci'];
    anos = json['anos'];
    meses = json['meses'];
    dias = json['dias'];
    tipoMoroso = json['tipo_moroso'];
    anosMesesDias = json['anos_meses_dias'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_cuota_venta'] = this.idCuotaVenta;
    data['cuota_guaranies'] = this.cuotaGuaranies;
    data['cuota_dolares'] = this.cuotaDolares;
    data['fecha_pago'] = this.fechaPago;
    data['fecha_cuota'] = this.fechaCuota;
    data['total_dias'] = this.totalDias;
    data['id_empresa'] = this.idEmpresa;
    data['id_sucursal'] = this.idSucursal;
    data['id_refuerzo_venta'] = this.idRefuerzoVenta;
    data['id_venta'] = this.idVenta;
    data['refuerzo_guaranies'] = this.refuerzoGuaranies;
    data['refuerzo_dolares'] = this.refuerzoDolares;
    data['pago_guaranies'] = this.pagoGuaranies;
    data['pago_dolares'] = this.pagoDolares;
    data['fecha_refuerzo'] = this.fechaRefuerzo;
    data['id_vehiculo_sucursal'] = this.idVehiculoSucursal;
    data['entrada_guaranies'] = this.entradaGuaranies;
    data['entrada_dolares'] = this.entradaDolares;
    data['fecha_venta'] = this.fechaVenta;
    data['id_cliente'] = this.idCliente;
    data['cliente'] = this.cliente;
    data['celular'] = this.celular;
    data['ciudad'] = this.ciudad;
    data['direccion'] = this.direccion;
    data['ci'] = this.ci;
    data['anos'] = this.anos;
    data['meses'] = this.meses;
    data['dias'] = this.dias;
    data['tipo_moroso'] = this.tipoMoroso;
    data['anos_meses_dias'] = this.anosMesesDias;
    return data;
  }
}
