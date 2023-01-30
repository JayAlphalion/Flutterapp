class UpcomingLoadDispatchApiResponse {
  UpcomingLoadDispatchApiResponse({
    required this.loadNumber,
    required this.shipperDetails,
    required this.receiverDetails,
    required this.PUNumber,
    required this.checkInUnder,
  });
  late final String loadNumber;
  late final ShipperDetails shipperDetails;
  late final ReceiverDetails receiverDetails;
  late final String PUNumber;
  late final String checkInUnder;
  
  UpcomingLoadDispatchApiResponse.fromJson(Map<String, dynamic> json){
    loadNumber = json['load_number'];
    shipperDetails = ShipperDetails.fromJson(json['shipper_details']);
    receiverDetails = ReceiverDetails.fromJson(json['receiver_details']);
    PUNumber = json['PU_number#'];
    checkInUnder = json['check_in_under'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['load_number'] = loadNumber;
    _data['shipper_details'] = shipperDetails.toJson();
    _data['receiver_details'] = receiverDetails.toJson();
    _data['PU_number#'] = PUNumber;
    _data['check_in_under'] = checkInUnder;
    return _data;
  }
}

class ShipperDetails {
  ShipperDetails({
    required this.shipperState,
    required this.shipperAddress,
    required this.shipperZip,
    required this.shipper,
    required this.PUDate,
    required this.PUTime,
    required this.PUType,
  });
  late final String shipperState;
  late final String shipperAddress;
  late final String shipperZip;
  late final String shipper;
  late final String PUDate;
  late final String PUTime;
  late final String PUType;
  
  ShipperDetails.fromJson(Map<String, dynamic> json){
    shipperState = json['shipper_state'];
    shipperAddress = json['shipper_address'];
    shipperZip = json['shipper_zip'];
    shipper = json['shipper'];
    PUDate = json['PU_date'];
    PUTime = json['PU_time'];
    PUType = json['PU_type'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['shipper_state'] = shipperState;
    _data['shipper_address'] = shipperAddress;
    _data['shipper_zip'] = shipperZip;
    _data['shipper'] = shipper;
    _data['PU_date'] = PUDate;
    _data['PU_time'] = PUTime;
    _data['PU_type'] = PUType;
    return _data;
  }
}

class ReceiverDetails {
  ReceiverDetails({
    required this.receiverState,
    required this.receiverAddress,
    required this.receiverZip,
    required this.receiver,
    required this.deliveryDate,
    required this.deliveryTime,
    required this.DropType,
  });
  late final String receiverState;
  late final String receiverAddress;
  late final String receiverZip;
  late final String receiver;
  late final String deliveryDate;
  late final String deliveryTime;
  late final String DropType;
  
  ReceiverDetails.fromJson(Map<String, dynamic> json){
    receiverState = json['receiver_state'];
    receiverAddress = json['receiver_address'];
    receiverZip = json['receiver_zip'];
    receiver = json['receiver'];
    deliveryDate = json['delivery_date'];
    deliveryTime = json['delivery_time'];
    DropType = json['Drop_type'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['receiver_state'] = receiverState;
    _data['receiver_address'] = receiverAddress;
    _data['receiver_zip'] = receiverZip;
    _data['receiver'] = receiver;
    _data['delivery_date'] = deliveryDate;
    _data['delivery_time'] = deliveryTime;
    _data['Drop_type'] = DropType;
    return _data;
  }
}