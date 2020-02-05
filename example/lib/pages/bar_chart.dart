import 'package:charts_flutter/flutter.dart' as charts;
import 'package:example/models/trade.dart';
import 'package:flutter/material.dart';

class BarChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  BarChart(this.seriesList, {this.animate});

  /// Creates a [BarChart] with sample data and no transition.
  factory BarChart.withSampleData() {
    return new BarChart(
      _createSampleData(),
      // Disable animations for image tests.
      animate: false,
    );
  }

  factory BarChart.withSampleData2() {
    return new BarChart(
      _createSampleData(),
      // Disable animations for image tests.
      animate: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new charts.BarChart(
      seriesList,
      animate: animate,
    );
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<Trade, String>> _createSampleData() {
    final data = [
      new Trade('time', 'AMD', 10.5, 11.5),
      new Trade('time', 'GOOG', 335.2, 336.5),
      new Trade('time', 'OIL', 22, 24),
    ];

    return [
      new charts.Series<Trade, String>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (Trade t, _) => t.sym,
        measureFn: (Trade t, _) => t.ask,
        data: data,
      )
    ];
  }

}
