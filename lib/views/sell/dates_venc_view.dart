import 'package:flutter/material.dart';

class DatesVencView extends StatelessWidget {
  final datesGenerates = List<DateTime>.generate(
    60,
    (i) => DateTime.utc(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    ).add(
      Duration(days: i),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: datesGenerates.length,
        itemBuilder: (BuildContext context, int index) =>
            Text(datesGenerates[index].toString()),
      ),
    );
  }
}
