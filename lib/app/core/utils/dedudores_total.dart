import 'package:car_system/app/data/models/deudor_model.dart';

import 'date_format.dart';

class DeudoresTotal {
  Map<String, dynamic> tipoMoroso(String? tipo) {
    switch (tipo) {
      case 'BAJO':
        return {"bajo": 1};
      case 'MEDIO':
        return {"medio": 1};
      case 'ALTO':
        return {"alto": 1};
      default:
        return {"": 0};
    }
  }

  List<Map<String, dynamic>> counterTotal(
      List<DeudorModel> _list, bool isCuote) {
    List<Map<String, dynamic>> _newListFilter = [];

    for (var deu in _list) {
      var exist = _newListFilter
          .indexWhere((element) => element['idCliente'] == deu.idCliente);
      if (exist != -1) {
        _newListFilter[exist]['lista'].add(deu);

        _newListFilter[exist]['total_deuda_guaranies'] = ((_newListFilter[exist]
                    ['total_deuda_guaranies'] ??
                0) +
            (isCuote
                ? ((deu.cuotaGuaranies ?? 0) - (deu.pagoGuaranies ?? 0))
                : ((deu.refuerzoGuaranies ?? 0) - (deu.pagoGuaranies ?? 0))));
        _newListFilter[exist]['total_deuda_dolares'] =
            ((_newListFilter[exist]['total_deuda_dolares'] ?? 0) +
                (isCuote
                    ? ((deu.cuotaDolares ?? 0) - (deu.pagoDolares ?? 0))
                    : ((deu.refuerzoDolares ?? 0) - (deu.pagoDolares ?? 0))));

        if (deu.tipoMoroso == 'bajo') {
          if (_newListFilter[exist]['bajo'] != null) {
            _newListFilter[exist]['bajo'] = _newListFilter[exist]['bajo'] + 1;
          } else {
            _newListFilter[exist]['bajo'] = 1;
          }
        } else if (deu.tipoMoroso == 'medio') {
          if (_newListFilter[exist]['medio'] != null) {
            _newListFilter[exist]['medio'] = _newListFilter[exist]['medio'] + 1;
          } else {
            _newListFilter[exist]['medio'] = 1;
          }
        } else {
          if (_newListFilter[exist]['alto'] != null) {
            _newListFilter[exist]['alto'] = _newListFilter[exist]['alto'] + 1;
          } else {
            _newListFilter[exist]['alto'] = 1;
          }
        }
      } else {
        _newListFilter.add({
          "idCliente": deu.idCliente,
          "cliente": deu.cliente,
          "lista": [deu],
          "fecha": DateFormatBr().formatBrFromString(deu.fechaCuota ?? deu.fechaRefuerzo),
          "total_deuda_guaranies": isCuote
              ? ((deu.cuotaGuaranies ?? 0) - (deu.pagoGuaranies ?? 0))
              : ((deu.refuerzoGuaranies ?? 0) - (deu.pagoGuaranies ?? 0)),
          "total_deuda_dolares": isCuote
              ? ((deu.cuotaDolares ?? 0) - (deu.pagoDolares ?? 0))
              : ((deu.refuerzoDolares ?? 0) - (deu.pagoDolares ?? 0)),
          ...tipoMoroso(deu.tipoMoroso)
        });
      }
    }
    return _newListFilter;
  }
}
