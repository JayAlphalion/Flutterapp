import 'package:alpha_app/utils/AppColors.dart';
import 'package:flutter/material.dart';

import 'decorated_table_page.dart';

class LandingPage extends StatefulWidget {
  final columns = 10;
  final rows = 15;

  const LandingPage({Key? key}) : super(key: key);

  List<List<String>> makeData() {
    final List<List<String>> output = [];
    for (int i = 0; i < columns; i++) {
      final List<String> row = [];
      for (int j = 0; j < rows; j++) {
        row.add('L$j : T$i rfrfrgrgefefef');
      }
      output.add(row);
    }
    return output;
  }

  /// Simple generator for column title
  List<String> makeTitleColumn() =>
      List.generate(columns, (i) => ' PARAM ${i + 1}  ');

  /// Simple generator for row title
  List<String> makeTitleRow() => List.generate(rows, (i) => 'Date ${i + 1}');

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  int _selectedIndex = 0;

  Widget _widgetOptions(int index) {
    return DecoratedTablePage(
      titleColumn: widget.makeTitleColumn(),
      titleRow: widget.makeTitleRow(),
      data: widget.makeData(),
    );
    // switch (index) {
    //   case 0:
    //     return SimpleTablePage(
    //       titleColumn: widget.makeTitleColumn(),
    //       titleRow: widget.makeTitleRow(),
    //       data: widget.makeData(),
    //     );
    //   case 1:
    //     return TapHandlerPage(
    //       titleColumn: widget.makeTitleColumn(),
    //       titleRow: widget.makeTitleRow(),
    //       data: widget.makeData(),
    //     );
    //   case 2:
    //     return DecoratedTablePage(
    //       titleColumn: widget.makeTitleColumn(),
    //       titleRow: widget.makeTitleRow(),
    //       data: widget.makeData(),
    //     );
    //   case 3:
    //     return OffsetToCellPage(
    //       titleColumn: widget.makeTitleColumn(),
    //       titleRow: widget.makeTitleRow(),
    //       data: widget.makeData(),
    //     );
    //   case 4:
    //     return ColumnWidthInPercentPage();
    //   case 5:
    //     return InfiniteScrollPage();
    //   default:
    //     print('$index not supported');
    //     return Container();
    // }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Container(),
            label: '< Previous',
          ),
          BottomNavigationBarItem(
            icon: Container(),
            label: 'Next >',
          ),
          // BottomNavigationBarItem(
          //   icon: Container(),
          //   label: 'Decorated',
          // ),
          // BottomNavigationBarItem(
          //   icon: Container(),
          //   label: 'Offset',
          // ),
          // BottomNavigationBarItem(
          //   icon: Container(),
          //   label: 'Column %',
          // ),
          // BottomNavigationBarItem(
          //   icon: Container(),
          //   label: 'Web',
          // ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: AppColors.primaryColor,
        onTap: _onItemTapped,
      ),
    );
  }
}
