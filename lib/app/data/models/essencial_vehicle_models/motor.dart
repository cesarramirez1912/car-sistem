class Motor {
  Motor({
    required this.motor,
  });

  late final String motor;

  Motor.fromJson(Map<String, dynamic> json) {
    motor = json['motor'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['motor'] = motor;
    return _data;
  }
}
