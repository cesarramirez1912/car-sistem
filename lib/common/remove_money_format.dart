class RemoveMoneyFormat {
  dynamic format(dynamic text) {
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
}
