import 'package:tourists/module_shared/model/date/date.dart';

class EventModel {
  int id;
  String name;
  String type;
  String subType;
  Date date;
  String status;
  String location;
  String description;
  List<String> images;

  EventModel({this.id,
    this.name,
    this.type,
    this.subType,
    this.date,
    this.status,
    this.location,
    this.description,
    this.images});
}