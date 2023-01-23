import 'dart:convert';

class GetPreviousApiResponse {
  GetPreviousApiResponse({
    required this.data,
  });
  late final List<Data> data;
  
  GetPreviousApiResponse.fromJson(Map<String, dynamic> json){
    data = List.from(json['data']).map((e)=>Data.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Data {
  Data({
    required this.id,
    required this.claimData,
  });
  late final String id;
  late final ClaimData claimData;
  
  Data.fromJson(Map<String, dynamic> json){
    id = json['id'];
    claimData = ClaimData.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['data'] = claimData.toJson();
    return _data;
  }
}

class ClaimData {
  ClaimData({
    required this.driverInsurance,
    required this.driverDl,
    required this.status,
    required this.extraNotes,
    required this.driverName,
    required this.location,
    required this.date,
    required this.notesData,
    required this.driverPhNo,
    required this.id,
    required this.sceneImage,
    required this.otherDoc,
    required this.audio,
    required this.policeReportDoc,
    required this.video,
  });
  late final String driverInsurance;
  late final String driverDl;
  late final String status;
  late final String extraNotes;
  late final String driverName;
  late final String location;
  late final String date;
  late final String notesData;
  late final String driverPhNo;
  late final int? id;
  late final String sceneImage;
  late final String otherDoc;
  late final String audio;
  late final String? policeReportDoc;
  late final String video;
  
  ClaimData.fromJson(Map<String, dynamic> json){
    driverInsurance = json['driver_insurance'];
    driverDl = json['driver_dl'];
    status = json['status'];
    extraNotes = json['extra_notes'];
    driverName = json['driver_name'];
    location = json['location'];
    date = json['date'];
    notesData = json['notes_data'];
    driverPhNo = json['driver_ph_no'];
    id = json['id'];
    sceneImage = json['scene_image'];
    otherDoc = json['other_doc'];
    audio = json['audio'];
    policeReportDoc = json['police_report_doc'];
    video = json['video'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['driver_insurance'] = driverInsurance;
    _data['driver_dl'] = driverDl;
    _data['status'] = status;
    _data['extra_notes'] = extraNotes;
    _data['driver_name'] = driverName;
    _data['location'] = location;
    _data['date'] = date;
    _data['notes_data'] = notesData;
    _data['driver_ph_no'] = driverPhNo;
    _data['id'] = id;
    _data['scene_image'] = sceneImage;
    _data['other_doc'] = otherDoc;
    _data['audio'] = audio;
    _data['police_report_doc'] = policeReportDoc;
    _data['video'] = video;
    return _data;
  }
}