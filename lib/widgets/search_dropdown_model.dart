import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

Widget CustomDropDowModelSearch(
    {dynamic Model,
    String? text,
    Function? onSaved,
    List<dynamic>? items,
    Function? itemAsString,
    Function? onChanged,
    Function? validator,
    String? label = '',
    String? itemSelected,
    Function? compareFn}) {
  Widget _customDropDownExampleMultiSelection(context, itemDynamic) {
    if (itemSelected == null) {
      return const ListTile(
        contentPadding: EdgeInsets.all(0),
        title: Text("Ningun cliente seleccionado"),
      );
    }

    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      title: Text('sssss'),
      subtitle: Text(
        text!,
      ),
    );
  }

  Widget _customPopupItemBuilderExample2(context, itemDynamic, isSelected) {
    return ListTile(
      selected: isSelected,
      title: Text('2222'),
      subtitle: Text(text!),
    );
  }

  return DropdownSearch<dynamic>(
      showSearchBox: true,
      compareFn: (item, selectedItem) =>
          compareFn != null ? compareFn(item, selectedItem) : null,
      onChanged: (value) => onChanged!(value),
      showSelectedItems: true,
      validator: (u) => validator!(u),
      itemAsString: (dynamic? item) => itemAsString!(item),
      dropdownBuilder: (context, valueDynamic) =>
          _customDropDownExampleMultiSelection(context, valueDynamic),
      showAsSuffixIcons: true,
      dropdownSearchDecoration: const InputDecoration(
        prefixIcon: Icon(Icons.person_outline),
        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        border: OutlineInputBorder(),
      ),
      searchFieldProps: TextFieldProps(
        keyboardType: TextInputType.text,
        decoration: const InputDecoration(filled: true, label: Text('')),
      ),
      popupItemBuilder: (context, valueDynamic, isSelected) =>
          _customPopupItemBuilderExample2(context, valueDynamic, isSelected),
      onSaved: (value) => onSaved!(value),
      mode: Mode.DIALOG,
      items: items!);
}
