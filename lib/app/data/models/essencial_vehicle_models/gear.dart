class Gear {
  Gear({
    required this.gear,
  });

  late final String gear;

  Gear.fromJson(Map<String, dynamic> json) {
    gear = json['cambio'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['cambio'] = gear;
    return _data;
  }
}
