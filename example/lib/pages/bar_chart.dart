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
      animate: true,
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
      new Trade('time', 'AMD', 10.5, 11.5, Colors.red),
      new Trade('time', 'GOOG', 335.2, 336.5, Colors.blue),
      new Trade('time', 'OIL', 22, 24, Colors.yellow),
      new Trade('time', 'LLOY', 57, 58, Colors.green),
    ];

    return [
      new charts.Series<Trade, String>(
        id: 'Trades',
        labelAccessorFn: (Trade t, _) => '${t.sym}',
        colorFn: (Trade t, _) => charts.ColorUtil.fromDartColor(t.color),
        domainFn: (Trade t, _) => t.sym,
        measureFn: (Trade t, _) => t.ask,
        data: data,
      )
    ];
  }

}
