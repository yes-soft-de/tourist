import 'package:tourists/models/date/date.dart';

class EventListResponse {
  String statusCode;
  String msg;
  List<Data> data;

  EventListResponse({this.statusCode, this.msg, this.data});

  EventListResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_code'] = this.statusCode;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int id;
  String name;
  String type;
  String subType;
  Date date;
  String status;
  String location;
  String description;
  List<String> images;

  Data(
      {this.id,
        this.name,
        this.type,
        this.subType,
        this.date,
        this.status,
        this.location,
        this.description,
        this.images});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    subType = json['subType'];
    date = json['date'] != null ? new Date.fromJson(json['date']) : null;
    status = json['status'];
    location = json['location'];
    description = json['description'];
    images = json['images'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['type'] = this.type;
    data['subType'] = this.subType;
    if (this.date != null) {
      data['date'] = this.date.toJson();
    }
    data['status'] = this.status;
    data['location'] = this.location;
    data['description'] = this.description;
    data['images'] = this.images;
    return data;
  }
}

