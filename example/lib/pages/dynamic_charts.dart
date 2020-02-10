import 'dart:convert';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

final String API_ONE = "http://dummy.restapiexample.com/api/v1/employees";
final String API_TWO = "https://api.myjson.com/bins/16e68w";

class DynamicCharts extends StatefulWidget {
  @override
  _DynamicChartsState createState() => _DynamicChartsState();
}

class _DynamicChartsState extends State<DynamicCharts> {
  String _apiEndPoint = API_ONE;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dynamic charts'),
        backgroundColor: Colors.black54,
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.arrow_downward),
          onPressed: () {
            changeApi();
          }),
      body: FutureBuilder(
          future: _getData(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done)
              return new charts.PieChart(
                  createChartSeriesFromApiData(snapshot.data, _apiEndPoint),
                  defaultRenderer: new charts.ArcRendererConfig(
                      arcRendererDecorators: [new charts.ArcLabelDecorator()]));
            else
              return Center(child: CircularProgressIndicator());
          }),
    );
  }

  void changeApi() {
    setState(
          () {
        if (_apiEndPoint.contains("employee")) {
          _apiEndPoint = API_TWO;
        } else if (_apiEndPoint.contains("myjson"))
          _apiEndPoint = API_ONE;
      },
    );
  }

  _getData() async {
    final response = await http.get(_apiEndPoint);
    Map<String, dynamic> map = json.decode(response.body);
    return map;
  }

  static List<charts.Series<LinearSales, int>> createChartSeriesFromApiData(
      Map<String, dynamic> apiData, String apiEndPoint) {
    List<LinearSales> list = new List();

    for (int i = 0; i < apiData['data'].length; i++)
      if (apiEndPoint.contains("employee")) {
        list.add(
            new LinearSales(i, int.parse(apiData['data'][i]['employee_age'])));
      } else {
        list.add(new LinearSales(i, apiData['data'][i]));
      }

    return [
      new charts.Series<LinearSales, int>(
        id: 'Sales',
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: list,
        labelAccessorFn: (LinearSales row, _) => '${row.year}: ${row.sales}',
      )
    ];
  }
}

class LinearSales {
  final int year;
  final int sales;
  LinearSales(this.year, this.sales);
}
