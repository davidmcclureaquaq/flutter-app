import 'package:charts_flutter/flutter.dart' as charts;
import 'package:example/models/trade.dart';
import 'package:flutter/material.dart';

class LineChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;
  LineChart(this.seriesList, {this.animate});

  /// Creates a [TimeSeriesChart] with sample data and no transition.
  factory LineChart.withSampleData() {
    return new LineChart(
      _createSampleData(),
      animate: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Bar chart'),
          backgroundColor: Colors.black54,
        ),
        body: charts.TimeSeriesChart(seriesList,
            animate: animate,
            dateTimeFactory: const charts.LocalDateTimeFactory()));

//    return new charts.TimeSeriesChart(
//      seriesList,
//      animate: animate,
//      dateTimeFactory: const charts.LocalDateTimeFactory(),
//    );
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<Trade, DateTime>> _createSampleData() {
    final data = [
      new Trade('AMD', 5.5, 5.6, Colors.red, new DateTime(2017, 9, 19)),
      new Trade('AMD', 7.6, 7.7, Colors.red, new DateTime(2017, 9, 20)),
      new Trade('AMD', 8.7, 8.8, Colors.red, new DateTime(2017, 9, 21)),
      new Trade('AMD', 10.8, 10.9, Colors.red, new DateTime(2017, 9, 22)),
      new Trade('AMD', 10.9, 11.95, Colors.red, new DateTime(2017, 9, 23)),
    ];

    return [
      new charts.Series<Trade, DateTime>(
        id: 'Trades',
        colorFn: (Trade t, _) => charts.ColorUtil.fromDartColor(t.color),
        domainFn: (Trade t, _) => t.dateTime,
        measureFn: (Trade t, _) => t.ask,
        data: data,
      )
    ];
  }
}
