class ProfileModel {
  String name;
  String image;
  List<String> locations = <String>[];
  List<String> languages = <String>[];

  ProfileModel({this.name, this.image, this.locations, this.languages});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
    if (json['languages'] != null) {
      List<String> cities = json['languages'].cast<String>();
      languages = [];
      cities.forEach((element) {
        languages.add(element);
      });
    } else {
      languages = <String>[];
    }
    if (json['city'] != null) {
      List<String> cities = json['city'].cast<String>();
      locations = [];
      cities.forEach((element) {
        locations.add(element);
      });
    } else {
      locations = <String>[];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = this.name;
    data['image'] = this.image;
    data['languages'] = languages;
    data['cities'] = locations;
    return data;
  }
}
