class ProfileResponse {
  String user;
  String userID;
  String name;
  String status;
  List<String> city;
  List<String> language;
  double rating;
  ApiImage image;

  ProfileResponse(
      {this.user,
        this.userID,
        this.name,
        this.status,
        this.city,
        this.language,
        this.rating,
        this.image});

  ProfileResponse.fromJson(Map<String, dynamic> json) {
    user = json['user'];
    userID = json['userID'];
    name = json['name'];
    status = json['status'];
    city = json['city'].cast<String>();
    language = json['language'].cast<String>();
    rating = json['rating'];
    image = json['image'] != null ? new ApiImage.fromJson(json['image']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user'] = this.user;
    data['userID'] = this.userID;
    data['name'] = this.name;
    data['status'] = this.status;
    data['city'] = this.city;
    data['language'] = this.language;
    data['rating'] = this.rating;
    if (this.image != null) {
      data['image'] = this.image.toJson();
    }
    return data;
  }
}

class ApiImage {
  String path;

  ApiImage({this.path});

  ApiImage.fromJson(Map<String, dynamic> json) {
    path = json['path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['path'] = this.path;
    return data;
  }
}