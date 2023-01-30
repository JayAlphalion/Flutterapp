class GetCurrentLoadDispatchResponse {
  GetCurrentLoadDispatchResponse({
    required this.receiverCity,
    required this.LoadType,
    required this.id,
    required this.PUDate,
    required this.shipperCity,
    required this.shipperData,
    required this.shiperZip,
    required this.dropType,
    required this.loadNumber,
    required this.receiverData,
    required this.shipperState,
    required this.loadStatus,
    required this.carrierMC,
    required this.receiverZip,
    required this.PUTime,
    required this.trailerId,
    required this.lane,
    required this.shipperId,
    required this.dispatch,
    required this.truckId,
    required this.receiverType,
    required this.receiverId,
    required this.DELTime,
    required this.DELDate,
    required this.receiverAddress,
    required this.shipType,
    required this.receiverState,
    required this.truckName,
    required this.PUStatus,
    required this.clientId,
    required this.shipperAddress,
    required this.carrierName,
  });
  late final String receiverCity;
  late final String LoadType;
  late final String id;
  late final String PUDate;
  late final List<String> shipperCity;
  late final ShipperData shipperData;
  late final List<String> shiperZip;
  late final String dropType;
  late final String loadNumber;
  late final ReceiverData receiverData;
  late final List<String> shipperState;
  late final String loadStatus;
  late final List<String> carrierMC;
  late final List<String> receiverZip;
  late final String PUTime;
  late final List<String> trailerId;
  late final String lane;
  late final List<String> shipperId;
  late final int dispatch;
  late final List<String> truckId;
  late final String receiverType;
  late final List<String> receiverId;
  late final String DELTime;
  late final String DELDate;
  late final List<String> receiverAddress;
  late final String shipType;
  late final List<String> receiverState;
  late final List<String> truckName;
  late final String PUStatus;
  late final List<String> clientId;
  late final List<String> shipperAddress;
  late final List<String> carrierName;
  
  GetCurrentLoadDispatchResponse.fromJson(Map<String, dynamic> json){
    receiverCity = json['receiver_city'];
    LoadType = json['Load_type'];
    id = json['id'];
    PUDate = json['PU_Date'];
    shipperCity = List.castFrom<dynamic, String>(json['shipper_city']);
    shipperData = ShipperData.fromJson(json['shipperData']);
    shiperZip = List.castFrom<dynamic, String>(json['shiper_zip']);
    dropType = json['drop_type'];
    loadNumber = json['load_number'];
    receiverData = ReceiverData.fromJson(json['receiverData']);
    shipperState = List.castFrom<dynamic, String>(json['shipper_state']);
    loadStatus = json['load_status'];
    carrierMC = List.castFrom<dynamic, String>(json['carrier_MC']);
    receiverZip = List.castFrom<dynamic, String>(json['receiver_zip']);
    PUTime = json['PU_time'];
    trailerId = List.castFrom<dynamic, String>(json['trailer_id']);
    lane = json['lane'];
    shipperId = List.castFrom<dynamic, String>(json['shipper_id']);
    dispatch = json['dispatch'];
    truckId = List.castFrom<dynamic, String>(json['truck_id']);
    receiverType = json['receiverType'];
    receiverId = List.castFrom<dynamic, String>(json['receiver_id']);
    DELTime = json['DEL_time'];
    DELDate = json['DEL_Date'];
    receiverAddress = List.castFrom<dynamic, String>(json['receiver_address']);
    shipType = json['ship_type'];
    receiverState = List.castFrom<dynamic, String>(json['receiver_state']);
    truckName = List.castFrom<dynamic, String>(json['truck_name']);
    PUStatus = json['PU_status'];
    clientId = List.castFrom<dynamic, String>(json['client_id']);
    shipperAddress = List.castFrom<dynamic, String>(json['shipper_address']);
    carrierName = List.castFrom<dynamic, String>(json['carrier_name']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['receiver_city'] = receiverCity;
    _data['Load_type'] = LoadType;
    _data['id'] = id;
    _data['PU_Date'] = PUDate;
    _data['shipper_city'] = shipperCity;
    _data['shipperData'] = shipperData.toJson();
    _data['shiper_zip'] = shiperZip;
    _data['drop_type'] = dropType;
    _data['load_number'] = loadNumber;
    _data['receiverData'] = receiverData.toJson();
    _data['shipper_state'] = shipperState;
    _data['load_status'] = loadStatus;
    _data['carrier_MC'] = carrierMC;
    _data['receiver_zip'] = receiverZip;
    _data['PU_time'] = PUTime;
    _data['trailer_id'] = trailerId;
    _data['lane'] = lane;
    _data['shipper_id'] = shipperId;
    _data['dispatch'] = dispatch;
    _data['truck_id'] = truckId;
    _data['receiverType'] = receiverType;
    _data['receiver_id'] = receiverId;
    _data['DEL_time'] = DELTime;
    _data['DEL_Date'] = DELDate;
    _data['receiver_address'] = receiverAddress;
    _data['ship_type'] = shipType;
    _data['receiver_state'] = receiverState;
    _data['truck_name'] = truckName;
    _data['PU_status'] = PUStatus;
    _data['client_id'] = clientId;
    _data['shipper_address'] = shipperAddress;
    _data['carrier_name'] = carrierName;
    return _data;
  }
}

class ShipperData {
  ShipperData({
    required this.FullAddress,
    required this.Zip,
    required this.Name,
    required this.city,
  });
  late final String FullAddress;
  late final String Zip;
  late final String Name;
  late final String city;
  
  ShipperData.fromJson(Map<String, dynamic> json){
    FullAddress = json['FullAddress'];
    Zip = json['Zip'];
    Name = json['Name'];
    city = json['city'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['FullAddress'] = FullAddress;
    _data['Zip'] = Zip;
    _data['Name'] = Name;
    _data['city'] = city;
    return _data;
  }
}

class ReceiverData {
  ReceiverData({
    required this.Name,
    required this.city,
    required this.Zip,
    required this.FullAddress,
  });
  late final String Name;
  late final String city;
  late final String Zip;
  late final String FullAddress;
  
  ReceiverData.fromJson(Map<String, dynamic> json){
    Name = json['Name'];
    city = json['city'];
    Zip = json['Zip'];
    FullAddress = json['FullAddress'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['Name'] = Name;
    _data['city'] = city;
    _data['Zip'] = Zip;
    _data['FullAddress'] = FullAddress;
    return _data;
  }
}