import 'package:intl/intl.dart';

class MoneyFormat {
  final formatter = NumberFormat.simpleCurrency(locale: "pt_Br");

  String formatCommaToDot(String value) {
    return formatter
        .format(double.parse(value))
        .replaceAll('R\$', "")
        .toString().replaceAll(',00', '');
  }
}
