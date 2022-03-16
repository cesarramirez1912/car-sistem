class RemoveMoneyFormat {
  dynamic removeToString(dynamic text) {
    if (text == null) {
      return null;
    } else {
      return text
          .toString()
          .replaceAll('U\$', '')
          .replaceAll('G\$', '')
          .replaceAll('.', '')
          .replaceAll(',', '.')
          .replaceAll(' ', '');
    }
  }

  double removeToDouble(dynamic text) {
    if (removeToString(text) == null || removeToString(text) == '') {
      return 0.0;
    } else {
      return double.parse(removeToString(text));
    }
  }
}
