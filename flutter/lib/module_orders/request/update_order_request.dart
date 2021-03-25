class UpdateOrderRequest {
  String date;
  String touristUserID;
  String guidUserID;
  String city;
  String language;
  String arriveDate;
  String leaveDate;
  String status;
  List<String> services;
  String id;
  int cost;
  String roomID;

  UpdateOrderRequest(
      {this.date,
        this.touristUserID,
        this.guidUserID,
        this.city,
        this.language,
        this.arriveDate,
        this.leaveDate,
        this.status,
        this.services,
        this.id,
        this.cost,
        this.roomID});

  UpdateOrderRequest.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    touristUserID = json['touristUserID'];
    guidUserID = json['guidUserID'];
    city = json['city'];
    language = json['language'];
    arriveDate = json['arriveDate'];
    leaveDate = json['leaveDate'];
    status = json['status'];
    services = json['services'].cast<String>();
    id = json['id'];
    cost = json['cost'];
    roomID = json['roomID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['touristUserID'] = this.touristUserID;
    data['guidUserID'] = this.guidUserID;
    data['city'] = this.city;
    data['language'] = this.language;
    data['arriveDate'] = this.arriveDate;
    data['leaveDate'] = this.leaveDate;
    data['status'] = this.status;
    data['services'] = this.services;
    data['orderID'] = this.id;
    data['cost'] = this.cost;
    data['roomID'] = this.roomID;
    return data;
  }
}
