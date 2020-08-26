import 'package:tourists/module_locations/model/location_list_item/location_list_item.dart';

class LocationListResponse {
  String statusCode;
  String msg;
  List<LocationListItem> locationList;

  LocationListResponse({this.statusCode, this.msg, this.locationList});

  LocationListResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    msg = json['msg'];
    if (json['data'] != null) {
      locationList = <LocationListItem>[];
      json['data'].forEach((v) {
        locationList.add(new LocationListItem.fromJson(v));
      });
    }
  }
}
