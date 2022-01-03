class Model {
  Model({
    required this.modelo,
  });

  late final String modelo;

  Model.fromJson(Map<String, dynamic> json) {
    modelo = json['modelo'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['modelo'] = modelo;
    return _data;
  }
}
