class Category {
  Category({
    this.categoria,
    this.idCategoria,
  });

  String? categoria;
  dynamic? idCategoria;

  Category.fromJson(Map<String, dynamic> json) {
    categoria = json['categoria'];
    idCategoria = json['id_categoria'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['categoria'] = categoria;
    _data['id_categoria'] = idCategoria;
    return _data;
  }
}
