class LocationListItem {
  int id;
  String name;
  String description;
  List<String> location;
  String commentNumber;
  Null ratingAverage;
  List<Path> path;

  LocationListItem(
      {this.id,
        this.name,
        this.description,
        this.location,
        this.commentNumber,
        this.ratingAverage,
        this.path});

  LocationListItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    location = json['location'].cast<String>();
    commentNumber = json['commentNumber'];
    ratingAverage = json['ratingAverage'];
    if (json['path'] != null) {
      path = new List<Path>();
      json['path'].forEach((v) {
        path.add(new Path.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['location'] = this.location;
    data['commentNumber'] = this.commentNumber;
    data['ratingAverage'] = this.ratingAverage;
    if (this.path != null) {
      data['path'] = this.path.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Path {
  String path;

  Path({this.path});

  Path.fromJson(Map<String, dynamic> json) {
    path = json['path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['path'] = this.path;
    return data;
  }
}