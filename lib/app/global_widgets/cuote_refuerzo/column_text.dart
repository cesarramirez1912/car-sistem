import 'package:car_system/app/core/theme/colors.dart';
import 'package:flutter/cupertino.dart';
import '../../core/utils/date_format.dart';
import '../../core/utils/money_format.dart';

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
