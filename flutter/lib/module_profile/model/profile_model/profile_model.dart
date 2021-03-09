class ProfileModel {
  String name;
  String image;
  List<String> locations = <String>[];
  List<String> languages = <String>[];

  ProfileModel({this.name, this.image, this.locations, this.languages});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = this.name;
    data['image'] = this.image;
    data['languages'] = languages;
    data['cities'] = locations;
    return data;
  }
}
