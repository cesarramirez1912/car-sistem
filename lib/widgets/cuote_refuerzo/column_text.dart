import 'package:car_system/colors.dart';
import 'package:car_system/common/date_format.dart';
import 'package:car_system/common/money_format.dart';
import 'package:flutter/cupertino.dart';

List<Widget> columnText(dynamic value, dynamic fecha,
    {bool isGuaranies = true, Color colorText = ColorPalette.GREEN}) {
  return [
    Text(
      MoneyFormat()
          .formatCommaToDot(value.toString(), isGuaranies: isGuaranies),
      textAlign: TextAlign.center,
      style: TextStyle(color: colorText, fontSize: 12),
    ),
    const SizedBox(
      height: 4,
    ),
    Text(
      DateFormatBr().formatBrFromString(fecha.toString()),
      textAlign: TextAlign.center,
      style: const TextStyle(fontSize: 12),
    ),
  ];
}
