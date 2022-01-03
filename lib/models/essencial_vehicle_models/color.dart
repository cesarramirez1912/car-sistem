class Color {
  Color({
    required this.color,
  });

  late final String color;

  Color.fromJson(Map<String, dynamic> json) {
    color = json['color'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['color'] = color;
    return _data;
  }
}
