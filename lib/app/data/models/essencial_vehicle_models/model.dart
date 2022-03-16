class Model {
  String? modelo;
  int? idModelo;
  int? idMarca;
  int? idCategoria;

  Model({this.modelo, this.idModelo, this.idMarca, this.idCategoria});

  Model.fromJson(Map<String, dynamic> json) {
    modelo = json['modelo'];
    idModelo = json['id_modelo'];
    idMarca = json['id_marca'];
    idCategoria = json['id_categoria'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['modelo'] = this.modelo;
    data['id_modelo'] = this.idModelo;
    data['id_marca'] = this.idMarca;
    data['id_categoria'] = this.idCategoria;
    return data;
  }
}
