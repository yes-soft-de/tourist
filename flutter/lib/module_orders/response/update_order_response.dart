class UpdateOrderResponse {
  String statusCode;
  String msg;
  Data data;

  UpdateOrderResponse({this.statusCode, this.msg, this.data});

  UpdateOrderResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    msg = json['msg'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
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
  String guidUserID;
  String city;
  String language;
  List<String> services;
  String roomID;
  String status;
  String cost;

  Data(
      {this.id,
      this.guidUserID,
      this.city,
      this.language,
      this.services,
      this.roomID,
      this.status,
      this.cost});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    guidUserID = json['guidUserID'];
    city = json['city'];
    language = json['language'];
    services = json['services'].cast<String>();
    roomID = json['roomID'];
    status = json['status'];
    cost = json['cost'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['guidUserID'] = this.guidUserID;
    data['city'] = this.city;
    data['language'] = this.language;
    data['services'] = this.services;
    data['roomID'] = this.roomID;
    data['status'] = this.status;
    data['cost'] = this.cost;
    return data;
  }
}
