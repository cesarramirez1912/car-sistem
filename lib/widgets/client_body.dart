import 'package:car_system/widgets/title.dart';
import 'package:flutter/cupertino.dart';

import '../app/data/models/register_client_model.dart';

Widget ClientBody(ClientModel _client) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      custTitle('Nombre'),
      suBtitle(_client.cliente),
      custTitle('CI'),
      suBtitle(_client.ci),
      custTitle('Celular'),
      suBtitle(_client.celular),
      custTitle('Ciudad'),
      suBtitle(_client.ciudad),
      custTitle('Direccion'),
      suBtitle(_client.direccion),
    ],
  );
}

Widget custTitle(text) {
  return CustomTitle(text, fontWeight: FontWeight.bold, fontSize: 15);
}

Widget suBtitle(text) {
  return CustomTitle(text, fontWeight: FontWeight.normal, fontSize: 15);
}
