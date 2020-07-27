import 'package:tourists/models/date/date.dart';

class EventModel {
  int id;
  String name;
  String type;
  Null subType;
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