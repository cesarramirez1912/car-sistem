import 'package:car_system/controllers/essencial_vehicle_controller.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class buildFood extends StatelessWidget {
  EssencialVehicleController controller;
  String? selectedFood;

  buildFood({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TypeAheadFormField<String?>(
      textFieldConfiguration: TextFieldConfiguration(
        controller: controller.textModelController,
        decoration: const InputDecoration(
          labelText: 'Food',
          border: OutlineInputBorder(),
        ),
      ),
      suggestionsCallback: FoodData.getSuggestions,
      itemBuilder: (context, String? suggestion) => ListTile(
        title: Text(suggestion!),
      ),
      onSuggestionSelected: (String? suggestion) =>
          controller.textModelController.text = suggestion!,
      validator: (value) =>
          value != null && value.isEmpty ? 'Please select a food' : null,
      onSaved: (value) => selectedFood = value,
    );
  }
}

class FoodData {
  static final faker = Faker();

  static final List<String> foods =
      List.generate(20, (index) => faker.food.dish());

  static List<String> getSuggestions(String query) =>
      List.of(foods).where((food) {
        final foodLower = food.toLowerCase();
        final queryLower = query.toLowerCase();

        return foodLower.contains(queryLower);
      }).toList();
}
