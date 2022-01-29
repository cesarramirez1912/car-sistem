import 'package:intl/intl.dart';

class DateFormatBr {


  String formatBrFromString(String dateString) {
    return DateFormat('dd/MM/yyyy').format(DateTime.parse(dateString));
  }

  String formatBrWithTime(String dateString) {
    return DateFormat('dd/MM/yyyy - hh:mm a')
        .format(DateTime.parse(dateString));
  }

  String _verifyDateAndMonth(int dayOrMonth) {
    if (dayOrMonth < 10) {
      return '0$dayOrMonth';
    } else {
      return dayOrMonth.toString();
    }
  }
}
