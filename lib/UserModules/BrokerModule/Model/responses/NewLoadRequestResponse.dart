class NewLoadRequestionResponse {
  NewLoadRequestionResponse({
    required this.customerEmail,
    required this.PUDate,
    required this.shipperAddress,
    required this.deliveryDate,
    required this.customerName,
    required this.PUType,
    required this.loadNumber,
    required this.deliveryTime,
    required this.Price,
    required this.loadType,
    required this.Lane,
    required this.carrierRC,
    required this.shipperCity,
    required this.customerAddress,
    required this.dispatch,
    required this.PUTime,
    required this.clientData,
    required this.DropType,
    required this.receiverCity,
    required this.receiverAddress,
    required this.receiverZip,
    required this.shipperState,
    required this.shipperZip,
    required this.receiverState,
    required this.loadStatus,
  });
  late final List<String> customerEmail;
  late final String PUDate;
  late final List<String> shipperAddress;
  late final String deliveryDate;
  late final List<String> customerName;
  late final String PUType;
  late final String loadNumber;
  late final String deliveryTime;
  late final String Price;
  late final String loadType;
  late final String Lane;
  late final List<CarrierRC> carrierRC;
  late final List<String> shipperCity;
  late final List<String> customerAddress;
  late final String dispatch;
  late final String PUTime;
  late final ClientData clientData;
  late final String DropType;
  late final List<String> receiverCity;
  late final List<String> receiverAddress;
  late final List<String> receiverZip;
  late final List<String> shipperState;
  late final List<String> shipperZip;
  late final List<String> receiverState;
  late final String loadStatus;
  
  NewLoadRequestionResponse.fromJson(Map<String, dynamic> json){
    customerEmail = List.castFrom<dynamic, String>(json['customer_email']);
    PUDate = json['PU_date'].toString();
    shipperAddress = List.castFrom<dynamic, String>(json['shipper_address']);
    deliveryDate = json['delivery_date'].toString();
    customerName = List.castFrom<dynamic, String>(json['customer_name']);
    PUType = json['PU_type'].toString();
    loadNumber = json['load_number'].toString();
    deliveryTime = json['delivery_time'].toString();
    Price = json['Price'].toString();
    loadType = json['load_type'].toString();
    Lane = json['Lane'].toString();
    carrierRC = List.from(json['carrier_RC']).map((e)=>CarrierRC.fromJson(e)).toList();
    shipperCity = List.castFrom<dynamic, String>(json['shipper_city']);
    customerAddress = List.castFrom<dynamic, String>(json['customer_address']);
    dispatch = json['dispatch'].toString();
    PUTime = json['PU_time'].toString();
    clientData = ClientData.fromJson(json['clientData']);
    DropType = json['Drop_type'].toString();
    receiverCity = List.castFrom<dynamic, String>(json['receiver_city']);
    receiverAddress = List.castFrom<dynamic, String>(json['receiver_address']);
    receiverZip = List.castFrom<dynamic, String>(json['receiver_zip']);
    shipperState = List.castFrom<dynamic, String>(json['shipper_state']);
    shipperZip = List.castFrom<dynamic, String>(json['shipper_zip']);
    receiverState = List.castFrom<dynamic, String>(json['receiver_state']);
    loadStatus = json['load_status'].toString();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['customer_email'] = customerEmail;
    _data['PU_date'] = PUDate;
    _data['shipper_address'] = shipperAddress;
    _data['delivery_date'] = deliveryDate;
    _data['customer_name'] = customerName;
    _data['PU_type'] = PUType;
    _data['load_number'] = loadNumber;
    _data['delivery_time'] = deliveryTime;
    _data['Price'] = Price;
    _data['load_type'] = loadType;
    _data['Lane'] = Lane;
    _data['carrier_RC'] = carrierRC.map((e)=>e.toJson()).toList();
    _data['shipper_city'] = shipperCity;
    _data['customer_address'] = customerAddress;
    _data['dispatch'] = dispatch;
    _data['PU_time'] = PUTime;
    _data['clientData'] = clientData.toJson();
    _data['Drop_type'] = DropType;
    _data['receiver_city'] = receiverCity;
    _data['receiver_address'] = receiverAddress;
    _data['receiver_zip'] = receiverZip;
    _data['shipper_state'] = shipperState;
    _data['shipper_zip'] = shipperZip;
    _data['receiver_state'] = receiverState;
    _data['load_status'] = loadStatus;
    return _data;
  }
}

class CarrierRC {
  CarrierRC({
    required this.type,
    required this.thumbnails,
    required this.filename,
    required this.url,
    required this.id,
    required this.size,
  });
  late final String type;
  late final Thumbnails thumbnails;
  late final String filename;
  late final String url;
  late final String id;
  late final int size;
  
  CarrierRC.fromJson(Map<String, dynamic> json){
    type = json['type'];
    thumbnails = Thumbnails.fromJson(json['thumbnails']);
    filename = json['filename'];
    url = json['url'];
    id = json['id'];
    size = json['size'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['type'] = type;
    _data['thumbnails'] = thumbnails.toJson();
    _data['filename'] = filename;
    _data['url'] = url;
    _data['id'] = id;
    _data['size'] = size;
    return _data;
  }
}

class Thumbnails {
  Thumbnails({
    required this.large,
    required this.small,
  });
  late final Large large;
  late final Small small;
  
  Thumbnails.fromJson(Map<String, dynamic> json){
    large = Large.fromJson(json['large']);
    small = Small.fromJson(json['small']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['large'] = large.toJson();
    _data['small'] = small.toJson();
    return _data;
  }
}

class Large {
  Large({
    required this.url,
    required this.width,
    required this.height,
  });
  late final String url;
  late final int width;
  late final int height;
  
  Large.fromJson(Map<String, dynamic> json){
    url = json['url'];
    width = json['width'];
    height = json['height'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['url'] = url;
    _data['width'] = width;
    _data['height'] = height;
    return _data;
  }
}

class Small {
  Small({
    required this.width,
    required this.height,
    required this.url,
  });
  late final int width;
  late final int height;
  late final String url;
  
  Small.fromJson(Map<String, dynamic> json){
    width = json['width'];
    height = json['height'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['width'] = width;
    _data['height'] = height;
    _data['url'] = url;
    return _data;
  }
}

class ClientData {
  ClientData({
    required this.BankName,
    required this.Address,
    required this.UBI,
    required this.Name,
    required this.BMC_85Expiration,
    required this.MC,
    required this.Routing,
    required this.Business_Expiration,
    required this.EIN,
    required this.SUI_Number,
    required this.Status,
  });
  late final String BankName;
  late final String Address;
  late final String UBI;
  late final String Name;
  late final String BMC_85Expiration;
  late final String MC;
  late final String Routing;
  late final String Business_Expiration;
  late final String EIN;
  late final String SUI_Number;
  late final String Status;
  
  ClientData.fromJson(Map<String, dynamic> json){
    BankName = json['Bank Name'];
    Address = json['Address'];
    UBI = json['UBI'];
    Name = json['Name'];
    BMC_85Expiration = json['BMC-85 Expiration'];
    MC= json['MC #'];
    Routing = json['Routing'];
    Business_Expiration = json['Business Expiration'];
    EIN = json['EIN #'];
    SUI_Number = json['SUI Number'];
    Status = json['Status'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['Bank Name'] = BankName;
    _data['Address'] = Address;
    _data['UBI'] = UBI;
    _data['Name'] = Name;
    _data['BMC-85 Expiration'] = BMC_85Expiration;
    _data['MC #'] = MC;
    _data['Routing'] = Routing;
    _data['Business Expiration'] = Business_Expiration;
    _data['EIN #'] = EIN;
    _data['SUI Number'] = SUI_Number;
    _data['Status'] = Status;
    return _data;
  }
}