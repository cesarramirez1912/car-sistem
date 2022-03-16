import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: non_constant_identifier_names
Widget CustomInput(String? hintText, String? labelText,
    {Function? onSaved,
    IconData? iconData,
    Function? validator,
    List<TextInputFormatter>? inputFormatters,
    bool isLoading = false,
    bool isNumber = false,
    bool isPhone = false,
    Function? onChanged,
    TextEditingController? textEditingController}) {
  return Column(
    children: [
      TextFormField(
        onChanged: (value) => onChanged?.call(value),
        textCapitalization: TextCapitalization.sentences,
        onSaved: (text) => onSaved?.call(text),
        inputFormatters: inputFormatters,
        controller: textEditingController,
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
            borderSide: BorderSide(color: Colors.blue, width: 2.0),
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
