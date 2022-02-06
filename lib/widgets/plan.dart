import 'package:car_system/colors.dart';
import 'package:car_system/models/cuotes.dart';
import 'package:car_system/widgets/renders_cards_plan/render_cuotas.dart';
import 'package:car_system/widgets/title.dart';
import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
Widget CustomPlan(int index, Cuota cuota,
    {String? textRender,
    bool withTitle = true,
    Function? onPressed,
    bool showTotal = false,
    bool showDolares = true,
    bool showGuaranies = true}) {
  if (cuota.cantidadCuotas == 0 || cuota.cantidadCuotas == null) {
    return Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.only(bottom: 10),
        child: const Text('Sin planes para este vehiculo.'));
  } else {
    return Stack(
      children: [
        onPressed != null
            ? Positioned(
                top: -10,
                right: -14,
                child: IconButton(
                  onPressed: () => onPressed(),
                  icon: const Icon(
                    Icons.highlight_remove_outlined,
                    color: ColorPalette.PRIMARY,
                  ),
                ),
              )
            : Container(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              withTitle
                  ? CustomTitle('Plan n° ${(index + 1).toString()}',
                      fontSize: 17)
                  : Container(),
              renderCuotas(cuota,
                  textRender: textRender,
                  showTotales: showTotal,
                  showDolares: showDolares,
                  showGuaranies: showGuaranies),
              const SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      ],
    );
  }
}

Widget planText(String left, String rigth) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          left + ':',
        ),
        Text(
          rigth,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
      ],
    ),
  );
}
