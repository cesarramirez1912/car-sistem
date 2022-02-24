import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import '../../controllers/dash_controller.dart';

class BarChartWithSecondaryAxis extends StatelessWidget {
  final List<charts.Series<OrdinalSales, String>> seriesList;
  final bool? animate;

  const BarChartWithSecondaryAxis(this.seriesList, {this.animate});

  @override
  Widget build(BuildContext context) {
    return charts.BarChart(
      seriesList,
      animate: animate,
      barGroupingType: charts.BarGroupingType.grouped,
      primaryMeasureAxis: const charts.NumericAxisSpec(
        tickProviderSpec:
            charts.BasicNumericTickProviderSpec(desiredTickCount: 14),
      ),
    );
  }
}
