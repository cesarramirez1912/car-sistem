import 'package:flutter/material.dart';

Widget CustomInput(String? hintText, String? labelText, IconData iconData,
    {Function? onSaved,
    Function? validator,
    bool isLoading = false,
    bool isNumber = false,
    bool isPhone = false}) {
  return TextFormField(
    textCapitalization: TextCapitalization.sentences,
    onSaved: (text) => onSaved?.call(text),
    validator: (value) => validator?.call(value),
    enabled: isLoading ? false : true,
    keyboardType: isNumber
        ? TextInputType.number
        : isPhone
            ? TextInputType.phone
            : TextInputType.text,
    autovalidateMode: AutovalidateMode.always,
    decoration: InputDecoration(
      icon: Icon(iconData),
      hintText: hintText,
      labelText: labelText,
    ),
  );
}
