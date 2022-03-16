import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:intl/intl.dart';

class MoneyFormat {
  final formatter = NumberFormat.simpleCurrency(locale: "pt_Br");

  String formatCommaToDot(dynamic value, {bool isGuaranies = true}) {
    if (value == null) {
      if (isGuaranies) {
        return 'G\$ - ';
      }
      return 'U\$ - ';
    } else {
      var newDouble = double.parse(value.toString());
      if (isGuaranies) {
        return MoneyMaskedTextController(
                leftSymbol: 'G\$ ',
                precision: 0,
                decimalSeparator: '',
                initialValue: newDouble)
            .text;
      } else {
        return MoneyMaskedTextController(
                leftSymbol: 'U\$ ', initialValue: newDouble)
            .text;
      }
      return formatter
          .format(double.parse(value.toString()))
          .replaceAll('R\$', "")
          .toString()
          .replaceAll(',00', '');
    }
  }
}
