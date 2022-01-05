import 'package:car_system/controllers/essencial_vehicle_controller.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class buildCity extends StatelessWidget {
  EssencialVehicleController controller;
  String? selectedCity;

  buildCity({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TypeAheadFormField<String?>(
      textFieldConfiguration: TextFieldConfiguration(
        controller: controller.textBrandController,
        decoration: const InputDecoration(
          labelText: 'City',
          border: OutlineInputBorder(),
        ),
      ),
      suggestionsCallback: CityData.getSuggestions,
      itemBuilder: (context, String? suggestion) => ListTile(
        title: Text(suggestion!),
      ),
      onSuggestionSelected: (String? suggestion) =>
          controller.textBrandController.text = suggestion!,
      validator: (value) =>
          value != null && value.isEmpty ? 'Please select a city' : null,
      onSaved: (value) => selectedCity = value,
    );
  }
}

class CityData {
  static final faker = Faker();

  static final List<String> cities =
      List.generate(20, (index) => faker.address.city());

  static List<String> getSuggestions(String query) =>
      List.of(cities).where((city) {
        final cityLower = city.toLowerCase();
        final queryLower = query.toLowerCase();

        return cityLower.contains(queryLower);
      }).toList();
}
