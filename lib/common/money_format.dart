import 'package:intl/intl.dart';

class MoneyFormat {
  final formatter = NumberFormat.simpleCurrency(locale: "pt_Br");

  String formatCommaToDot(dynamic value) {
    if (value == null) {
      return '-';
    } else {
      return formatter
          .format(double.parse(value.toString()))
          .replaceAll('R\$', "")
          .toString()
          .replaceAll(',00', '');
    }
  }
}
