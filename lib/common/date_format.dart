import 'package:intl/intl.dart';

class DateFormatBr {
  String formatBr(DateTime dateTime) {
    return '${_verifyDateAndMonth(dateTime.day)}/${_verifyDateAndMonth(dateTime.month)}/${_verifyDateAndMonth(dateTime.year)}';
  }

  String formatBrFromString(String dateString) {
    return DateFormat('dd/MM/yyyy')
        .format(DateTime.parse(dateString).toLocal());
  }
  String formatBrWithTime(String dateString) {
    return DateFormat('dd/MM/yyyy - hh:mm a')
        .format(DateTime.parse(dateString).toLocal());
  }

  String _verifyDateAndMonth(int dayOrMonth) {
    if (dayOrMonth < 10) {
      return '0$dayOrMonth';
    } else {
      return dayOrMonth.toString();
    }
  }
}
