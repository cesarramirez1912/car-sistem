class CuoteDetailModel {
  int? idCuotaVenta;
  int? cuotaGuaranies;
  dynamic? cuotaDolares;
  dynamic? pagoGuaranies;
  dynamic? pagoDolares;
  dynamic? fechaPago;
  String? fechaCuota;
  int? idVenta;
  String? anosMesesDias;

  CuoteDetailModel(
      {this.idCuotaVenta,
      this.cuotaGuaranies,
      this.cuotaDolares,
      this.pagoGuaranies,
      this.pagoDolares,
      this.fechaPago,
      this.fechaCuota,
      this.idVenta,
      this.anosMesesDias});

  CuoteDetailModel.fromJson(Map<String, dynamic> json) {
    idCuotaVenta = json['id_cuota_venta'];
    cuotaGuaranies = json['cuota_guaranies'];
    cuotaDolares = json['cuota_dolares'];
    pagoGuaranies = json['pago_guaranies'];
    pagoDolares = json['pago_dolares'];
    fechaPago = json['fecha_pago'];
    fechaCuota = json['fecha_cuota'];
    idVenta = json['id_venta'];
    anosMesesDias = json['anos_meses_dias'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_cuota_venta'] = this.idCuotaVenta;
    data['cuota_guaranies'] = this.cuotaGuaranies;
    data['cuota_dolares'] = this.cuotaDolares;
    data['pago_guaranies'] = this.pagoGuaranies;
    data['pago_dolares'] = this.pagoDolares;
    data['fecha_pago'] = this.fechaPago;
    data['fecha_cuota'] = this.fechaCuota;
    data['id_venta'] = this.idVenta;
    data['anos_meses_dias'] = this.anosMesesDias;
    return data;
  }
}
