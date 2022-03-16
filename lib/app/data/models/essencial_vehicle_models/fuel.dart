class Fuel {
  Fuel({
    required this.combustible,
  });

  late final String combustible;

  Fuel.fromJson(Map<String, dynamic> json) {
    combustible = json['combustible'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['combustible'] = combustible;
    return _data;
  }
}
