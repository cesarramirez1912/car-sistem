class Brand {
  Brand({
    required this.marca,
  });

  late final String marca;

  Brand.fromJson(Map<String, dynamic> json) {
    marca = json['marca'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['marca'] = marca;
    return _data;
  }
}
