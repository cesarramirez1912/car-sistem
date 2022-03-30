import 'package:car_system/app/core/utils/date_format.dart';
import 'package:car_system/app/core/utils/remove_money_format.dart';
import 'package:car_system/app/data/models/refuerzo_detail_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:get/get.dart';
import '../../data/models/cuote_detail_model.dart';
import '../../data/models/date_value_model.dart';
import '../dates_venc/dates_venc_controller.dart';
import '../sells/sells_from_collaborator_controller.dart';

class NewDatesController extends GetxController {
  final SellsFromCollaboratorController _sellsFromCollaboratorController =
      Get.find();
  final DatesVencController datesVencController = Get.find();

  RxString typeCobroMensualSelected = '12 MESES'.obs;
  RxList<String> typesCobroMensuales = ['12 MESES', '6 MESES', '3 MESES'].obs;

  List<DateValue> listDateGeneratedCuotas = [];
  List<DateValue> listDateGeneratedRefuerzos = [];

  final RemoveMoneyFormat _remove = RemoveMoneyFormat();

  RxBool isLoading = false.obs;
  RxBool isDolar = false.obs;

  // CUOTAS
  Rx<DateTime> initialDateCuote = DateTime.utc(
          DateTime.now().year, DateTime.now().month, DateTime.now().day)
      .obs;
  TextEditingController quantCuotesController = TextEditingController();
  MoneyMaskedTextController? textGuaraniesCuotas = MoneyMaskedTextController(
      leftSymbol: 'G\$ ', precision: 0, decimalSeparator: '');
  MoneyMaskedTextController? textDolaresCuotas =
      MoneyMaskedTextController(leftSymbol: 'U\$ ');

  // REFUERZOS
  Rx<DateTime> initialDateRefuerzo = DateTime.utc(
          DateTime.now().year, DateTime.now().month, DateTime.now().day)
      .obs;
  TextEditingController quantRefuerzosController = TextEditingController();
  MoneyMaskedTextController? textGuaraniesRefuerzos = MoneyMaskedTextController(
      leftSymbol: 'G\$ ', precision: 0, decimalSeparator: '');
  MoneyMaskedTextController? textDolaresRefuerzos =
      MoneyMaskedTextController(leftSymbol: 'U\$ ');

  @override
  void onInit() async {
    super.onInit();
    List<CuoteDetailModel> listCuotes =
        _sellsFromCollaboratorController.listaCuotes;
    List<RefuerzoDetailModel> listRefuerzos =
        _sellsFromCollaboratorController.listaRefuerzos;
    initialCuote(listCuotes);
    initialRefuerzo(listRefuerzos);
    generatedDatesCuotes();
    generatedDatesRefuerzos();
  }

  void initialCuote(List<CuoteDetailModel> listCuotes) {
    String fechaStr = listCuotes.first.fechaCuota!;
    initialDateCuote.value = DateFormatBr().formatLocalFromString(fechaStr);
    quantCuotesController.text = listCuotes.length.toString();
    if (listCuotes.first.cuotaDolares != null) {
      isDolar.value = true;
      datesVencController.isDolar.value = true;
    }
    textGuaraniesCuotas?.text = listCuotes.last.cuotaGuaranies != null
        ? listCuotes.last.cuotaGuaranies.toString()
        : '0.00';

    textDolaresCuotas?.text = listCuotes.last.cuotaDolares != null
        ? double.parse(listCuotes.last.cuotaDolares.toString())
            .toStringAsFixed(2)
        : '0.00';

  }

  void initialRefuerzo(List<RefuerzoDetailModel> listRefuerzos) {
    String fechaStr = listRefuerzos.first.fechaRefuerzo!;
    initialDateRefuerzo.value = DateFormatBr().formatLocalFromString(fechaStr);
    quantRefuerzosController.text = listRefuerzos.length.toString();
    textGuaraniesRefuerzos?.text = listRefuerzos.last.refuerzoGuaranies != null
        ? listRefuerzos.last.refuerzoGuaranies.toString()
        : '0.00';

    textDolaresRefuerzos?.text = listRefuerzos.last.refuerzoDolares != null
        ? double.parse(listRefuerzos.last.refuerzoDolares.toString())
            .toStringAsFixed(2)
        : '0.00';
  }

  Future<void> changeInitialDateCuote(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: initialDateCuote.value,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != initialDateCuote.value) {
      initialDateCuote.value = picked;
      generatedDatesCuotes();
    }
  }

  Future<void> changeInitialDateRefuerzo(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: initialDateRefuerzo.value,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != initialDateRefuerzo.value) {
      initialDateRefuerzo.value = picked;
      generatedDatesRefuerzos();
    }
  }

  void changeQuantCuotes(dynamic value) async {
    int? intValue = int.tryParse(value);
    if (intValue != null) {
      quantCuotesController.text = value;
      quantCuotesController.selection =  TextSelection.collapsed(offset: value.toString().length);
      generatedDatesCuotes();
    }
  }

  void changeQuantRefuerzos(dynamic value) async {
    int? intValue = int.tryParse(value);
    if (intValue != null) {
      quantRefuerzosController.text = value;
      quantRefuerzosController.selection =  TextSelection.collapsed(offset: value.toString().length);
      generatedDatesRefuerzos();
    }
  }

  void changeValueCuote(dynamic value) async {
    if (isDolar.value) {
      double doubleCuote = RemoveMoneyFormat().removeToDouble(value.toString());
      textDolaresCuotas?.text = doubleCuote.toStringAsFixed(2);
      generatedDatesCuotes();
    } else {
      String guaranies = RemoveMoneyFormat().removeToString(value.toString());
      textGuaraniesCuotas?.text = int.parse(guaranies).toString();
      generatedDatesCuotes();
    }
  }

  void changeValueRefuerzo(dynamic value) async {
    if (isDolar.value) {
      double doubleCuote = RemoveMoneyFormat().removeToDouble(value.toString());
      textDolaresRefuerzos?.text = doubleCuote.toStringAsFixed(2);
      generatedDatesRefuerzos();
    } else {
      String guaranies = RemoveMoneyFormat().removeToString(value.toString());
      textGuaraniesRefuerzos?.text = int.parse(guaranies).toString();
      generatedDatesRefuerzos();
    }
  }

  void changeEntreMeses(dynamic value) async {
    typeCobroMensualSelected.value = value;
    typeCobroMensualSelected.value = value;
    generatedDatesRefuerzos();
  }

  void generatedDatesCuotes() {
    listDateGeneratedCuotas = List<DateValue>.generate(
      int.parse(quantCuotesController.text),
      (i) => DateValue(
        date: DateTime.utc(
          initialDateCuote.value.year,
          initialDateCuote.value.month + i,
          initialDateCuote.value.day,
        ),
        cuotaGuaranies: _remove.removeToString(textGuaraniesCuotas?.text),
        cuotaDolares: _remove.removeToString(textDolaresCuotas?.text),
      ),
    );
    datesVencController.changeListCuotas(listDateGeneratedCuotas);
  }

  void generatedDatesRefuerzos() {
    String months = typeCobroMensualSelected.value.substring(0, 2);
    int monthInteger = int.parse(months);
    List<DateValue> listGeneratedAux = List<DateValue>.generate(
        int.parse(quantRefuerzosController.text) * monthInteger,
        (i) => DateValue(
              date: DateTime.utc(
                initialDateRefuerzo.value.year,
                initialDateRefuerzo.value.month + i,
                initialDateRefuerzo.value.day,
              ),
              refuerzoDolares:
                  _remove.removeToString(textDolaresRefuerzos?.text),
              refuerzoGuaranies:
                  _remove.removeToString(textGuaraniesRefuerzos?.text),
            ));
    listDateGeneratedRefuerzos.clear();
    for (int i = 0; i < listGeneratedAux.length; i++) {
      if (i != 0) {
        if ((i % monthInteger) == 0) {
          listDateGeneratedRefuerzos.add(listGeneratedAux[i]);
        }
      } else {
        listDateGeneratedRefuerzos.add(listGeneratedAux[i]);
      }
    }
    datesVencController.changeListRefuerzos(listDateGeneratedRefuerzos);
  }
}
