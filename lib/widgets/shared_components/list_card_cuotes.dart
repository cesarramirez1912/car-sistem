import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../route_manager.dart';
import '../card_deudor.dart';

Widget listCardCuotes(List<Map<String, dynamic>> list, bool isCuote,
    {bool withDate = true, bool isDeudor = true, bool withDaysOrMonth = true}) {
  return ListView.builder(
    itemCount: list.length,
    itemBuilder: (context, index) {
      return cardDeudor(list[index], isCuote, () {
        Get.toNamed(
            isDeudor
                ? RouterManager.DEUDOR_DETAIL_VIEW
                : RouterManager.CUOTE_MONTH_DETAIL_VIEW,
            parameters: {
              'idCliente': list[index]['idCliente'].toString(),
              'isCuota': isCuote.toString()
            });
      }, withDate: withDate, withDaysOrMonth: withDaysOrMonth);
    },
  );
}
