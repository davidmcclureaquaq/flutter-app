import 'package:example/pages/paginated_data_table2.dart';
import 'package:flutter/material.dart';
import 'package:sticky_headers/sticky_headers.dart';

class GridData {
  GridData(this.hierarchy, this.position, this.bnlmdt, this.bnltyd, this.mmv, this.epd);
  final String hierarchy;
  final double position;
  final double bnlmdt;
  final double bnltyd;
  final double mmv;
  final double epd;


  bool selected = false;
}

class GridDataSource extends DataTableSource {
  final List<GridData> _gridData = <GridData>[
    GridData('JGLOBAL',                        -55043.09,  45942.17,  -28154.79,  -23392.86,  87),
    GridData('Ice cream sandwich',                   237,  9.0,  543437,  4.3, 129),
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
    GridData('Coconut slice and eclaire',             421, 31.0,  31,  7.5, 346),
    GridData('Coconut slice and cupcake',            464, 18.7,  74,  5.8, 422),
    GridData('Coconut slice and gingerbread',        515, 31.0,  56,  5.4, 316),
    GridData('Coconut slice and jelly bean',         534, 15.0, 101,  1.5,  59),
    GridData('Coconut slice and lollipop',           551, 15.2, 105,  1.5,  47),
    GridData('Coconut slice and honeycomb',          567, 18.2,  94,  8.0, 571),
    GridData('Coconut slice and donut',              611, 40.0,  58,  6.4, 335),
    GridData('Coconut slice and KitKat',             677, 41.0,  72,  8.5,  63),
  ];

  Set<String> headerList = {"Hierarchy", "Position", "BNLMDT", "BNLTYD", "MMV", "EPD"};
  Set<String> filterHeaderList = {"Hierarchy", "Position", "BNLMDT", "BNLTYD", "MMV", "EPD"};

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
    final GridData gridData = _gridData[index];
    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(Text('${gridData.hierarchy}')),
        DataCell(Text('${gridData.position}',
            style: TextStyle(
                color: setColor(gridData.position),
                fontSize: 14))),
        DataCell(Text('${gridData.bnlmdt}',
            style: TextStyle(
                color: setColor(gridData.bnlmdt),
                fontSize: 14))),
        DataCell(Text('${gridData.bnltyd}',
            style: TextStyle(
                color: setColor(gridData.bnltyd),
                fontSize: 14))),
        DataCell(Text('${gridData.mmv}',
            style: TextStyle(
                color: setColor(gridData.mmv),
                fontSize: 14))),
        DataCell(Text('${gridData.epd}',
            style: TextStyle(
                color: setColor(gridData.epd),
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

}

class PaginatedGridSticky extends StatefulWidget {
  @override
  _PaginatedGridSticky createState() => _PaginatedGridSticky();
}

bool isSorted = false;

class _PaginatedGridSticky extends State<PaginatedGridSticky> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  int _sortColumnIndex;
  bool _sortAscending = true;
  final GridDataSource _gridDataSource = GridDataSource();

  void _sort<T>(Comparable<T> getField(GridData d), int columnIndex, bool ascending) {
    _gridDataSource._sort<T>(getField, ascending);
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
          shrinkWrap: true,
          padding: const EdgeInsets.all(0.0),
          children: <Widget>[

            Container(
              child: ExpansionTile(
                leading: Icon(Icons.filter_list),
                title: Text(
                  "ADD FILTERS (${_gridDataSource.headerList.length})",
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                children: <Widget>[
                  Wrap(
                    runSpacing: -12,
                    direction: Axis.horizontal,
                    children: <Widget>[
                      for(String header in _gridDataSource.headerList)
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                  Checkbox(
                                  value: this._gridDataSource.filterHeaderList.contains(header),
                                  onChanged: null,
                                ),
                                Text(header),
                                SizedBox(
                                  width: 4.0,
                                ),
                              ],
                            ),
                            onTap: () {
                              setState(() {
                                if (this._gridDataSource.filterHeaderList.contains(header))
                                  this._gridDataSource.filterHeaderList.remove(header);
                                else
                                  this._gridDataSource.filterHeaderList.add(header);
                              });
                            },
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),

            StickyHeader(
            header: Container(
            height: 50.0,
            color: Colors.blueGrey[700],
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            alignment: Alignment.centerLeft,
            child: Text('Header ',
                    style: const TextStyle(color: Colors.white),
                    ),
            ),
            content:
            PaginatedDataTable2(
              rowsPerPage: _rowsPerPage,
              columnSpacing: 10,
              onRowsPerPageChanged: (int value) { setState(() { _rowsPerPage = value; }); },
              sortColumnIndex: _sortColumnIndex,
              sortAscending: _sortAscending,
//              onSelectAll: _gridDataSource._selectAll,
              columns: <DataColumn>[
                for(String header in _gridDataSource.filterHeaderList)
                  DataColumn(label: Text(header,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    onSort: (int columnIndex, bool ascending) => _sort<String>((GridData d) => d.hierarchy, columnIndex, ascending),
                  ),
              ],
              source: _gridDataSource,
            ),
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