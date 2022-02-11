import 'package:car_system/common/remove_money_format.dart';

String? validatorRefuerzoDinero(String text) {
  double refuerzoGuaraniesDouble = RemoveMoneyFormat().removeToDouble(text);
  double refuerzoDolaresDouble = RemoveMoneyFormat().removeToDouble(text);
  if (text.isEmpty) {
    return null;
  } else {
    if (refuerzoGuaraniesDouble == 0.0 && refuerzoDolaresDouble < 1) {
      return 'Campo obligatorio.';
    } else {
      return null;
    }
  }
}
