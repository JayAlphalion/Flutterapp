import 'package:alpha_app/utils/AppColors.dart';
import 'package:alpha_app/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:table_sticky_headers/table_sticky_headers.dart';

class DecoratedTablePage extends StatefulWidget {
  const DecoratedTablePage({
    Key? key,
    required this.data,
    required this.titleColumn,
    required this.titleRow,
  }) : super(key: key);

  final List<List<String>> data;
  final List<String> titleColumn;
  final List<String> titleRow;

  @override
  State<DecoratedTablePage> createState() => _DecoratedTablePageState();
}

class _DecoratedTablePageState extends State<DecoratedTablePage> {
  var isHorizontalScrollbar = true;
  var isVerticalScrollbar = true;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
          leading: Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
          title: const Text('Payroll'),
          actions: const [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Icon(Icons.more_vert),
            ),
          ],
          backgroundColor: AppColors.primaryColor),
      body: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: AppColors.whiteColor,
            // borderRadius: BorderRadius.circular(15),
            border: Border.all(color: AppColors.primaryColor)),
        child: StickyHeadersTable(
          columnsLength: widget.titleColumn.length,
          rowsLength: widget.titleRow.length,
          columnsTitleBuilder: (i) => TableCell.stickyRow(
            widget.titleColumn[i],
            colorBg: AppColors.primaryColor,
            textStyle: textTheme.button!
                .copyWith(fontSize: 15.0, color: AppColors.whiteColor),
          ),
          rowsTitleBuilder: (i) => TableCell.stickyColumn(
            widget.titleRow[i],
            textStyle: textTheme.button!.copyWith(fontSize: 15.0),
          ),
          contentCellBuilder: (i, j) => TableCell.content(
            widget.data[i][j],
            textStyle: textTheme.bodyText2!.copyWith(fontSize: 12.0),
          ),
          legendCell: TableCell.legend(
            'Params ➡ \nLegend ⬇',
            textStyle: textTheme.button!
                .copyWith(fontSize: 16.5, color: AppColors.whiteColor),
          ),
          showVerticalScrollbar: isVerticalScrollbar,
          showHorizontalScrollbar: isHorizontalScrollbar,
        ),
      ),
    );
  }
}

class TableCell extends StatelessWidget {
  TableCell.content(
    this.text, {
    Key? key,
    this.textStyle,
    this.cellDimensions = const CellDimensions.fixed(
        contentCellWidth: 150,
        contentCellHeight: 50,
        stickyLegendHeight: 50,
        stickyLegendWidth: 150), //CellDimensions.base,
    this.colorBg = Colors.white,
    this.onTap,
  })  : cellWidth = cellDimensions.contentCellWidth,
        cellHeight = cellDimensions.contentCellHeight,
        _colorHorizontalBorder = AppColors.primaryColor,
        _colorVerticalBorder = AppColors.whiteColor,
        _textAlign = TextAlign.center,
        _padding = EdgeInsets.zero,
        super(key: key);

  TableCell.legend(
    this.text, {
    Key? key,
    this.textStyle,
    this.cellDimensions = const CellDimensions.fixed(
        contentCellWidth: 150,
        contentCellHeight: 50,
        stickyLegendHeight: 50,
        stickyLegendWidth: 150), //CellDimensions.base,
    this.colorBg = AppColors.primaryColor,
    this.onTap,
  })  : cellWidth = cellDimensions.stickyLegendWidth,
        cellHeight = cellDimensions.stickyLegendHeight,
        _colorHorizontalBorder = Colors.white,
        _colorVerticalBorder = AppColors.primaryColor,
        _textAlign = TextAlign.start,
        _padding = EdgeInsets.zero,
        super(key: key);

  TableCell.stickyRow(
    this.text, {
    Key? key,
    this.textStyle,
    this.cellDimensions = const CellDimensions.fixed(
        contentCellWidth: 150,
        contentCellHeight: 50,
        stickyLegendHeight: 50,
        stickyLegendWidth: 150), //CellDimensions.base,
    this.colorBg = AppColors.primaryColor,
    this.onTap,
  })  : cellWidth = cellDimensions.contentCellWidth,
        cellHeight = cellDimensions.stickyLegendHeight,
        _colorHorizontalBorder = Colors.white,
        _colorVerticalBorder = AppColors.primaryColor,
        _textAlign = TextAlign.center,
        _padding = EdgeInsets.zero,
        super(key: key);

  TableCell.stickyColumn(
    this.text, {
    Key? key,
    this.textStyle,
    this.cellDimensions = const CellDimensions.fixed(
        contentCellWidth: 150,
        contentCellHeight: 50,
        stickyLegendHeight: 50,
        stickyLegendWidth: 150), //CellDimensions.base,
    this.colorBg = Colors.white,
    this.onTap,
  })  : cellWidth = cellDimensions.stickyLegendWidth,
        cellHeight = cellDimensions.contentCellHeight,
        _colorHorizontalBorder = AppColors.primaryColor,
        _colorVerticalBorder = AppColors.whiteColor,
        _textAlign = TextAlign.start,
        _padding = EdgeInsets.zero,
        super(key: key);

  final CellDimensions cellDimensions;

  final String text;
  final Function()? onTap;

  final double? cellWidth;
  final double? cellHeight;

  final Color colorBg;
  final Color _colorHorizontalBorder;
  final Color _colorVerticalBorder;

  final TextAlign _textAlign;
  final EdgeInsets _padding;

  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: cellWidth,
      height: cellHeight,
      padding: _padding,
      decoration: BoxDecoration(
          border: Border(
            left: BorderSide(color: _colorHorizontalBorder),
            right: BorderSide(color: _colorHorizontalBorder),
            bottom: BorderSide(color: _colorHorizontalBorder),
          ),
          color: colorBg),
      child: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 2.0),
              child: Text(
                text,
                style: textStyle,
                maxLines: 2,
                textAlign: _textAlign,
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: 1.1,
            color: _colorVerticalBorder,
          ),
        ],
      ),
    );
  }
}
