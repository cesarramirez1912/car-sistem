import 'package:car_system/colors.dart';
import 'package:car_system/common/money_format.dart';
import 'package:flutter/cupertino.dart';

Widget pendienteText(dynamic value, {bool isGuaranies = true}) {
  return Text(
    MoneyFormat().formatCommaToDot(value.toString(), isGuaranies: isGuaranies),
    textAlign: TextAlign.center,
    style: TextStyle(
        color: value != 0 ? ColorPalette.PRIMARY : ColorPalette.GREEN,
        fontSize: 12),
  );
}
