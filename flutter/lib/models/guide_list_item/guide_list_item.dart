class GuideListItemModel {
  String user;
  String userID;
  String name;
  String status;
  List<String> city;
  List<String> language;
  double rating;
  String image;

  GuideListItemModel(
      {this.user,
        this.name,
        this.status,
        this.city,
        this.language,
        this.rating,
        this.image});

  GuideListItemModel.fromJson(Map<String, dynamic> json) {
    user = json['user'];
    name = json['name'];
    userID = json['userID'];
    status = json['status'];
    city = json['city'].cast<String>();
    language = json['language'].cast<String>();
    rating = json['rating'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user'] = this.user;
    data['name'] = this.name;
    data['status'] = this.status;
    data['userID'] = userID;
    data['city'] = this.city;
    data['language'] = this.language;
    data['rating'] = this.rating;
    data['image'] = this.image;
    return data;
  }
}