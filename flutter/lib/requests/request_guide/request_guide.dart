class RequestGuideRequest {
  String date;
  String touristUserID;
  String guidUserID;
  String city;
  String language;
  DateTime arriveDate;
  DateTime leaveDate;
  List<String> services;
  String roomID;
  String status;
  String cost;

  RequestGuideRequest(
      {this.date,
      this.touristUserID,
      this.guidUserID,
      this.city,
      this.language,
      this.arriveDate,
      this.leaveDate,
      this.services,
      this.roomID,
      this.status,
      this.cost});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> jsonData = {};

    jsonData["date"] = this.date;
    jsonData["touristUserID"] = this.touristUserID;
    jsonData["guidUserID"] = this.guidUserID;
    jsonData["city"] = this.city;
    jsonData["language"] = this.language;
    jsonData["arriveDate"] = this.arriveDate;
    jsonData["leaveDate"] = this.leaveDate;
    jsonData["services "] = this.services;
    jsonData["roomID"] = this.roomID;
    jsonData["status"] = this.status;
    jsonData["cost"] = this.cost;

    return jsonData;
  }
}