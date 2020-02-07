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
      _createSampleData2(),
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
        body: charts.BarChart(
          seriesList,
          animate: animate,
          domainAxis: new charts.OrdinalAxisSpec(
            viewport: new charts.OrdinalViewport('AePS', 6),
          ),

          behaviors: [
            new charts.SeriesLegend(),
            new charts.SlidingViewport(),
            new charts.PanAndZoomBehavior(),

          ],
        ));
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<Trade, String>> _createSampleData2() {
    List<Trade> data = [];
    for (int i=1; i<6; i++){
      data.add(new Trade('AMD'+i.toString(), i.toDouble(), i.toDouble()+1, Colors.red, new DateTime(2017, 9, 19)));
      data.add(new Trade('GOOG'+i.toString(), i.toDouble()+1, i.toDouble()+2, Colors.blue, new DateTime(2017, 9, 19)));
    }

    return [
      new charts.Series<Trade, String>(
        id: 'Trades',
        labelAccessorFn: (Trade t, _) => '${t.sym}',
        colorFn: (Trade t, _) => charts.ColorUtil.fromDartColor(t.color),
        domainFn: (Trade t, _) => t.sym,
        measureFn: (Trade t, _) => t.bid,
        data: data,
      )
    ];
  }

}
