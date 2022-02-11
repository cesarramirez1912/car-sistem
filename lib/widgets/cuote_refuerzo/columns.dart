import 'package:flutter/material.dart';

List<DataColumn> dataColumn() {
  return const <DataColumn>[
    DataColumn(
      label: Expanded(
        child: Text(
          'Cuota / Venc.',
          softWrap: true,
          maxLines: 3,
          overflow: TextOverflow.visible,
          textAlign: TextAlign.center,
        ),
      ),
    ),
    DataColumn(
      label: Expanded(
        child: Text(
          'Pago / Fecha',
          textAlign: TextAlign.center,
        ),
      ),
    ),
    DataColumn(
      label: Expanded(
          child: Text(
        'Pendiente',
        textAlign: TextAlign.center,
      )),
    ),
  ];
}
