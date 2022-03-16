import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class SimplePieChart extends StatelessWidget {
  final List<charts.Series<LinearSales, int>> seriesList;
  final bool? animate;

  const SimplePieChart(this.seriesList, {Key? key, this.animate});

  @override
  Widget build(BuildContext context) {
    return charts.PieChart<int>(
        seriesList,
        animate: animate,
    );
  }
}

class LinearSales {
  final int year;
  final int sales;
  final charts.Color color;

  LinearSales(this.year, this.sales,this.color);
}
