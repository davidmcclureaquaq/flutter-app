import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:http/http.dart' as http;


Future<List<Result>> fetchResults(http.Client client) async {
  //final response = await client.get('https://api.myjson.com/bins/j5xau');
  final response = await client.get('https://api.myjson.com/bins/uxi8a');
  print(response);
  // Use the compute function to run parseResults in a separate isolate
  return compute(parseResults, response.body);
}

// A function that will convert a response body into a List<Result>
List<Result> parseResults(String responseBody) {
  print(responseBody);
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Result>((json) => Result.fromJson(json)).toList();
}

class Result {
  final String hierarchy;
  final double position;
  final double bnlmdt;
  final double bnltyd;
  final double mmv;
  final double epd;

  Result({this.hierarchy, this.position, this.bnlmdt, this.bnltyd, this.mmv, this.epd});

  bool selected = false;

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      hierarchy: json['Hierarchy'] as String,
      position: json['Position'] as double,
      bnlmdt: json['BNL_MDT'] as double,
      bnltyd: json['BNL_TYD'] as double,
      mmv: json['MMV'] as double,
      epd: json['EPD'] as double,
    );
  }
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

  int _selectedCount = 0;

  @override
  DataRow getRow(int index) {
    assert(index >= 0);
    if (index >= _results.length) return null;
    final Result result = _results[index];
    return DataRow.byIndex(
        index: index,
//        selected: result.selected,
//        onSelectChanged: (bool value) {
//          if (result.selected != value) {
//            _selectedCount += value ? 1 : -1;
//            assert(_selectedCount >= 0);
//            result.selected = value;
//            notifyListeners();
//          }
//        },
        cells: <DataCell>[
          DataCell(Text('${result.hierarchy}')),
          DataCell(Text('${result.position}',
              style: TextStyle(
                  color: setColor(result.position),
                  fontSize: 14))),
          DataCell(Text('${result.bnlmdt}',
              style: TextStyle(
                  color: setColor(result.bnlmdt),
                  fontSize: 14))),
          DataCell(Text('${result.bnltyd}',
              style: TextStyle(
                  color: setColor(result.bnltyd),
                  fontSize: 14))),
          DataCell(Text('${result.mmv}',
              style: TextStyle(
                  color: setColor(result.mmv),
                  fontSize: 14))),
          DataCell(Text('${result.epd}',
              style: TextStyle(
                  color: setColor(result.epd),
                  fontSize: 14))),
        ]);
  }

  @override
  int get rowCount => _results.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;

  void _selectAll(bool checked) {
    for (Result result in _results) result.selected = checked;
    _selectedCount = checked ? _results.length : 0;
    notifyListeners();
  }
}

class WebSocket extends StatefulWidget {
  ResultsDataSource _resultsDataSource = ResultsDataSource([]);
  bool isLoaded = false;
  @override
  _WebSocketState createState() => _WebSocketState();
}

class _WebSocketState extends State<WebSocket> {
  TextEditingController editingController = new TextEditingController();
  //Connecting laptop to mobile hotspot in order for mobile to access laptop localhost
  //IP below taken from running ipconfig in cmd
  IOWebSocketChannel channel5 =
      new IOWebSocketChannel.connect('ws://192.168.43.152:9898');
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

  Future<void> getData() async {
    final results = await fetchResults(http.Client());
    if (!isLoaded) {
      setState(() {
        _resultsDataSource = ResultsDataSource(results);
        isLoaded = true;
      });
    }
  }


  @override
  initState() {
    super.initState();
    print("Creating a StreamController...");
    //First subscription
    streamController.stream.listen((data) {
      print("DataReceived1: " + data);
    }, onDone: () {
      print("Task Done1");
    }, onError: (error) {
      print("Some Error1");
    });
    //Second subscription
    streamController.stream.listen((data) {
      print("DataReceived2: " + data);
    }, onDone: () {
      print("Task Done2");
    }, onError: (error) {
      print("Some Error2");
    });

    channel5.stream.asBroadcastStream().listen((data) {
      print("Channel Data Received: " + data);
    }, onDone: () {
      print("channel Done1");
    }, onError: (error) {
      print("Some Error1");
    });

    streamController.add("This a test data");
    print("code controller is here");
  }

  @override
  Widget build(BuildContext context) {
    getData();
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
                  label: const Text('Hierarchy',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  onSort: (int columnIndex, bool ascending) => _sort<String>(
                          (Result d) => d.hierarchy, columnIndex, ascending)),
              DataColumn(
                  label: const Text('Position',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  numeric: true,
                  onSort: (int columnIndex, bool ascending) => _sort<num>(
                          (Result d) => d.position, columnIndex, ascending)),
              DataColumn(
                  label: const Text('BNL_MDT',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  numeric: true,
                  onSort: (int columnIndex, bool ascending) => _sort<num>(
                          (Result d) => d.bnlmdt, columnIndex, ascending)),
              DataColumn(
                  label: const Text('BNL_TYD',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  numeric: true,
                  onSort: (int columnIndex, bool ascending) => _sort<num>(
                          (Result d) => d.bnltyd, columnIndex, ascending)),
              DataColumn(
                  label: const Text('MMV',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  numeric: true,
                  onSort: (int columnIndex, bool ascending) => _sort<num>(
                          (Result d) => d.mmv, columnIndex, ascending)),
              DataColumn(
                  label: const Text('EPD',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  numeric: true,
                  onSort: (int columnIndex, bool ascending) => _sort<num>(
                          (Result d) => d.mmv, columnIndex, ascending)),
            ],
            source: _resultsDataSource)
      ]));

//      floatingActionButton: new FloatingActionButton(
//        child: new Icon(Icons.send),
//        onPressed: _sendMyMessage,
//      ),
//    )
  }
//

  void _sendMyMessage() {
    if (editingController.text.isNotEmpty) {
      streamController.add(editingController.text);
      channel5.sink.add(editingController.text);
    }
  }
}
MaterialColor setColor(double num) {
  if (num == 0) {
    return Colors.amber;
  } else if (num < 0) {
    return Colors.red;
  } else {
    return Colors.green;
  }
}