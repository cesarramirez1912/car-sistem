import '../../core/theme/colors.dart';
import 'package:flutter/cupertino.dart';

import '../../core/utils/money_format.dart';

Widget pendienteText(dynamic value, {bool isGuaranies = true}) {
  return Text(
    MoneyFormat().formatCommaToDot(value<0?'0':value.toString(), isGuaranies: isGuaranies),
    textAlign: TextAlign.center,
    style: TextStyle(
        color: value != 0 ? ColorPalette.PRIMARY : ColorPalette.GREEN,
        fontSize: 12),
  );
}
