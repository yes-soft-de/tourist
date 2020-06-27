import 'package:tourists/user/models/location_list_item/location_list_item.dart';

class LocationListResponse {
  int statusCode;
  String msg;
  List<LocationListItem> locationList;

  LocationListResponse({this.statusCode, this.msg, this.locationList});
  
  fromJson(Map<String, dynamic> jsonObject) {
    // TODO: Implement This!
  }
}
