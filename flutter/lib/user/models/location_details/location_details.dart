class LocationDetailsModel {
  int id;
  String name;
  String description;
  List<String> location;
  List<String> comments;
  Null ratingAverage;
  List<Paths> paths;

  LocationDetailsModel(
      {this.id,
        this.name,
        this.description,
        this.location,
        this.comments,
        this.ratingAverage,
        this.paths});

  LocationDetailsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    location = json['location'].cast<String>();
    ratingAverage = json['ratingAverage'];
    if (json['paths'] != null) {
      paths = new List<Paths>();
      json['paths'].forEach((v) {
        paths.add(new Paths.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['location'] = this.location;
    data['ratingAverage'] = this.ratingAverage;
    if (this.paths != null) {
      data['paths'] = this.paths.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Paths {
  String path;

  Paths({this.path});

  Paths.fromJson(Map<String, dynamic> json) {
    path = json['path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['path'] = this.path;
    return data;
  }
}