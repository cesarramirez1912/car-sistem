import 'package:car_system/app/core/utils/remove_money_format.dart';
import 'package:car_system/app/global_widgets/dialog.dart';
import 'package:car_system/app/global_widgets/input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:get/get.dart';
import '../../core/utils/date_format.dart';
import '../../data/models/date_value_model.dart';
import '../../global_widgets/textInputContainer.dart';

class DatesVencController extends GetxController {
  final RemoveMoneyFormat _removeMoneyFormat = RemoveMoneyFormat();

  RxInt selectedIndex = 0.obs;
  RxBool isDolar = false.obs;

  RxList<DateValue> listDateGeneratedCuotas = <DateValue>[].obs;
  RxList<DateValue> listDateGeneratedRefuerzos = <DateValue>[].obs;

  MoneyMaskedTextController textCuotaGuaranies = MoneyMaskedTextController(leftSymbol: 'G\$ ', precision: 0, decimalSeparator: '');
  MoneyMaskedTextController textCuotaDolares = MoneyMaskedTextController(leftSymbol: 'U\$ ');

  MoneyMaskedTextController textRefuerzoGuaranies = MoneyMaskedTextController(leftSymbol: 'G\$ ', precision: 0, decimalSeparator: '');
  MoneyMaskedTextController textRefuerzoDolares = MoneyMaskedTextController(leftSymbol: 'U\$ ');

  Future<void> changeDateCuote(BuildContext context, int _index) async {
    List<DateValue> _aux = [...listDateGeneratedCuotas];
    final DateTime? picked = await showDatePicker(
        context: context,
        locale: const Locale('es'),
        initialDate: _aux[_index].date!,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != _aux[_index].date) {
      _aux[_index].date = picked;
      listDateGeneratedCuotas.clear();
      listDateGeneratedCuotas.addAll(_aux);
    }
  }

  Future<void> changeDateRefuerzo(BuildContext context, int _index) async {
    List<DateValue> _aux = [...listDateGeneratedRefuerzos];
    final DateTime? picked = await showDatePicker(
        context: context,
        locale: const Locale('es'),
        initialDate: _aux[_index].date!,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != _aux[_index].date) {
      _aux[_index].date = picked;
      listDateGeneratedRefuerzos.clear();
      listDateGeneratedRefuerzos.addAll(_aux);
    }
  }

  Future<void> changeValueCuote(BuildContext context, int _index) async {
    List<DateValue> _aux = [...listDateGeneratedCuotas];
    if (isDolar.value) {
      textCuotaDolares.text = _aux[_index].cuotaDolares;
    } else {
      textCuotaGuaranies.text = _aux[_index].cuotaGuaranies;
    }
    bool? res = await CustomDialog(
      context,
      body: CustomInput('', 'Valor cuota:',
          textEditingController:
              isDolar.value ? textCuotaDolares : textCuotaGuaranies),
    );
    if(res!=null){
      if(res){
        if(isDolar.value){
          _aux[_index].cuotaDolares = _removeMoneyFormat.removeToDouble(textCuotaDolares.text);
        }else{
          _aux[_index].cuotaGuaranies = _removeMoneyFormat.removeToString(textCuotaGuaranies.text);
        }
      }
    }
    listDateGeneratedCuotas.clear();
    listDateGeneratedCuotas.addAll(_aux);
  }

  Future<void> changeValueRefuerzo(BuildContext context, int _index) async {
    List<DateValue> _aux = [...listDateGeneratedRefuerzos];
    if (isDolar.value) {
      textRefuerzoDolares.text = _aux[_index].refuerzoDolares;
    } else {
      textRefuerzoGuaranies.text = _aux[_index].refuerzoGuaranies;
    }
    bool? res = await CustomDialog(
      context,
      body: CustomInput('', 'Valor refuerzo:',
          textEditingController:
          isDolar.value ? textRefuerzoDolares : textRefuerzoGuaranies),
    );
    if(res!=null){
      if(res){
        if(isDolar.value){
          _aux[_index].refuerzoDolares = _removeMoneyFormat.removeToDouble(textRefuerzoDolares.text);
        }else{
          _aux[_index].refuerzoGuaranies = _removeMoneyFormat.removeToString(textRefuerzoGuaranies.text);
        }
      }
    }
    listDateGeneratedRefuerzos.clear();
    listDateGeneratedRefuerzos.addAll(_aux);
  }


  void changeSelectedIndex(int _index) {
    selectedIndex.value = _index;
  }

  void changeIsDolar(bool _isDolar) {
    isDolar.value = _isDolar;
  }

  void changeListCuotas(List<DateValue> _listCuotes) {
    listDateGeneratedCuotas.clear();
    listDateGeneratedCuotas.addAll(_listCuotes);
  }

  void changeListRefuerzos(List<DateValue> _listRefuerzos) {
    listDateGeneratedRefuerzos.clear();
    listDateGeneratedRefuerzos.addAll(_listRefuerzos);
  }
}
