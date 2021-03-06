import 'package:tourists/module_shared/model/date/date.dart';

class EventDetailsModel {
  int id;
  String name;
  String type;
  String subType;
  Date date;
  String status;
  String location;
  String description;
  List<String> images;

  EventDetailsModel(
      {this.id,
      this.name,
      this.type,
      this.subType,
      this.date,
      this.status,
      this.location,
      this.description,
      this.images});

  EventDetailsModel.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = <String, dynamic>{};
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
