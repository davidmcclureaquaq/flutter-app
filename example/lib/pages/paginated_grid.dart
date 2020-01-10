import 'package:flutter/material.dart';

class GridData {
  GridData(this.hierarchy, this.pos, this.bnlmdt, this.bnltyd, this.mmv, this.epd);
  final String hierarchy;
  final double pos;
  final double bnlmdt;
  final double bnltyd;
  final double mmv;
  final double epd;

  bool selected = false;
}

class DessertDataSource extends DataTableSource {
  final List<GridData> _gridData = <GridData>[
    GridData('JGLOBAL',                        -5504397.0999,  4541942.3117,  -8528154.7479,  -8523392.7486,  87),
    GridData('Ice cream sandwich',                   237,  9.0,  54353437,  4.3, 129),
    GridData('Eclair',                               262, 16.0,  24,  6.0, 337),
    GridData('Cupcake',                              305,  3.7,  67,  4.3, 413),
    GridData('Gingerbread',                          356, 16.0,  49,  3.9, 327),
    GridData('Jelly bean',                           375,  0.0,  94,  0.0,  50),
    GridData('Lollipop',                             392,  0.2,  98,  0.0,  38),
    GridData('Honeycomb',                            408,  3.2,  87,  6.5, 562),
    GridData('Donut',                                452, 25.0,  51,  4.9, 326),
    GridData('KitKat',                               518, 26.0,  65,  7.0,  54),

    GridData('Frozen yogurt with sugar',             168,  6.0,  26,  4.0,  87),
    GridData('Ice cream sandwich with sugar',        246,  9.0,  39,  4.3, 129),
    GridData('Eclair with sugar',                    271, 16.0,  26,  6.0, 337),
    GridData('Cupcake with sugar',                   314,  3.7,  69,  4.3, 413),
    GridData('Gingerbread with sugar',               345, 16.0,  51,  3.9, 327),
    GridData('Jelly bean with sugar',                364,  0.0,  96,  0.0,  50),
    GridData('Lollipop with sugar',                  401,  0.2, 100,  0.0,  38),
    GridData('Honeycomb with sugar',                 417,  3.2,  89,  6.5, 562),
    GridData('Donut with sugar',                     461, 25.0,  53,  4.9, 326),
    GridData('KitKat with sugar',                    527, 26.0,  67,  7.0,  54),

    GridData('Frozen yogurt with honey',             223,  6.0,  36,  4.0,  87),
    GridData('Ice cream sandwich with honey',        301,  9.0,  49,  4.3, 129),
    GridData('Eclair with honey',                    326, 16.0,  36,  6.0, 337),
    GridData('Cupcake with honey',                   369,  3.7,  79,  4.3, 413),
    GridData('Gingerbread with honey',               420, 16.0,  61,  3.9, 327),
    GridData('Jelly bean with honey',                439,  0.0, 106,  0.0,  50),
    GridData('Lollipop with honey',                  456,  0.2, 110,  0.0,  38),
    GridData('Honeycomb with honey',                 472,  3.2,  99,  6.5, 562),
    GridData('Donut with honey',                     516, 25.0,  63,  4.9, 326),
    GridData('KitKat with honey',                    582, 26.0,  77,  7.0,  54),

    GridData('Frozen yogurt with milk',              262,  8.4,  36, 12.0, 194),
    GridData('Ice cream sandwich with milk',         339, 11.4,  49, 12.3, 236),
    GridData('Eclair with milk',                     365, 18.4,  36, 14.0, 444),
    GridData('Cupcake with milk',                    408,  6.1,  79, 12.3, 520),
    GridData('Gingerbread with milk',                459, 18.4,  61, 11.9, 434),
    GridData('Jelly bean with milk',                 478,  2.4, 106,  8.0, 157),
    GridData('Lollipop with milk',                   495,  2.6, 110,  8.0, 145),
    GridData('Honeycomb with milk',                  511,  5.6,  99, 14.5, 669),
    GridData('Donut with milk',                      555, 27.4,  63, 12.9, 433),
    GridData('KitKat with milk',                     621, 28.4,  77, 15.0, 161),

    GridData('Coconut slice and frozen yogurt',      318, 21.0,  315,  5.5,  96),
    GridData('Coconut slice and ice cream sandwich', 396, 24.0,  44,  5.8, 138),
    GridData('Coconut slice and eclair',             421, 31.0,  31,  7.5, 346),
    GridData('Coconut slice and cupcake',            464, 18.7,  74,  5.8, 422),
    GridData('Coconut slice and gingerbread',        515, 31.0,  56,  5.4, 316),
    GridData('Coconut slice and jelly bean',         534, 15.0, 101,  1.5,  59),
    GridData('Coconut slice and lollipop',           551, 15.2, 105,  1.5,  47),
    GridData('Coconut slice and honeycomb',          567, 18.2,  94,  8.0, 571),
    GridData('Coconut slice and donut',              611, 40.0,  58,  6.4, 335),
    GridData('Coconut slice and KitKat',             677, 41.0,  72,  8.5,  63),
  ];

  void _sort<T>(Comparable<T> getField(GridData d), bool ascending) {
    _gridData.sort((GridData a, GridData b) {
      if (!ascending) {
        final GridData c = a;
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
    if (index >= _gridData.length)
      return null;
    final GridData dessert = _gridData[index];
    return DataRow.byIndex(
      index: index,
      selected: dessert.selected,
      onSelectChanged: (bool value) {
        if (dessert.selected != value) {
          _selectedCount += value ? 1 : -1;
          assert(_selectedCount >= 0);
          dessert.selected = value;
          notifyListeners();
        }
      },
      cells: <DataCell>[
        DataCell(Text('${dessert.hierarchy}')),
        DataCell(Text('${dessert.pos}',
            style: TextStyle(
                color: setColor(dessert.pos),
                fontSize: 14))),
        DataCell(Text('${dessert.bnlmdt}',
            style: TextStyle(
                color: setColor(dessert.bnlmdt),
                fontSize: 14))),
        DataCell(Text('${dessert.bnltyd}',
            style: TextStyle(
                color: setColor(dessert.bnltyd),
                fontSize: 14))),
        DataCell(Text('${dessert.mmv}',
            style: TextStyle(
                color: setColor(dessert.mmv),
                fontSize: 14))),
        DataCell(Text('${dessert.epd}',
            style: TextStyle(
                color: setColor(dessert.epd),
                fontSize: 14)))
      ],
    );
  }

  @override
  int get rowCount => _gridData.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;

  void _selectAll(bool checked) {
    for (GridData dessert in _gridData)
      dessert.selected = checked;
    _selectedCount = checked ? _gridData.length : 0;
    notifyListeners();
  }
}

class PaginatedGrid extends StatefulWidget {
  @override
  _PaginatedGrid createState() => _PaginatedGrid();
}

bool isSorted = false;

class _PaginatedGrid extends State<PaginatedGrid> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  int _sortColumnIndex;
  bool _sortAscending = true;
  final DessertDataSource _dessertsDataSource = DessertDataSource();

  void _sort<T>(Comparable<T> getField(GridData d), int columnIndex, bool ascending) {
    _dessertsDataSource._sort<T>(getField, ascending);
    setState(() {
      _sortColumnIndex = columnIndex;
      _sortAscending = ascending;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scrollbar(
        child: ListView(
          padding: const EdgeInsets.all(20.0),
          children: <Widget>[
            PaginatedDataTable(
              header: const Text('Nutrition'),
              rowsPerPage: _rowsPerPage,
              onRowsPerPageChanged: (int value) { setState(() { _rowsPerPage = value; }); },
              sortColumnIndex: _sortColumnIndex,
              sortAscending: _sortAscending,
              onSelectAll: _dessertsDataSource._selectAll,
              columns: <DataColumn>[
                DataColumn(
                  label: const Text('Hierarchy',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  onSort: (int columnIndex, bool ascending) => _sort<String>((GridData d) => d.hierarchy, columnIndex, ascending),
                ),
                DataColumn(
                  label: const Text('Position',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  numeric: true,
                  onSort: (int columnIndex, bool ascending) => _sort<num>((GridData d) => d.pos, columnIndex, ascending),
                ),
                DataColumn(
                  label: const Text('BNLMDT',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  numeric: true,
                  onSort: (int columnIndex, bool ascending) => _sort<num>((GridData d) => d.bnlmdt, columnIndex, ascending),
                ),
                DataColumn(
                  label: const Text('BNLTYD',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  numeric: true,
                  onSort: (int columnIndex, bool ascending) => _sort<num>((GridData d) => d.bnltyd, columnIndex, ascending),
                ),
                DataColumn(
                  label: const Text('MMV',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  numeric: true,
                  onSort: (int columnIndex, bool ascending) => _sort<num>((GridData d) => d.mmv, columnIndex, ascending),
                ),
                DataColumn(
                  label: const Text('EPD',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  numeric: true,
                  onSort: (int columnIndex, bool ascending) => _sort<num>((GridData d) => d.epd, columnIndex, ascending),
                ),

              ],
              source: _dessertsDataSource,
            ),
          ],
        ),
      ),
    );
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