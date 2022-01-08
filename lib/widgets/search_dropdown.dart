

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
Widget CustomDropDowSearch(List<String> list, String label,
    {IconData? iconData, Function? onSaved, bool isRequired = true}) {
  return DropdownSearch<String>(
    showSearchBox: true,
    showSelectedItems: true,
    showAsSuffixIcons: true,
    dropdownSearchDecoration: const InputDecoration(
      prefixIcon: Icon(Icons.directions_car_outlined),
      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      border: OutlineInputBorder(),
    ),
    searchFieldProps: TextFieldProps(
      decoration: const InputDecoration(filled: true, label: Text('Buscar')),
    ),
    validator: (value) =>
    isRequired ? (value == null ? 'Campo obligatorio.' : null) : null,
    onSaved: (value) => isRequired
        ? onSaved != null
        ? onSaved(value) ?? true
        : true
        : false,
    mode: Mode.DIALOG,
    items: list,
    label: label,
  );
}