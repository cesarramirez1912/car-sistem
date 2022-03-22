import 'package:intl/intl.dart';

class DateFormatBr {
  List<DateTime> getDaysBetweenDates(
      {required DateTime start, required DateTime end}) {
    final days = end.difference(start).inDays;
    return [for (int i = 0; i < days; i++) start.add(Duration(days: i))];
  }

  String formatBrFromDate(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }

  DateTime formatBrToUs(String? dateString) {
    if (dateString == null) {
      return DateTime.now();
    }
    return DateFormat('dd/MM/yyyy').parse(dateString).toLocal();
  }

  String formatBrFromString(String? dateString) {
    if (dateString == null) {
      return '';
    }
    return DateFormat('dd/MM/yyyy').format(DateTime.parse(dateString));
  }

  String formatBrWithTime(String dateString) {
    return DateFormat('dd/MM/yyyy - hh:mm a')
        .format(DateTime.parse(dateString));
  }

  String formatBrMonthNamed(String dateString) {
    return months[DateTime.parse(dateString).month - 1];
  }

  String _verifyDateAndMonth(int dayOrMonth) {
    if (dayOrMonth < 10) {
      return '0$dayOrMonth';
    } else {
      return dayOrMonth.toString();
    }
  }
}

const months = [
  'ENERO',
  'FEBRERO',
  'MARZO',
  'ABRIL',
  'MAYO',
  'JUNIO',
  'JULIO',
  'AGOSTO',
  'SEPTIEMBRE',
  'OCTUBRE',
  'NOVIEMBRE',
  'DICIEMBRE'
];
