import 'package:flutter/cupertino.dart';

import '../../core/theme/colors.dart';
import '../../core/utils/money_format.dart';

Widget centerText(dynamic value,
    {bool isGuaranies = true, Color colorText = ColorPalette.PRIMARY}) {
  return Text(
    MoneyFormat().formatCommaToDot(value.toString(), isGuaranies: isGuaranies),
    textAlign: TextAlign.center,
    style: TextStyle(color: colorText,fontSize: 12),
  );
}
