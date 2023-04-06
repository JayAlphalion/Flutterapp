class DriverProfileDataResponse {
  DriverProfileDataResponse({
    required this.driver,
    required this.truck,
  });
  late final Driver driver;
  late final Truck truck;
  
  DriverProfileDataResponse.fromJson(Map<String, dynamic> json){
    driver = Driver.fromJson(json['driver']);
    truck = Truck.fromJson(json['truck']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['driver'] = driver.toJson();
    _data['truck'] = truck.toJson();
    return _data;
  }
}

class Driver {
  Driver({
    required this.driverName,
    required this.driverPhone,
    required this.driverState,
    required this.driverLicenseEXP,
    required this.driverLicenceno,
    required this.driverLicence,
    required this.driverStatus,
  });
  late final String driverName;
  late final String driverPhone;
  late final String driverState;
  late final String driverLicenseEXP;
  late final String driverLicenceno;
  late final List<String> driverLicence;
  late final String driverStatus;
  
  Driver.fromJson(Map<String, dynamic> json){
    driverName = json['driver_name'];
    driverPhone = json['driver_phone'];
    driverState = json['driver_state'];
    driverLicenseEXP = json['driver_licenseEXP'];
    driverLicenceno = json['driver_licenceno'];
    driverLicence = List.castFrom<dynamic, String>(json['driver_licence']);
    driverStatus = json['driver_status'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['driver_name'] = driverName;
    _data['driver_phone'] = driverPhone;
    _data['driver_state'] = driverState;
    _data['driver_licenseEXP'] = driverLicenseEXP;
    _data['driver_licenceno'] = driverLicenceno;
    _data['driver_licence'] = driverLicence;
    _data['driver_status'] = driverStatus;
    return _data;
  }
}

class Truck {
  Truck({
    required this.truckName,
    required this.truckOwner,
    required this.truckPhone,
    required this.truckState,
    required this.truckYear,
    required this.truckPlate,
    required this.truckCompany,
    required this.truckEngineModel,
  });
  late final String truckName;
  late final String truckOwner;
  late final String truckPhone;
  late final String truckState;
  late final String truckYear;
  late final String truckPlate;
  late final String truckCompany;
  late final String truckEngineModel;
  
  Truck.fromJson(Map<String, dynamic> json){
    truckName = json['truck_name'];
    truckOwner = json['truck_owner'];
    truckPhone = json['truck_phone'];
    truckState = json['truck_state'];
    truckYear = json['truck_year'];
    truckPlate = json['truck_plate'];
    truckCompany = json['truck_company'];
    truckEngineModel = json['truck_engine_model'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['truck_name'] = truckName;
    _data['truck_owner'] = truckOwner;
    _data['truck_phone'] = truckPhone;
    _data['truck_state'] = truckState;
    _data['truck_year'] = truckYear;
    _data['truck_plate'] = truckPlate;
    _data['truck_company'] = truckCompany;
    _data['truck_engine_model'] = truckEngineModel;
    return _data;
  }
}