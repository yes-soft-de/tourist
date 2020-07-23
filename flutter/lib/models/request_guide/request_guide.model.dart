import 'package:flutter/material.dart';

class RequestGuideModel {
  String uid;
  String guideId;
  List<String> services;
  String location;
  DateTime arrivalDate;
  String language;
  int stayingDays;

  RequestGuideModel(
      {@required this.location,
      @required this.stayingDays,
      @required this.guideId,
      @required this.language,
      @required this.arrivalDate,
      this.uid,
      @required this.services});
}
