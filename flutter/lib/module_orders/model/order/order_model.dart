import 'package:tourists/module_guide/model/guide_list_item/guide_list_item.dart';
import 'package:tourists/module_shared/model/date/date.dart';
import 'package:tourists/utils/time/time_formatter.dart';

class OrderModel {
  int id;
  Date date;
  String touristUserID;
  String guidUserID;
  String city;
  String language;
  Date arriveDate;
  Date leaveDate;
  List<String> services;
  String roomID;
  String status;
  String cost;
  GuideListItemModel guideInfo;

  OrderModel(
      {this.id,
      this.date,
      this.touristUserID,
      this.guidUserID,
      this.city,
      this.language,
      this.arriveDate,
      this.leaveDate,
      this.services,
      this.roomID,
      this.status,
      this.guideInfo,
      this.cost});

  OrderModel.fromJson(Map<String, dynamic> json) {
    date = json['date'] != null ? new Date.fromJson(json['date']) : null;
    touristUserID = json['touristUserID'];
    guidUserID = json['guidUserID'];
    city = json['city'];
    id = json['id'];
    language = json['language'];
    arriveDate = json['arriveDate'] != null
        ? new Date.fromJson(json['arriveDate'])
        : null;
    leaveDate =
        json['leaveDate'] != null ? new Date.fromJson(json['leaveDate']) : null;
    services = json['services'].cast<String>();
    roomID = json['roomID'];
    status = json['status'];
    cost = json['cost'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.date != null) {
      data['date'] = TimeFormatter.getDartDate(this.date).toString();
    }
    data['touristUserID'] = this.touristUserID;
    data['guidUserID'] = this.guidUserID;
    data['city'] = this.city;
    data['id'] = this.id;
    data['language'] = this.language;
    if (this.arriveDate != null) {
      data['arriveDate'] =
          TimeFormatter.getDartDate(this.arriveDate).toString();
    }
    if (this.leaveDate != null) {
      data['leaveDate'] = TimeFormatter.getDartDate(this.leaveDate).toString();
    }
    if (this.services != null) {
      data['services'] = this.services;
    }
    data['roomID'] = this.roomID;
    data['status'] = this.status;
    data['cost'] = this.cost;
    return data;
  }
}
