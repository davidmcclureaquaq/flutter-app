import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:web_socket_channel/io.dart';
import 'package:example/classes/Result.dart';

class WebSocket extends StatefulWidget {
  ResultsDataSource _resultsDataSource = ResultsDataSource([]);
  bool isLoaded = false;
  @override
  _WebSocketState createState() => _WebSocketState();
}

class _WebSocketState extends State<WebSocket> {
  TextEditingController editingController = new TextEditingController();
  IOWebSocketChannel channel5 = new IOWebSocketChannel.connect('ws://192.168.1.142:9898');
  StreamController<String> streamController =
      new StreamController.broadcast(); //Add .broadcast here
  ResultsDataSource _resultsDataSource = ResultsDataSource([]);
  bool isLoaded = false;
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  int _sortColumnIndex;
  bool _sortAscending = true;

  void _sort<T>(
      Comparable<T> getField(Result d), int columnIndex, bool ascending) {
    _resultsDataSource._sort<T>(getField, ascending);
    setState(() {
      _sortColumnIndex = columnIndex;
      _sortAscending = ascending;
    });
  }

  Future<void> setData(String data) async {
    final results = data;
//    if (!isLoaded) {
      setState(() {
        List<Result> existingData = _resultsDataSource.getData();
        existingData.addAll(ResultsDataSource(parseResults(results)).getData());
        _resultsDataSource = ResultsDataSource(existingData);
        isLoaded = true;
      });
//    }
  }


  @override
  initState() {
    super.initState();
    channel5.stream.asBroadcastStream().listen((data) {
      print("Channel Data Received:");
      print(data);
      setData(data);
    }, onDone: () {
      print("channel 5 Done");
    }, onError: (error) {
      print("Channel 5 Error: "+error);
    });
    print("code controller is here");
  }

  @override
  Widget build(BuildContext context) {
   // getData();

    return new Scaffold(
      body: ListView(padding: const EdgeInsets.all(00.0), children: <Widget>[
        PaginatedDataTable(
            header: const Text('Census Data'),
            rowsPerPage: _rowsPerPage,
            onRowsPerPageChanged: (int value) {
              setState(() {
                _rowsPerPage = value;
              });
            },
            columnSpacing: 10,
            sortColumnIndex: _sortColumnIndex,
            sortAscending: _sortAscending,
            //onSelectAll: _resultsDataSource._selectAll,
            columns: <DataColumn>[
              DataColumn(
                  label: const Text('Time',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  onSort: (int columnIndex, bool ascending) => _sort<String>(
                          (Result d) => d.time, columnIndex, ascending)),
              DataColumn(
                  label: const Text('SYM',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  numeric: true,
                  onSort: (int columnIndex, bool ascending) => _sort<String>(
                          (Result d) => d.sym, columnIndex, ascending)),
              DataColumn(
                  label: const Text('Price',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  numeric: true,
                  onSort: (int columnIndex, bool ascending) => _sort<num>(
                          (Result d) => d.price, columnIndex, ascending)),
              DataColumn(
                  label: const Text('Size',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  numeric: true,
                  onSort: (int columnIndex, bool ascending) => _sort<num>(
                          (Result d) => d.size, columnIndex, ascending)),
              DataColumn(
                  label: const Text('Exchange',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  numeric: true,
                  onSort: (int columnIndex, bool ascending) => _sort<String>(
                          (Result d) => d.exchange, columnIndex, ascending)),
            ],
            source: _resultsDataSource)
      ]));
  }

}


Future<List<Result>> fetchResults(http.Client client) async {
  //final response = await client.get('https://api.myjson.com/bins/j5xau');
  final response = await client.get('https://api.myjson.com/bins/uxi8a');
  // Use the compute function to run parseResults in a separate isolate
  return compute(parseResults, response.body);
}

// A function that will convert a response body into a List<Result>
List<Result> parseResults(String responseBody) {
  //print(responseBody);
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

  return parsed[0]["tradetable"].map<Result>((json) => Result.fromJson(json)).toList();
}

class ResultsDataSource extends DataTableSource {
  final List<Result> _results;
  ResultsDataSource(this._results);
  void _sort<T>(Comparable<T> getField(Result d), bool ascending) {
    _results.sort((Result a, Result b) {
      if (!ascending) {
        final Result c = a;
        a = b;
        b = c;
      }
      final Comparable<T> aValue = getField(a);
      final Comparable<T> bValue = getField(b);
      return Comparable.compare(aValue, bValue);
    });
    notifyListeners();
  }

  List<Result> getData(){
    return _results;
  }

  int _selectedCount = 0;

  @override
  DataRow getRow(int index) {
    assert(index >= 0);
    if (index >= _results.length) return null;
    final Result result = _results[index];
    return DataRow.byIndex(
        index: index,
        cells: <DataCell>[
          DataCell(Text('${result.time}')),
          DataCell(Text('${result.sym}',
              style: TextStyle(fontSize: 14))),
          DataCell(Text('${result.price}',
              style: TextStyle(
                  color: setColor(result.price),
                  fontSize: 14))),
          DataCell(Text('${result.size}',
              style: TextStyle(
                //color: setColor(result.size),
                  fontSize: 14))),
          DataCell(Text('${result.exchange}',
              style: TextStyle(
                //color: setColor(result.exchange),
                  fontSize: 14))),
        ]);
  }

  @override
  int get rowCount => _results.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;

  MaterialColor setColor(double num) {
    if (num == 0) {
      return Colors.amber;
    } else if (num < 0) {
      return Colors.red;
    } else {
      return Colors.green;
    }
}
}