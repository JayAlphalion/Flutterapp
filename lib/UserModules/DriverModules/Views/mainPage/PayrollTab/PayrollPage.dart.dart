import 'package:alpha_app/UserModules/DriverModules/Model/PayrollModel.dart';
import 'package:alpha_app/Universals/widgets/ImagePreviewScreen.dart';
import 'package:alpha_app/Universals/helper/DownloadPayrollFileHelper.dart';
import 'package:alpha_app/Universals/utils/AppColors.dart';
import 'package:alpha_app/UserModules/DriverModules/Views/DrawersPage/drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' hide Column, Row;
// External package imports
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_datagrid_export/export.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class PayrollPage extends StatefulWidget {
  const PayrollPage({Key? key}) : super(key: key);

  @override
  State<PayrollPage> createState() => _PayrollPageState();
}

class _PayrollPageState extends State<PayrollPage> {
  List<PayrollModel> _employees = <PayrollModel>[];
  late EmployeeDataSource _employeeDataSource;

  final GlobalKey<SfDataGridState> _key = GlobalKey<SfDataGridState>();

  @override
  void initState() {
    super.initState();
    _employees = _getEmployeeData();
    _employeeDataSource = EmployeeDataSource(employeeData: _employees);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.chatBgScreenColor,
      drawer: MyDrawer(),
      appBar: AppBar(
          leading: Builder(
            builder: (context) => IconButton(
              icon: new Icon(Icons.menu),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
          title: Text('Payroll'),
          actions: [
            IconButton(
              onPressed: () {
                _exportDataGridToPdf();
              },
              icon: const Icon(
                Icons.download,
                size: 30,
              ),
            ),
          ],
          backgroundColor: AppColors.primaryColor),
      body: SfDataGrid(
        gridLinesVisibility: GridLinesVisibility.both,
        headerGridLinesVisibility: GridLinesVisibility.both,
        // isScrollbarAlwaysShown: true,
        key: _key,
        source: _employeeDataSource,
        columns: <GridColumn>[
          GridColumn(
              columnName: 'Date',
              minimumWidth: 120,
              label: Container(
                  padding: const EdgeInsets.all(16.0),
                  alignment: Alignment.center,
                  child: Text(
                    'Date',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ))),
          GridColumn(
              columnName: 'SSL',
              minimumWidth: 120,
              label: Container(
                  padding: const EdgeInsets.all(8.0),
                  alignment: Alignment.center,
                  child: const Text(
                    'SSL',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ))),
          GridColumn(

              // minimumWidth: double.negativeInfinity,
              // maximumWidth: 200,
              minimumWidth: 100,
              columnName: 'State',
              label: Container(
                  padding: const EdgeInsets.all(8.0),
                  alignment: Alignment.center,
                  child: const Text(
                    'State',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ))),
          GridColumn(
              columnName: 'Status',
              minimumWidth: 120,
              label: Container(
                  padding: const EdgeInsets.all(8.0),
                  alignment: Alignment.center,
                  child: const Text(
                    'Status',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ))),
          GridColumn(
              columnName: 'Email',
              minimumWidth: 180,
              label: Container(
                  padding: const EdgeInsets.all(8.0),
                  alignment: Alignment.center,
                  child: const Text(
                    'Email',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ))),
          GridColumn(
              minimumWidth: 200,
              columnName: 'Payroll',
              label: Container(
                  padding: const EdgeInsets.all(8.0),
                  alignment: Alignment.center,
                  child: const Text(
                    'Payroll',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ))),
          GridColumn(
              columnName: 'Gross Amount',
              minimumWidth: 140,
              label: Container(
                  padding: const EdgeInsets.all(8.0),
                  alignment: Alignment.center,
                  child: const Text(
                    'Gross Amount',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ))),
          GridColumn(
              columnName: 'W2 Amount',
              minimumWidth: 120,
              label: Container(
                  padding: const EdgeInsets.all(8.0),
                  alignment: Alignment.center,
                  child: const Text(
                    'W2 Amount',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ))),
          GridColumn(
              columnName: 'W2 Gross Amount',
              minimumWidth: 170,
              label: Container(
                  padding: const EdgeInsets.all(8.0),
                  alignment: Alignment.center,
                  child: const Text(
                    'W2 Gross Amount',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ))),
          GridColumn(
              columnName: 'Net Amount',
              minimumWidth: 120,
              label: Container(
                  padding: const EdgeInsets.all(8.0),
                  alignment: Alignment.center,
                  child: const Text(
                    'Net Amount',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ))),
          GridColumn(
              columnName: 'Driver Reimuberse',
              minimumWidth: 180,
              label: Container(
                  padding: const EdgeInsets.all(8.0),
                  alignment: Alignment.center,
                  child: const Text(
                    'Driver Reimuberse',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ))),
          GridColumn(
              columnName: 'Receipt',
              minimumWidth: 200,
              label: Container(
                  padding: const EdgeInsets.all(8.0),
                  alignment: Alignment.center,
                  child: const Text(
                    'Receipt',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ))),
          GridColumn(
              columnName: 'Driver Note',
              minimumWidth: 200,
              label: Container(
                  padding: const EdgeInsets.all(8.0),
                  alignment: Alignment.center,
                  child: const Text(
                    'Driver Note',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ))),
          GridColumn(
              columnName: 'Advance',
              label: Container(
                  padding: const EdgeInsets.all(8.0),
                  alignment: Alignment.center,
                  child: const Text(
                    'Advance',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ))),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 50,
          color: Colors.white,
          width: Get.width / 1,
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.navigate_before,
                          size: 25, color: Colors.black45),
                      Text(
                        "Previous",
                        style: TextStyle(
                          color: Colors.black45,
                          fontSize: 14,
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Next",
                        style: TextStyle(
                          color: Colors.black45,
                          fontSize: 14,
                        ),
                      ),
                      Icon(Icons.navigate_next_outlined,
                          size: 25, color: Colors.black45),
                    ],
                  ),
                ]),
          ),
        ),
      ),
    );
  }

  Future<void> _exportDataGridToPdf() async {
    final PdfDocument document =
        _key.currentState!.exportToPdfDocument(fitAllColumnsInOnePage: true);

    final List<int> bytes = document.saveSync();
    await saveAndLaunchFile(
        bytes, 'payroll_file_' + DateTime.now().toString() + '.pdf');
    document.dispose();
  }

  List<PayrollModel> _getEmployeeData() {
    List<PayrollModel> payrollList = [];
    for (int i = 0; i < 15; i++)
      payrollList.add(PayrollModel(
          dateTime: '01/01/2023',
          ssl: '031-86-7798',
          state: 'CA',
          status: 'Delivered',
          email: 'Irrivender@gmail.com',
          payrollImgUrl: [
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT1tHmCioYM9n1squ9Tw6_v3QbEDSc3WKtbEg&usqp=CAU'
          ],
          grossAmount: '\$24000.00',
          w2hAmount: '\$24.00',
          w2GrossAmount: '\$9900.00',
          netAmount: '\$9500.00',
          driversRimubersment: '\$56',
          receiptImgUrl: [
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT1tHmCioYM9n1squ9Tw6_v3QbEDSc3WKtbEg&usqp=CAU'
          ],
          driverNotes: 'Reimburse for Truck Wash',
          advanceAmount: '\$45'));

    return payrollList;
  }
}

/// An object to set the employee collection data source to the datagrid. This
/// is used to map the employee data to the datagrid widget.
class EmployeeDataSource extends DataGridSource {
  /// Creates the employee data source class with required details.
  EmployeeDataSource({required List<PayrollModel> employeeData}) {
    _employeeData = employeeData
        .map<DataGridRow>((PayrollModel e) => DataGridRow(cells: <DataGridCell>[
              DataGridCell<String>(columnName: 'Date', value: e.dateTime),
              DataGridCell<String>(columnName: 'SSL', value: e.ssl),
              DataGridCell<String>(columnName: 'State', value: e.state),
              DataGridCell<String>(columnName: 'Status', value: e.status),
              DataGridCell<String>(columnName: 'Email', value: e.email),
              DataGridCell<List<String>>(
                  columnName: 'Payroll', value: e.payrollImgUrl),
              DataGridCell<String>(
                  columnName: 'Gross Amount', value: e.grossAmount),
              DataGridCell<String>(columnName: 'W2 Amount', value: e.w2hAmount),
              DataGridCell<String>(
                  columnName: 'W2 Gross Amount', value: e.w2GrossAmount),
              DataGridCell<String>(
                  columnName: 'Net Amount', value: e.netAmount),
              DataGridCell<String>(
                  columnName: 'Driver Reimuberse',
                  value: e.driversRimubersment),
              DataGridCell<List<String>>(
                  columnName: 'Receipt', value: e.receiptImgUrl),
              DataGridCell<String>(
                  columnName: 'Driver Note', value: e.driverNotes),
              DataGridCell<String>(
                  columnName: 'Advance', value: e.advanceAmount),
            ]))
        .toList();
  }

  List<DataGridRow> _employeeData = <DataGridRow>[];

  @override
  List<DataGridRow> get rows => _employeeData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((DataGridCell cell) {
      return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(8.0),
        child: cell.value is List
            ? InkWell(
                onTap: () {
                  Get.to(ImagePrivewScreen(
                    url: cell.value[0],
                  ));
                },
                child: Image.network(
                  cell.value[0],
                  fit: BoxFit.fill,
                  width: 200,
                ),
              )
            : Text(
                cell.value.toString(),
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
      );
    }).toList());
  }
}
