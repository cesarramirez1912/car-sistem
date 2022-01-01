class RegisterClient {
  RegisterClient({
    required this.idEmpresa,
    required this.idSucursal,
    required this.cliente,
    required this.ci,
    required this.celular,
    required this.direccion,
    required this.ciudad,
  });

  late final int idEmpresa;
  late final int idSucursal;
  late final String cliente;
  late final String ci;
  late final String celular;
  late final String direccion;
  late final String ciudad;

  RegisterClient.fromJson(Map<String, dynamic> json) {
    idEmpresa = json['id_empresa'];
    idSucursal = json['id_sucursal'];
    cliente = json['cliente'];
    ci = json['ci'];
    celular = json['celular'];
    direccion = json['direccion'];
    ciudad = json['ciudad'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id_empresa'] = idEmpresa;
    _data['id_sucursal'] = idSucursal;
    _data['cliente'] = cliente;
    _data['ci'] = ci;
    _data['celular'] = celular;
    _data['direccion'] = direccion;
    _data['ciudad'] = ciudad;
    return _data;
  }
}
