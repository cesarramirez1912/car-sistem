import 'package:flutter/material.dart';

class VehicleView extends StatefulWidget {
  const VehicleView({Key? key}) : super(key: key);

  @override
  _VehicleViewState createState() => _VehicleViewState();
}

class _VehicleViewState extends State<VehicleView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Catastro Vehiculo'),
      ),
      body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                inputField('', 'Marca', Icons.perm_identity),
                inputField('', 'Model', Icons.wysiwyg),
                inputField('', 'Ano', Icons.location_city_outlined),
                inputField('', 'Color', Icons.location_city_outlined),
                inputField('', 'Motor', Icons.location_city_outlined),
                inputField('', 'Numero Chassis', Icons.wysiwyg),
                inputField('', 'Numero chapa', Icons.phone_android),
                inputField('', 'Costo Guarani', Icons.work_outline),
                inputField('', 'Costo Dolar', Icons.work_outline),
                SizedBox(
                  height: 20,
                ),
                inputCuote('','Precio contado'),
                inputCuote('','Precio finaciado'),
                inputCuote('','Maximas cuotas'),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    ElevatedButton(
                      child: const Text('Guardar'),
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          primary: Colors.green,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          textStyle: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold)),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                      child: const Text('Cancelar'),
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          primary: Colors.red,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          textStyle: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold)),
                    ),
                  ],
                )
              ],
            ),
          )),
    );
  }
}

Widget inputField(String? hintText, String? labelText, IconData iconData) {
  return TextFormField(
    autovalidateMode: AutovalidateMode.always,
    decoration: InputDecoration(
      icon: Icon(iconData),
      hintText: hintText,
      labelText: labelText,
    ),
  );
}

Widget inputCuote(String labelText,String labelText2) {
  return Row(
    children: [
      SizedBox(
        width: labelText!=''?40:30,
      ),
  labelText !='' ?     Flexible(
  flex: 1,
  child: TextFormField(
  autovalidateMode: AutovalidateMode.always,
  decoration: InputDecoration(
  labelText: labelText,
  ),
  ),
  ):Container(),
      SizedBox(width: 10,),
      Flexible(
        flex: 3,
        child: TextFormField(
          autovalidateMode: AutovalidateMode.always,
          decoration: InputDecoration(
            labelText: labelText2,
          ),
        ),
      )
    ],
  );
}
