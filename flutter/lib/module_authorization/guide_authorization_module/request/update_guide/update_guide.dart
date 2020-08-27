class UpdateGuideRequest {
  String user;
  String name;
  List<String> language;
  List<String> city;
  String phoneNumber;
  String status;
  String about;
  int cost;
  List<String> service;
  String path;

  UpdateGuideRequest(
      {this.user,
      this.name,
      this.language,
      this.city,
      this.phoneNumber,
      this.status,
      this.about,
      this.cost,
      this.service,
      this.path});

  UpdateGuideRequest.fromJson(Map<String, dynamic> json) {
    user = json['user'];
    name = json['name'];
    language = json['language'].cast<String>();
    city = json['city'].cast<String>();
    phoneNumber = json['phoneNumber'];
    status = json['status'];
    about = json['about'];
    cost = json['cost'];
    service = json['service'].cast<String>();
    path = json['path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user'] = this.user;
    data['name'] = this.name;
    data['language'] = this.language;
    data['city'] = this.city;
    data['phoneNumber'] = this.phoneNumber;
    data['status'] = this.status;
    data['about'] = this.about;
    data['cost'] = this.cost;
    data['service'] = this.service;
    data['path'] = this.path;
    return data;
  }
}
