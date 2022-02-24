import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class DateFormatBr {
  String formatBrFromString(String dateString) {
    return DateFormat('dd/MM/yyyy').format(DateTime.parse(dateString));
  }

  String formatBrWithTime(String dateString) {
    return DateFormat('dd/MM/yyyy - hh:mm a')
        .format(DateTime.parse(dateString));
  }

  String formatBrMonthNamed(String dateString) {
    return months[DateTime.parse(dateString).month-1];
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