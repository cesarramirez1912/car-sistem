class DateValue {
  DateValue(
      {this.date,
      this.cuotaGuaranies,
      this.cuotaDolares,
      this.refuerzoGuaranies,
      this.refuerzoDolares,
        this.fecha_pago_cuota,
      });

  DateTime? date;
  DateTime? fecha_pago_cuota;

  dynamic cuotaGuaranies;
  dynamic cuotaDolares;
  dynamic refuerzoGuaranies;
  dynamic refuerzoDolares;
}
