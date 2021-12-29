class User {
  User({
    this.idEmpresa,
    this.empresa,
    this.idSucursal,
    this.direccion,
    this.cargo,
    this.idColaborador,
    this.colaborador,
    this.celular,
  });

  int? idEmpresa;
  String? empresa;
  int? idSucursal;
  String? direccion;
  String? cargo;
  int? idColaborador;
  String? colaborador;
  String? celular;

  User.fromJson(Map<String, dynamic> json) {
    idEmpresa = json['id_empresa'];
    empresa = json['empresa'];
    idSucursal = json['id_sucursal'];
    direccion = json['direccion'];
    cargo = json['cargo'];
    idColaborador = json['id_colaborador'];
    colaborador = json['colaborador'];
    celular = json['celular'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id_empresa'] = idEmpresa;
    _data['empresa'] = empresa;
    _data['id_sucursal'] = idSucursal;
    _data['direccion'] = direccion;
    _data['cargo'] = cargo;
    _data['id_colaborador'] = idColaborador;
    _data['colaborador'] = colaborador;
    _data['celular'] = celular;
    return _data;
  }
}
