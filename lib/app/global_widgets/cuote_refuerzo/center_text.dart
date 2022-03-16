import 'package:car_system/colors.dart';
import 'package:car_system/common/money_format.dart';
import 'package:flutter/cupertino.dart';

Widget centerText(dynamic value,
    {bool isGuaranies = true, Color colorText = ColorPalette.PRIMARY}) {
  return Text(
    MoneyFormat().formatCommaToDot(value.toString(), isGuaranies: isGuaranies),
    textAlign: TextAlign.center,
    style: TextStyle(color: colorText,fontSize: 12),
  );
}
