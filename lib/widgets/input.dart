import 'package:flutter/material.dart';

Widget CustomInput(String? hintText, String? labelText,
    {Function? onSaved,
    IconData? iconData,
    Function? validator,
    bool isLoading = false,
    bool isNumber = false,
    bool isPhone = false}) {
  return Column(
    children: [
      TextFormField(
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
          fillColor: Colors.white,
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.blue,
              width: 2.0
            ),
          ),
          contentPadding: const EdgeInsets.all(12),
          border: const OutlineInputBorder(),
          prefixIcon: iconData != null ? Icon(iconData) : null,
          hintText: hintText,
          labelText: labelText,
        ),
      ),
      const SizedBox(height: 16),
    ],
  );
}
