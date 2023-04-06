class GetPreviousClaimApiResponse {
  GetPreviousClaimApiResponse({
    required this.claims,
  });
  late final List<Claims> claims;
  
  GetPreviousClaimApiResponse.fromJson(Map<String, dynamic> json){
    claims = List.from(json['data']).map((e)=>Claims.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = claims.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Claims {
  Claims({
    required this.id,
    required this.data,
  });
  late final String id;
  late final ClaimData data;
  
  Claims.fromJson(Map<String, dynamic> json){
    id = json['id'];
    data = ClaimData.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['data'] = data.toJson();
    return _data;
  }
}

class ClaimData {
  ClaimData({
    required this.notesData,
    required this.otherDoc,
    required this.driverPhNo,
    required this.driverInsurance,
    required this.id,
    required this.extraNotes,
    required this.location,
    required this.date,
    required this.video,
    required this.driverName,
    required this.driverDl,
    required this.status,
    required this.audio,
    required this.policeReportDoc,
    required this.sceneImage,
  });
  late final String notesData;
  late final List<String> otherDoc;
  late final String driverPhNo;
  late final List<String> driverInsurance;
  late final int id;
  late final String extraNotes;
  late final String location;
  late final String date;
  late final List<String> video;
  late final String driverName;
  late final List<String> driverDl;
  late final String status;
  late final List<String> audio;
  late final List<String> policeReportDoc;
  late final List<String> sceneImage;
  
  ClaimData.fromJson(Map<String, dynamic> json){
    notesData = json['notes_data'];
    otherDoc =List.castFrom<dynamic, String>(json['other_doc']);
    driverPhNo = json['driver_ph_no'];
    driverInsurance = List.castFrom<dynamic, String>(json['driver_insurance']);
    id = json['id'];
    extraNotes = json['extra_notes'];
    location = json['location'];
    date = json['date'];
    video = List.castFrom<dynamic, String>(json['video']);
    driverName = json['driver_name'];
    driverDl = List.castFrom<dynamic, String>(json['driver_dl']);
    status = json['status'];
    audio = List.castFrom<dynamic, String>(json['audio']);
    policeReportDoc = List.castFrom<dynamic, String>(json['police_report_doc']);
    sceneImage = List.castFrom<dynamic, String>(json['scene_image']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['notes_data'] = notesData;
    _data['other_doc'] = otherDoc;
    _data['driver_ph_no'] = driverPhNo;
    _data['driver_insurance'] = driverInsurance;
    _data['id'] = id;
    _data['extra_notes'] = extraNotes;
    _data['location'] = location;
    _data['date'] = date;
    _data['video'] = video;
    _data['driver_name'] = driverName;
    _data['driver_dl'] = driverDl;
    _data['status'] = status;
    _data['audio'] = audio;
    _data['police_report_doc'] = policeReportDoc;
    _data['scene_image'] = sceneImage;
    return _data;
  }
}