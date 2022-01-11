import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
Widget CustomDropDowSearch(List<String> list, String label,
    {IconData? iconData,
    Function? onSaved,
    Function? onChanged,
    bool isRequired = true,
    String? selectedItem}) {
  return DropdownSearch<String>(
    showSearchBox: true,
    selectedItem: selectedItem,
    onChanged: (value) => onChanged!(value),
    showSelectedItems: true,
    showAsSuffixIcons: true,
    dropdownSearchDecoration: InputDecoration(
      prefixIcon: Icon(iconData ?? Icons.directions_car_outlined),
      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      border: const OutlineInputBorder(),
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
