class UpdateGuidResponse {
  String statusCode;
  String msg;
  Data data;

  UpdateGuidResponse({this.statusCode, this.msg, this.data});

  UpdateGuidResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    msg = json['msg'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status_code'] = this.statusCode;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  int id;
  String name;
  Null status;
  String about;
  List<String> city;
  List<String> language;
  String phoneNumber;
  Null cost;
  List<String> service;
  String path;

  Data(
      {this.id,
      this.name,
      this.status,
      this.about,
      this.city,
      this.language,
      this.phoneNumber,
      this.cost,
      this.service,
      this.path});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    status = json['status'];
    about = json['about'];
    city = json['city'].cast<String>();
    language = json['language'].cast<String>();
    phoneNumber = json['phoneNumber'];
    cost = json['cost'];
    service = json['service'].cast<String>();
    path = json['path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['name'] = this.name;
    data['status'] = this.status;
    data['about'] = this.about;
    data['city'] = this.city;
    data['language'] = this.language;
    data['phoneNumber'] = this.phoneNumber;
    data['cost'] = this.cost;
    data['service'] = this.service;
    data['path'] = this.path;
    return data;
  }
}
