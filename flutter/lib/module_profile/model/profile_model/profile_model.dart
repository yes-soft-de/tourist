import 'package:tourists/module_locations/model/location_list_item/location_list_item.dart';

class ProfileModel {
  String name;
  String image;
  List<String> locations = <String>[];
  List<String> languages = <String>[];
  List<LocationListItem> availableLocations = <LocationListItem>[];

  ProfileModel({this.name, this.image, this.locations, this.languages, this.availableLocations}) {
    if (this.languages == null) {
      this.languages = [];
    }
    if (this.locations == null) {
      this.locations = [];
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
