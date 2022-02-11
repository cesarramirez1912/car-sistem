class RefuerzoDetailModel {
  int? idRefuerzoVenta;
  dynamic? refuerzoGuaranies;
  dynamic? refuerzoDolares;
  dynamic? pagoGuaranies;
  dynamic? pagoDolares;
  String? fechaPago;
  String? fechaRefuerzo;
  int? idVenta;
  String? anosMesesDias;

  RefuerzoDetailModel(
      {this.idRefuerzoVenta,
      this.refuerzoGuaranies,
      this.refuerzoDolares,
      this.pagoGuaranies,
      this.pagoDolares,
      this.fechaPago,
      this.fechaRefuerzo,
      this.idVenta,
      this.anosMesesDias});

  RefuerzoDetailModel.fromJson(Map<String, dynamic> json) {
    idRefuerzoVenta = json['id_refuerzo_venta'];
    refuerzoGuaranies = json['refuerzo_guaranies'];
    refuerzoDolares = json['refuerzo_dolares'];
    pagoGuaranies = json['pago_guaranies'];
    pagoDolares = json['pago_dolares'];
    fechaPago = json['fecha_pago'];
    fechaRefuerzo = json['fecha_refuerzo'];
    idVenta = json['id_venta'];
    anosMesesDias = json['anos_meses_dias'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_refuerzo_venta'] = this.idRefuerzoVenta;
    data['refuerzo_guaranies'] = this.refuerzoGuaranies;
    data['refuerzo_dolares'] = this.refuerzoDolares;
    data['pago_guaranies'] = this.pagoGuaranies;
    data['pago_dolares'] = this.pagoDolares;
    data['fecha_pago'] = this.fechaPago;
    data['fecha_refuerzo'] = this.fechaRefuerzo;
    data['id_venta'] = this.idVenta;
    data['anos_meses_dias'] = this.anosMesesDias;
    return data;
  }
}
