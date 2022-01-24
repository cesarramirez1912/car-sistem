class ClientModel {
  ClientModel({
    this.idEmpresa,
    this.idSucursal,
    this.idCliente,
    this.cliente,
    this.ci,
    this.celular,
    this.direccion,
    this.ciudad,
  });

  int? idEmpresa;
  int? idSucursal;
  int? idCliente;
  String? cliente;
  String? ci;
  String? celular;
  String? direccion;
  String? ciudad;

  ClientModel.fromJson(Map<String, dynamic> json) {
    idEmpresa = json['id_empresa'];
    idSucursal = json['id_sucursal'];
    idCliente = json['id_cliente'];
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
    _data['id_cliente'] = idCliente;
    _data['cliente'] = cliente;
    _data['ci'] = ci;
    _data['celular'] = celular;
    _data['direccion'] = direccion;
    _data['ciudad'] = ciudad;
    return _data;
  }
}
