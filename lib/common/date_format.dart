class DateFormat {
  String formatBr(DateTime dateTime) {
    return '${_verifyDateAndMonth(dateTime.day)}/${_verifyDateAndMonth(dateTime.month)}/${_verifyDateAndMonth(dateTime.year)}';
  }

  String _verifyDateAndMonth(int dayOrMonth) {
    if (dayOrMonth < 10) {
      return '0$dayOrMonth';
    } else {
      return dayOrMonth.toString();
    }
  }
}
