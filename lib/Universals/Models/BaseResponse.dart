class BaseResponse {
  BaseResponse({
    required this.status,
    required this.message,
    required this.data,
  });
  late final String status;
  late final String message;
  late final Data data;

  BaseResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = Data.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['message'] = message;
    _data['data'] = data.toJson();
    return _data;
  }
}

class Data {
  Data({required this.body});
  late final Map<String, dynamic> body;

  factory Data.fromJson(Map<String, dynamic> json) => Data(body: json);

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    return _data;
  }
}
