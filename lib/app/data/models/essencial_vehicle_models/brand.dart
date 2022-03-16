class Brand {
  String? marca;
  int? idMarca;

  Brand({this.marca, this.idMarca});

  Brand.fromJson(Map<String, dynamic> json) {
    marca = json['marca'];
    idMarca = json['id_marca'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['marca'] = this.marca;
    data['id_marca'] = this.idMarca;
    return data;
  }
}