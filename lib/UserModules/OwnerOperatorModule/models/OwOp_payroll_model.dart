class PayrollModel {
  String dateTime;
  String truckNo;
  String ssl;
  String state;
  String status;
  String email;
  List<String> payrollImgUrl;
  String grossAmount;
  String w2hAmount;
  String w2GrossAmount;
  String netAmount;
  String driversRimubersment;
  List<String> receiptImgUrl;
  String driverNotes;
  String advanceAmount;

  PayrollModel(
      {required this.dateTime,
      required this.truckNo,
      required this.ssl,
      required this.state,
      required this.status,
      required this.email,
      required this.payrollImgUrl,
      required this.grossAmount,
      required this.w2hAmount,
      required this.w2GrossAmount,
      required this.netAmount,
      required this.driversRimubersment,
      required this.receiptImgUrl,
      required this.driverNotes,
      required this.advanceAmount});
}
